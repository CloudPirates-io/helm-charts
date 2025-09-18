#!/bin/bash

# Helper script to create CHANGELOGS for all charts bases on the commit messages and existing tags
# @see https://github.com/conventional-changelog/conventional-changelog

set -euo pipefail

CHARTS=($(find ./charts -mindepth 1 -maxdepth 1 -type d ! -name 'charts' ! -name 'common' -exec basename {} \;))
if [ ${#CHARTS[@]} -gt 0 ]; then
    for CHART in "${CHARTS[@]}"; do
        echo "Generating changelog for $CHART..."
        # Generate full changelog with conventional-changelog
        conventional-changelog -i "charts/${CHART}/CHANGELOG.md" -s -t "${CHART}-" -r 0 --commit-path "charts/${CHART}"
        
        # Get chart version and current date
        CHART_VERSION=$(yq eval '.version' "charts/${CHART}/Chart.yaml")
	UPPER_CHART=$(echo "$CHART" | tr '[:lower:]' '[:upper:]')

	# Remove chart tags
	sed -i -E "s/\* \[(${CHART}|${UPPER_CHART})\] /\* /g" "charts/${CHART}/CHANGELOG.md"

	# Update latest version header
	sed -i -E "s/##\s+(\([0-9-]+\))/## <small>$CHART_VERSION \1<\/small>/" "charts/${CHART}/CHANGELOG.md"

	# Add "Changelog" header
	if ! grep -q "^# Changelog" "charts/${CHART}/CHANGELOG.md"; then
	    sed -i '1i# Changelog\n' "charts/${CHART}/CHANGELOG.md"
	fi

	# Remove trailing newlines
	sed -i -E ':a;/^[[:space:]]*$/{$d;N;ba}' "charts/${CHART}/CHANGELOG.md"
    done
else
    echo -e "Failed to find charts"
    exit 1
fi
