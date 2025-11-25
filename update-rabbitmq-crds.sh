#!/bin/bash

set -euo pipefail

# This script updates the RabbitMQ CRDs from their source repositories.
# It can automatically discover the required versions from the Helm chart's
# values.yaml file, or you can override them with command-line arguments.
#
# Usage:
# ./update-rabbitmq-crds.sh [<cluster-operator-version> <messaging-topology-operator-version>]
#
# Example (automatic version discovery):
# ./update-rabbitmq-crds.sh
#
# Example (manual version override):
# ./update-rabbitmq-crds.sh 2.7.0 1.18.1

# --- Script setup and dependency checks ---

# Ensure the script is run from the project root
if [ ! -d "charts" ]; then
  echo "Please run this script from the root of the helm-charts repository."
  exit 1
fi

# Check for jq and yq dependencies
if ! command -v jq &>/dev/null; then
  echo "Error: jq is not installed. Please install it to run this script."
  echo "e.g., on macOS: brew install jq"
  exit 1
fi
if ! command -v yq &>/dev/null; then
  echo "Error: yq is not installed. Please install it to run this script."
  echo "e.g., on macOS: brew install yq"
  exit 1
fi

# --- Version discovery and processing ---

VALUES_FILE="charts/rabbitmq-cluster-operator/values.yaml"
CLUSTER_OPERATOR_VERSION_RAW=""
MESSAGING_TOPOLOGY_OPERATOR_VERSION_RAW=""

# Function to extract and clean version from a YAML file
get_version_from_yaml() {
  local yaml_path=$1
  local values_file=$2
  # Extract the tag, remove potential 'v' prefix, and strip any suffix (e.g., -debian)
  yq e "${yaml_path}" "${values_file}" | sed 's/^v//' | sed 's/-.*//'
}

# Check arguments: if none are provided, discover versions from values.yaml
if [ "$#" -eq 0 ]; then
  echo "No versions provided, extracting from '${VALUES_FILE}'..."
  if [ ! -f "$VALUES_FILE" ]; then
    echo "Error: Default values file not found at '${VALUES_FILE}'"
    exit 1
  fi
  CLUSTER_OPERATOR_VERSION_RAW=$(get_version_from_yaml '.clusterOperator.image.tag' "$VALUES_FILE")
  MESSAGING_TOPOLOGY_OPERATOR_VERSION_RAW=$(get_version_from_yaml '.msgTopologyOperator.image.tag' "$VALUES_FILE")
  echo "Found versions: Cluster Operator='${CLUSTER_OPERATOR_VERSION_RAW}', Messaging Topology Operator='${MESSAGING_TOPOLOGY_OPERATOR_VERSION_RAW}'"
elif [ "$#" -ne 2 ]; then
  echo "Error: Invalid number of arguments."
  echo "Usage: $0 [<cluster-operator-version> <messaging-topology-operator-version>]"
  echo "If no versions are provided, they will be extracted from '${VALUES_FILE}'."
  exit 1
fi

# Use provided arguments or the discovered versions as default
# Also, ensure versions are prefixed with 'v' for the URL
add_v_prefix() {
  local version=$1
  if [[ ! "$version" =~ ^v ]]; then
    echo "v$version"
  else
    echo "$version"
  fi
}

CLUSTER_OPERATOR_VERSION=$(add_v_prefix "${1:-$CLUSTER_OPERATOR_VERSION_RAW}")
MESSAGING_TOPOLOGY_OPERATOR_VERSION=$(add_v_prefix "${2:-$MESSAGING_TOPOLOGY_OPERATOR_VERSION_RAW}")

echo ""
echo "Proceeding with versions:"
echo "Cluster Operator version: $CLUSTER_OPERATOR_VERSION"
echo "Messaging Topology Operator version: $MESSAGING_TOPOLOGY_OPERATOR_VERSION"

# --- CRD Update Logic ---

# --- Cluster Operator CRDs ---
CLUSTER_CRD_DIR="charts/rabbitmq-cluster-operator/crds/rabbitmq-cluster"
CLUSTER_BASE_URL="https://raw.githubusercontent.com/rabbitmq/cluster-operator/${CLUSTER_OPERATOR_VERSION}/config/crd/bases"
CLUSTER_API_URL="https://api.github.com/repos/rabbitmq/cluster-operator/contents/config/crd/bases?ref=${CLUSTER_OPERATOR_VERSION}"

echo ""
echo "Updating Cluster Operator CRDs..."

CLUSTER_CRDS=()
while IFS= read -r line; do
  if [ -n "$line" ]; then
    CLUSTER_CRDS+=("$line")
  fi
done < <(curl -sSLf "${CLUSTER_API_URL}" | jq -r '.[].name' | grep '^rabbitmq.com_.*\.yaml$' || true)

if [ ${#CLUSTER_CRDS[@]} -eq 0 ]; then
  echo "Warning: Could not find any CRDs for Cluster Operator at ${CLUSTER_API_URL}"
fi

for crd in "${CLUSTER_CRDS[@]}"; do
  URL="${CLUSTER_BASE_URL}/${crd}"
  FILE_PATH="${CLUSTER_CRD_DIR}/${crd}"
  echo "  -> Downloading ${crd} from ${URL}"

  TMP_FILE_NEW=$(mktemp)
  if ! curl -sSLf "${URL}" >"${TMP_FILE_NEW}"; then
    echo "    ERROR: Failed to download ${crd} from ${URL}"
    rm "${TMP_FILE_NEW}"
    continue
  fi

  # For 'rabbitmq.com_rabbitmqclusters.yaml', prepend only the generated-from comment,
  # as the downloaded file already contains the full copyright header.
  if [ "${crd}" == "rabbitmq.com_rabbitmqclusters.yaml" ]; then
    TMP_FINAL=$(mktemp)
    echo "# Generated from: ${URL}" >"${TMP_FINAL}"
    cat "${TMP_FILE_NEW}" >>"${TMP_FINAL}"
    mv "${TMP_FINAL}" "${FILE_PATH}"
  else
    # For any other cluster operator CRDs (if they appear), use the simpler header
    # and assume the downloaded content does NOT start with '---'.
    {
      echo "# Generated from: ${URL}"
      echo "---"
      cat "${TMP_FILE_NEW}"
    } >"${FILE_PATH}"
  fi
  rm "${TMP_FILE_NEW}"
done

# --- Messaging Topology Operator CRDs ---
MESSAGING_CRD_DIR="charts/rabbitmq-cluster-operator/crds/messaging-topology-operator"
MESSAGING_BASE_URL="https://raw.githubusercontent.com/rabbitmq/messaging-topology-operator/${MESSAGING_TOPOLOGY_OPERATOR_VERSION}/config/crd/bases"
MESSAGING_API_URL="https://api.github.com/repos/rabbitmq/messaging-topology-operator/contents/config/crd/bases?ref=${MESSAGING_TOPOLOGY_OPERATOR_VERSION}"

echo ""
echo "Updating Messaging Topology Operator CRDs..."

MESSAGING_CRDS=()
while IFS= read -r line; do
  if [ -n "$line" ]; then
    MESSAGING_CRDS+=("$line")
  fi
done < <(curl -sSLf "${MESSAGING_API_URL}" | jq -r '.[].name' | grep '^rabbitmq.com_.*\.yaml$' || true)

if [ ${#MESSAGING_CRDS[@]} -eq 0 ]; then
  echo "Warning: Could not find any CRDs for Messaging Topology Operator at ${MESSAGING_API_URL}"
fi

for crd in "${MESSAGING_CRDS[@]}"; do
  URL="${MESSAGING_BASE_URL}/${crd}"
  FILE_PATH="${MESSAGING_CRD_DIR}/${crd}"
  echo "  -> Downloading ${crd} from ${URL}"

  # For Messaging Topology Operator CRDs, the downloaded content already starts with '---',
  # so we only prepend our generated-from comment.
  if ! {
    echo "# Generated from: ${URL}"
    curl -sSLf "${URL}"
  } >"${FILE_PATH}"; then
    echo "    ERROR: Failed to download or write ${crd}"
  fi
done

echo ""
echo "CRD update complete."
