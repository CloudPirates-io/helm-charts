#!/bin/bash

# Local chart testing script using kind
# Usage: ./test-chart-locally.sh [chart-name]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
CHARTS_DIR="${SCRIPT_DIR}/charts"

# Colors for output
RED='\033[1;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[1;36m'
NC='\033[0m' # No Color

# Default values
KIND_CLUSTER_NAME="helm-chart-test"
CHART_NAME=""
CLEANUP=true
CREATE_CLUSTER=false
SKIP_INSTALL=false

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --no-cleanup)
            CLEANUP=false
            shift
            ;;
        --create-cluster)
            CREATE_CLUSTER=true
            shift
            ;;
        --skip-install)
            SKIP_INSTALL=true
            shift
            ;;
        --cluster-name)
            KIND_CLUSTER_NAME="$2"
            shift 2
            ;;
        -h|--help)
            echo "Usage: $0 [OPTIONS] [CHART_NAME]"
            echo ""
            echo "Options:"
            echo "  --no-cleanup            Don't delete the kind cluster after testing"
            echo "  --create-cluster        Create a new kind cluster (default: use existing)"
            echo "  --cluster-name          Name for the kind cluster (default: helm-chart-test)"
            echo "  --skip-install          Skip chart installation (only run linting and templating)"
            echo "  -h, --help              Show this help message"
            echo ""
            echo "If no chart name is provided, all charts will be tested sequentially."
            exit 0
            ;;
        *)
            if [ -z "$CHART_NAME" ]; then
                CHART_NAME="$1"
            else
                echo "Unknown argument: $1"
                exit 1
            fi
            shift
            ;;
    esac
done

# Check prerequisites
check_prerequisites() {
    echo -e "${BLUE}🔍 Checking prerequisites...${NC}"
    
    if ! command -v kind &> /dev/null; then
        echo -e "${RED}❌ kind is not installed. Please install it first.${NC}"
        echo "   Installation: https://kind.sigs.k8s.io/docs/user/quick-start/#installation"
        exit 1
    fi
    
    if ! command -v kubectl &> /dev/null; then
        echo -e "${RED}❌ kubectl is not installed. Please install it first.${NC}"
        exit 1
    fi
    
    if ! command -v helm &> /dev/null; then
        echo -e "${RED}❌ helm is not installed. Please install it first.${NC}"
        exit 1
    fi
    
    if ! command -v docker &> /dev/null; then
        echo -e "${RED}❌ docker is not running or installed.${NC}"
        exit 1
    fi

    if ! helm plugin list | grep -q unittest; then
        echo -e "${YELLOW}⚠️  helm-unittest plugin not found. Installing...${NC}"
        helm plugin install https://github.com/helm-unittest/helm-unittest --verify=false
    fi
    
    echo -e "${GREEN}✅ All prerequisites are met${NC}"
}

# Create kind cluster
create_cluster() {
    echo -e "${BLUE}🚀 Creating kind cluster: $KIND_CLUSTER_NAME${NC}"
    
    if kind get clusters | grep -q "^$KIND_CLUSTER_NAME$"; then
        echo -e "${YELLOW}⚠️  Cluster $KIND_CLUSTER_NAME already exists. Deleting...${NC}"
        kind delete cluster --name "$KIND_CLUSTER_NAME"
    fi
    
    cat <<EOF > /tmp/kind-config.yaml
kind: Cluster
apiVersion: kind.x-k8s.io/v1alpha4
nodes:
- role: control-plane
  kubeadmConfigPatches:
  - |
    kind: InitConfiguration
    nodeRegistration:
      kubeletExtraArgs:
        node-labels: "ingress-ready=true"
  extraPortMappings:
  - containerPort: 80
    hostPort: 9080
    protocol: TCP
  - containerPort: 443
    hostPort: 9443
    protocol: TCP
EOF
    
    kind create cluster --name "$KIND_CLUSTER_NAME" --config /tmp/kind-config.yaml --wait 300s
    kubectl cluster-info --context "kind-$KIND_CLUSTER_NAME"
    
    echo -e "${GREEN}✅ Cluster created successfully${NC}"
}

# Test a single chart
test_chart() {
    local chart=$1
    local chart_path="${CHARTS_DIR}/${chart}"
    
    if [ ! -d "$chart_path" ]; then
        echo -e "${RED}❌ Chart directory not found: $chart_path${NC}"
        return 1
    fi
    
    echo -e "\n${BLUE}🧪 Testing chart: $chart${NC}"
    echo "================================="
    cd "$chart_path"
    
    # Update dependencies based on Chart.yaml
    echo "📦 Building dependencies..."
    helm dependency build --skip-refresh
    
    # Lint chart
    echo "🔍 Linting chart..."
    if ! helm lint .; then
        echo -e "${RED}❌ Chart lint failed for $chart${NC}"
        return 1
    fi
    
    # For library charts, we can't do much more than linting and unit tests.
    if grep -q "type: library" Chart.yaml; then
        echo -e "${YELLOW}ℹ️  Library chart detected. Skipping installation tests.${NC}"

        # Helm unittest (if tests exist and not disabled)
        if [ -f ".disable-unittest" ]; then
            echo -e "${YELLOW}ℹ️  Unittest disabled for $chart (.disable-unittest found)${NC}"
        elif [ -d "tests" ] && [ "$(ls -A tests 2>/dev/null)" ]; then
            echo "🧪 Running Helm unittest..."
            if ! helm unittest .; then
                echo -e "${RED}❌ Helm unittest failed for $chart${NC}"
                return 1
            fi
        else
            echo -e "${YELLOW}ℹ️  No unittest tests found for $chart${NC}"
        fi

        echo -e "${GREEN}✅ Chart $chart (library) tested successfully${NC}"
        cd "$SCRIPT_DIR"
        return 0
    fi
    
    # Helm unittest (if tests exist and not disabled) - runs once per chart, not per scenario
    if [ -f ".disable-unittest" ]; then
        echo -e "${YELLOW}ℹ️  Unittest disabled for $chart (.disable-unittest found)${NC}"
    elif [ -d "tests" ] && [ "$(ls -A tests 2>/dev/null)" ]; then
        echo "🧪 Running Helm unittest..."
        if ! helm unittest .; then
            echo -e "${RED}❌ Helm unittest failed for $chart${NC}"
            return 1
        fi
    else
        echo -e "${YELLOW}ℹ️  No unittest tests found for $chart${NC}"
    fi

    # Collect scenarios: one per ci/*.yaml file (excluding *.secrets.yaml and
    # *.verify.yaml companions). If no ci/ values files exist, run a single
    # "default" scenario with chart defaults.
    local scenario_files=()
    if [ -d "ci" ] && [ "$(ls -A ci/*.yaml 2>/dev/null)" ]; then
        for values_file in ci/*.yaml; do
            [[ "$values_file" == *.secrets.yaml || "$values_file" == *.verify.yaml ]] && continue
            scenario_files+=("$values_file")
        done
    fi
    if [ ${#scenario_files[@]} -eq 0 ]; then
        scenario_files=("")
    fi

    echo -e "\n${BLUE}📋 Running ${#scenario_files[@]} scenario(s) for $chart:${NC}"
    for f in "${scenario_files[@]}"; do
        echo "   • $(basename "${f:-default}" .yaml)"
    done

    local chart_failed=0
    for values_file in "${scenario_files[@]}"; do
        if ! run_scenario "$chart" "$values_file"; then
            chart_failed=1
        fi
    done

    cd "$SCRIPT_DIR"
    return $chart_failed
}

# Print each container's restart count and last termination reason, to make
# flaky/crash-looping pods visible even when a scenario ultimately fails elsewhere.
print_restart_summary() {
    local namespace=$1
    echo -e "${YELLOW}📋 Container restart counts and last state:${NC}"
    kubectl get pods -n "$namespace" \
        -o jsonpath='{range .items[*]}{.metadata.name}{"\n"}{range .status.containerStatuses[*]}  - {.name}: restarts={.restartCount} lastState={.lastState.terminated.reason}{"\n"}{end}{end}' \
        2>/dev/null
}

# Snapshot of "<pod>/<container>=<restartCount>" pairs, used to detect whether any
# container restarted during a stability window (a pod can be Ready for one instant
# while still crash-looping around that snapshot).
get_restart_counts() {
    local namespace=$1
    kubectl get pods -n "$namespace" \
        -o jsonpath='{range .items[*]}{.metadata.uid}{range .status.containerStatuses[*]}/{.name}={.restartCount}{"\n"}{end}{end}' \
        2>/dev/null | sort
}

# Test a single CI scenario (one ci/*.yaml values file) for a chart.
# Must be called with the chart directory as the current working directory.
run_scenario() {
    local chart=$1
    local values_file=$2
    local scenario_name
    scenario_name=$(basename "${values_file:-default}" .yaml)

    echo -e "\n${BLUE}▶️  Scenario: $chart / $scenario_name${NC}"
    echo "-----------------------------------"

    local values_args=""
    [ -n "$values_file" ] && values_args="-f $values_file"

    # Test template rendering
    echo "📝 Testing template rendering..."
    if ! helm template "test-$chart-$scenario_name" . $values_args --debug > "/tmp/rendered-$chart-$scenario_name.yaml"; then
        echo -e "${RED}❌ Template rendering failed for $chart/$scenario_name${NC}"
        return 1
    fi

    # Validate YAML
    if ! kubectl apply --dry-run=client -f "/tmp/rendered-$chart-$scenario_name.yaml" >/dev/null; then
        echo -e "${RED}❌ Generated YAML validation failed for $chart/$scenario_name${NC}"
        return 1
    fi

    if [ "$SKIP_INSTALL" = true ]; then
        echo -e "${YELLOW}⏩ Skipping chart installation (--skip-install flag used)${NC}"
        echo -e "${GREEN}✅ Scenario $chart/$scenario_name passed (linting and templating only)${NC}"
        return 0
    fi

    # Install chart
    local namespace="test-$chart-$scenario_name"
    local release_name="test-$chart-$scenario_name"

    echo "📦 Creating namespace..."
    kubectl create namespace "$namespace" --dry-run=client -o yaml | kubectl apply -f - >/dev/null

    # Apply any companion manifest (e.g. ACL secrets) this scenario depends on.
    # Convention: ci/<scenario>.secrets.yaml sits next to ci/<scenario>.yaml.
    local secrets_file="${values_file%.yaml}.secrets.yaml"
    if [ -n "$values_file" ] && [ -f "$secrets_file" ]; then
        echo "🔐 Applying companion manifest: $secrets_file"
        if ! kubectl apply -n "$namespace" -f "$secrets_file"; then
            echo -e "${RED}❌ Failed to apply companion manifest $secrets_file${NC}"
            kubectl delete namespace "$namespace" --ignore-not-found=true --timeout=60s || true
            return 1
        fi
    fi

    echo "🚀 Installing chart..."
    echo "   Release: $release_name"
    echo "   Namespace: $namespace"
    echo "   Timeout: 600s"
    if [ -n "$values_args" ]; then
        echo "   Values file: $values_file"
    fi
    echo ""

    # Retry once on install failure: "helm install --wait" can fail on a freshly-created
    # cluster with a spurious "resource ... not ready: status: NotFound" for objects like
    # ServiceAccounts that have no real readiness semantics - a read-after-write race against
    # the API server/etcd, not a chart problem. A clean retry reliably clears it.
    local install_attempt=1
    local install_ok=false
    while [ $install_attempt -le 2 ]; do
        if helm install "$release_name" . \
            $values_args \
            --namespace "$namespace" \
            --wait \
            --timeout=600s \
            --debug; then
            install_ok=true
            break
        fi

        echo -e "${YELLOW}⚠️  Install attempt $install_attempt failed for $chart/$scenario_name${NC}"
        if [ $install_attempt -lt 2 ]; then
            echo "   Retrying once (uninstalling first in case of a partial install)..."
            helm uninstall "$release_name" -n "$namespace" --wait --timeout=120s >/dev/null 2>&1 || true
            sleep 5
        fi
        install_attempt=$((install_attempt + 1))
    done

    if [ "$install_ok" != true ]; then
        echo -e "${RED}❌ Chart installation failed for $chart/$scenario_name (after retry)${NC}"
        echo -e "\n${YELLOW}📋 Checking resources in namespace...${NC}"
        kubectl get all -n "$namespace" || true
        kubectl describe pods -n "$namespace" || true
        echo -e "\n${YELLOW}📋 Recent events:${NC}"
        kubectl get events -n "$namespace" --sort-by='.lastTimestamp' || true
        print_restart_summary "$namespace"
        kubectl delete namespace "$namespace" --ignore-not-found=true --timeout=60s || true
        return 1
    fi

    # Verify installation
    echo "🔍 Verifying installation..."
    helm list -n "$namespace"
    kubectl get all -n "$namespace"

    # Wait for pods to be ready (with timeout)
    echo "⏳ Waiting for pods to be ready..."

    # Show pod status while waiting
    local max_wait=300
    local elapsed=0
    local interval=10
    local scenario_failed=0

    while [ $elapsed -lt $max_wait ]; do
        echo "   [$elapsed/${max_wait}s] Checking pod status..."
        kubectl get pods -n "$namespace" -o wide

        # Check if all pods are ready
        if kubectl wait --for=condition=Ready pods --all -n "$namespace" --timeout=1s 2>/dev/null; then
            echo -e "${GREEN}✅ All pods are ready${NC}"
            break
        fi

        # Show recent events for debugging
        echo "   Recent events:"
        kubectl get events -n "$namespace" --sort-by='.lastTimestamp' | tail -5

        sleep $interval
        elapsed=$((elapsed + interval))
    done

    if [ $elapsed -ge $max_wait ]; then
        echo -e "${YELLOW}⚠️  Timeout waiting for pods. Current status:${NC}"
        kubectl get pods -n "$namespace" -o wide
        kubectl describe pods -n "$namespace"
        print_restart_summary "$namespace"
        scenario_failed=1
    fi

    # Stability check: a pod can report Ready in the single instant this loop happened
    # to poll it, then immediately crash-loop. Require restart counts to stay flat for
    # a short window before trusting "Ready" as a real pass.
    if [ "$scenario_failed" -eq 0 ]; then
        echo "🩺 Checking pod stability (watching for restarts over 20s)..."
        local restarts_before restarts_after
        restarts_before=$(get_restart_counts "$namespace")
        sleep 20
        restarts_after=$(get_restart_counts "$namespace")
        if [ "$restarts_before" != "$restarts_after" ]; then
            echo -e "${RED}❌ Container(s) restarted during the stability window for $chart/$scenario_name${NC}"
            echo "   Restart counts before:"
            echo "$restarts_before" | sed 's/^/     /'
            echo "   Restart counts after:"
            echo "$restarts_after" | sed 's/^/     /'
            print_restart_summary "$namespace"
            scenario_failed=1
        else
            echo -e "${GREEN}✅ Pods stable, no restarts in the last 20s${NC}"
        fi
    fi

    # Functional verification: convention ci/<scenario>.verify.yaml (a Job manifest).
    # Applied into the scenario's namespace and run to completion. Lets a scenario prove
    # real functionality (e.g. that ACL auth actually works end-to-end) instead of trusting
    # probe/Ready status alone, which only proves the probe command exited 0 - it can pass
    # even when the feature under test is misconfigured.
    if [ "$scenario_failed" -eq 0 ] && [ -n "$values_file" ]; then
        local verify_manifest="${values_file%.yaml}.verify.yaml"
        if [ -f "$verify_manifest" ]; then
            echo "🔬 Running functional verification: $verify_manifest"
            if ! kubectl apply -n "$namespace" -f "$verify_manifest"; then
                echo -e "${RED}❌ Failed to apply functional verification manifest $verify_manifest${NC}"
                scenario_failed=1
            elif ! kubectl wait --for=condition=complete job -l test-charts.io/verify=true -n "$namespace" --timeout=120s; then
                echo -e "${RED}❌ Functional verification failed for $chart/$scenario_name${NC}"
                echo "   Verify job logs:"
                kubectl logs -n "$namespace" -l test-charts.io/verify=true --all-containers --tail=200 2>&1 | sed 's/^/     /' || true
                print_restart_summary "$namespace"
                scenario_failed=1
            else
                echo -e "${GREEN}✅ Functional verification passed${NC}"
                kubectl logs -n "$namespace" -l test-charts.io/verify=true --all-containers --tail=200 2>&1 | sed 's/^/     /' || true
            fi
            kubectl delete -n "$namespace" -f "$verify_manifest" --ignore-not-found=true --timeout=30s >/dev/null 2>&1 || true
        fi
    fi

    # Run tests if they exist
    if [ -d "tests" ] && [ "$(ls -A tests 2>/dev/null)" ]; then
        echo "🧪 Running Helm tests..."
        if ! helm test "$release_name" -n "$namespace" --timeout=300s; then
            echo -e "${YELLOW}⚠️  Helm tests failed for $chart/$scenario_name (continuing anyway)${NC}"
        fi
    else
        echo -e "${YELLOW}ℹ️  No Helm tests found for $chart/$scenario_name${NC}"
    fi

    # Test upgrade (also exercises rolling-update lifecycle hooks, e.g. preStop)
    echo "🔄 Testing chart upgrade..."
    if ! helm upgrade "$release_name" . $values_args -n "$namespace" --wait --timeout=300s; then
        echo -e "${YELLOW}⚠️  Chart upgrade failed for $chart/$scenario_name${NC}"
        print_restart_summary "$namespace"
        scenario_failed=1
    fi

    # Uninstall
    echo "🗑️  Uninstalling chart..."
    helm uninstall "$release_name" -n "$namespace" --wait --timeout=300s || true
    kubectl delete namespace "$namespace" --ignore-not-found=true --timeout=60s || true

    if [ "$scenario_failed" -ne 0 ]; then
        echo -e "${RED}❌ Scenario $chart/$scenario_name failed${NC}"
        return 1
    fi

    echo -e "${GREEN}✅ Scenario $chart/$scenario_name passed${NC}"
    return 0
}

# Cleanup function
cleanup() {
    if [ "$CREATE_CLUSTER" = false ]; then
        echo -e "\n${YELLOW}ℹ️  Skipping cleanup (cluster was not created by this script)${NC}"
        return
    fi
    
    if [ "$CLEANUP" = true ]; then
        echo -e "\n${BLUE}🧹 Cleaning up...${NC}"
        kind delete cluster --name "$KIND_CLUSTER_NAME" 2>/dev/null || true
        echo -e "${GREEN}✅ Cleanup completed${NC}"
    else
        echo -e "\n${YELLOW}ℹ️  Skipping cleanup. Cluster $KIND_CLUSTER_NAME is still running.${NC}"
        echo -e "   To delete it manually: ${BLUE}kind delete cluster --name $KIND_CLUSTER_NAME${NC}"
    fi
}

# Main execution
main() {
    check_prerequisites
    
    if [ "$CREATE_CLUSTER" = true ]; then
        create_cluster
        # Set cleanup trap
        trap cleanup EXIT
    else
        echo -e "${YELLOW}⏩ Skipping cluster creation (using existing cluster)${NC}"
        # Verify we can connect to the cluster
        if ! kubectl cluster-info &>/dev/null; then
            echo -e "${RED}❌ Cannot connect to existing cluster. Please ensure kubectl is configured correctly.${NC}"
            exit 1
        fi
        echo -e "${GREEN}✅ Connected to existing cluster${NC}"
        # Only set cleanup trap if we're not skipping cluster creation
        if [ "$CLEANUP" = true ]; then
            echo -e "${YELLOW}ℹ️  Note: --no-cleanup flag is ignored when using --skip-cluster${NC}"
        fi
    fi
    
    if [ -n "$CHART_NAME" ]; then
        # Test single chart
        if test_chart "$CHART_NAME"; then
            echo -e "\n${GREEN}🎉 Chart $CHART_NAME tested successfully!${NC}"
        else
            echo -e "\n${RED}💥 Chart $CHART_NAME testing failed!${NC}"
            exit 1
        fi
    else
        # Test all charts
        CHARTS=($(find "$CHARTS_DIR" -maxdepth 1 -type d ! -name '.' ! -name 'charts' -exec basename {} \; | sort))
        
        if [ ${#CHARTS[@]} -eq 0 ]; then
            echo -e "${RED}❌ No charts found in $CHARTS_DIR${NC}"
            exit 1
        fi
        
        echo -e "\n${GREEN}📋 Found ${#CHARTS[@]} charts to test:${NC}"
        for chart in "${CHARTS[@]}"; do
            echo -e "   ${GREEN}•${NC} $chart"
        done
        
        PASSED_CHARTS=()
        FAILED_CHARTS=()
        
        for chart in "${CHARTS[@]}"; do
            if test_chart "$chart"; then
                PASSED_CHARTS+=("$chart")
            else
                FAILED_CHARTS+=("$chart")
            fi
        done
        
        # Summary
        echo -e "\n📊 Test Summary"
        echo "==============="
        if [ ${#PASSED_CHARTS[@]} -gt 0 ]; then
            echo -e "${GREEN}✅ Passed (${#PASSED_CHARTS[@]}):${NC}"
            for chart in "${PASSED_CHARTS[@]}"; do
                echo -e "   ${GREEN}•${NC} $chart"
            done
        fi
        
        if [ ${#FAILED_CHARTS[@]} -gt 0 ]; then
            echo -e "${RED}❌ Failed (${#FAILED_CHARTS[@]}):${NC}"
            for chart in "${FAILED_CHARTS[@]}"; do
                echo -e "   ${RED}•${NC} $chart"
            done
            exit 1
        fi
        
        echo -e "\n${GREEN}🎉 All charts tested successfully!${NC}"
    fi
}

# Run main function
main "$@"
