#!/bin/bash

# Helm Charts Update Script
# Updates all Helm chart dependencies in the charts/ directory

set -e

CHARTS_DIR="charts"
FAILED_CHARTS=()
SUCCESSFUL_CHARTS=()

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

echo -e "${BLUE}🚀 Starting Helm charts update process...${NC}"
echo

# Check if helm is installed
if ! command -v helm &> /dev/null; then
    echo -e "${RED}❌ Error: helm command not found. Please install Helm first.${NC}"
    exit 1
fi

# Check if charts directory exists
if [ ! -d "$CHARTS_DIR" ]; then
    echo -e "${RED}❌ Error: Charts directory '$CHARTS_DIR' not found.${NC}"
    exit 1
fi

# Get list of chart directories
CHART_DIRS=($(find "$CHARTS_DIR" -mindepth 1 -maxdepth 1 -type d -printf '%f\n' | sort))

if [ ${#CHART_DIRS[@]} -eq 0 ]; then
    echo -e "${YELLOW}⚠️  No chart directories found in $CHARTS_DIR${NC}"
    exit 0
fi

echo -e "${BLUE}Found ${#CHART_DIRS[@]} charts to update:${NC}"
for chart in "${CHART_DIRS[@]}"; do
    echo "  - $chart"
done
echo

# Function to update a single chart
update_chart() {
    local chart_name=$1
    local chart_path="$CHARTS_DIR/$chart_name"

    echo -e "${YELLOW}📦 Updating chart: $chart_name${NC}"

    # Check if Chart.yaml exists
    if [ ! -f "$chart_path/Chart.yaml" ]; then
        echo -e "${RED}  ❌ Chart.yaml not found in $chart_path${NC}"
        FAILED_CHARTS+=("$chart_name (no Chart.yaml)")
        return 1
    fi

    # Change to chart directory
    cd "$chart_path"

    # Update dependencies
    if helm dependency update; then
        echo -e "${GREEN}  ✅ Successfully updated $chart_name${NC}"
        SUCCESSFUL_CHARTS+=("$chart_name")
        cd - > /dev/null
        return 0
    else
        echo -e "${RED}  ❌ Failed to update $chart_name${NC}"
        FAILED_CHARTS+=("$chart_name")
        cd - > /dev/null
        return 1
    fi
}

# Update all charts
for chart in "${CHART_DIRS[@]}"; do
    update_chart "$chart"
    echo
done

# Summary
echo -e "${BLUE}📊 Update Summary:${NC}"
echo -e "${GREEN}✅ Successfully updated: ${#SUCCESSFUL_CHARTS[@]} charts${NC}"
if [ ${#SUCCESSFUL_CHARTS[@]} -gt 0 ]; then
    for chart in "${SUCCESSFUL_CHARTS[@]}"; do
        echo "  - $chart"
    done
fi

echo
echo -e "${RED}❌ Failed to update: ${#FAILED_CHARTS[@]} charts${NC}"
if [ ${#FAILED_CHARTS[@]} -gt 0 ]; then
    for chart in "${FAILED_CHARTS[@]}"; do
        echo "  - $chart"
    done
fi

echo
if [ ${#FAILED_CHARTS[@]} -eq 0 ]; then
    echo -e "${GREEN}🎉 All charts updated successfully!${NC}"
    exit 0
else
    echo -e "${YELLOW}⚠️  Some charts failed to update. Check the errors above.${NC}"
    exit 1
fi