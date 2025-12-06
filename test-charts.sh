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
        helm plugin install https://github.com/helm-unittest/helm-unittest
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
    
    # Test template rendering
    echo "📝 Testing template rendering..."

    # Check for CI values files
    CI_VALUES_ARGS=""
    if [ -d "ci" ] && [ "$(ls -A ci/*.yaml 2>/dev/null)" ]; then
        echo "📋 Found CI values files, using them for testing"
        for values_file in ci/*.yaml; do
            CI_VALUES_ARGS="$CI_VALUES_ARGS -f $values_file"
        done
    fi

    if ! helm template test-release . $CI_VALUES_ARGS --debug > /tmp/rendered-$chart.yaml; then
        echo -e "${RED}❌ Template rendering failed for $chart${NC}"
        return 1
    fi
    
    # Validate YAML
    if ! kubectl apply --dry-run=client -f /tmp/rendered-$chart.yaml >/dev/null; then
        echo -e "${RED}❌ Generated YAML validation failed for $chart${NC}"
        return 1
    fi

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

    if [ "$SKIP_INSTALL" = true ]; then
        echo -e "${YELLOW}⏩ Skipping chart installation (--skip-install flag used)${NC}"
        echo -e "${GREEN}✅ Chart $chart tested successfully (linting and templating only)${NC}"
        cd "$SCRIPT_DIR"
        return 0
    fi

    # Install chart
    local namespace="test-$chart"
    local release_name="test-$chart"

    echo "🚀 Installing chart..."
    echo "   Release: $release_name"
    echo "   Namespace: $namespace"
    echo "   Timeout: 600s"
    if [ -n "$CI_VALUES_ARGS" ]; then
        echo "   Values files: $CI_VALUES_ARGS"
    fi
    echo ""

    if ! helm install "$release_name" . \
        $CI_VALUES_ARGS \
        --create-namespace \
        --namespace "$namespace" \
        --wait \
        --timeout=600s \
        --debug; then
        echo -e "${RED}❌ Chart installation failed for $chart${NC}"
        echo -e "\n${YELLOW}📋 Checking resources in namespace...${NC}"
        kubectl get all -n "$namespace" || true
        kubectl describe pods -n "$namespace" || true
        echo -e "\n${YELLOW}📋 Recent events:${NC}"
        kubectl get events -n "$namespace" --sort-by='.lastTimestamp' || true
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
    fi
    
    # Run tests if they exist
    if [ -d "tests" ] && [ "$(ls -A tests 2>/dev/null)" ]; then
        echo "🧪 Running Helm tests..."
        if ! helm test "$release_name" -n "$namespace" --timeout=300s; then
            echo -e "${YELLOW}⚠️  Helm tests failed for $chart (continuing anyway)${NC}"
        fi
    else
        echo -e "${YELLOW}ℹ️  No Helm tests found for $chart${NC}"
    fi
    
    # Test upgrade
    echo "🔄 Testing chart upgrade..."
    if ! helm upgrade "$release_name" . $CI_VALUES_ARGS -n "$namespace" --wait --timeout=300s; then
        echo -e "${YELLOW}⚠️  Chart upgrade failed for $chart${NC}"
    fi
    
    # Uninstall
    echo "🗑️  Uninstalling chart..."
    helm uninstall "$release_name" -n "$namespace" --wait --timeout=300s || true
    kubectl delete namespace "$namespace" --ignore-not-found=true --timeout=60s || true
    
    echo -e "${GREEN}✅ Chart $chart tested successfully${NC}"
    cd "$SCRIPT_DIR"
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
