#!/bin/bash

# Helper script to create CHANGELOGS for all charts bases on the commit messages and existing tags
# @see https://github.com/conventional-changelog/conventional-changelog

CHARTS=($(find ./charts -maxdepth 1 -type d ! -name '.' ! -name 'charts' ! -name 'common' -exec basename {} \;))
if [ ${#CHARTS[@]} -gt 0 ]; then
    for CHART in "${CHARTS[@]}"; do
        echo -e "$CHART"
        # Generate full changelog with conventional-changelog
        conventional-changelog -i charts/${CHART}/CHANGELOG.md -s -t "${CHART}-" -r 0 --commit-path charts/${CHART}
        
        # Get chart version and current date
        CHART_VERSION=$(yq eval '.version' "charts/${CHART}/Chart.yaml")
        CURRENT_DATE=$(date +'%Y-%m-%d')
        
        # Extract all commit entries (lines starting with *) and remove chart name prefixes
        grep "^\*" "charts/${CHART}/CHANGELOG.md" | sed -E "s/\* \[${CHART}\] /\* /gi" | sed -E "s/\* \[$(echo ${CHART} | tr '[:lower:]' '[:upper:]')\] /\* /g" > "charts/${CHART}/CHANGELOG.md.tmp-commits"
        
        # Create the new changelog with proper format
        echo "# Changelog" > "charts/${CHART}/CHANGELOG.md"
        echo "" >> "charts/${CHART}/CHANGELOG.md"
        

        echo "## <small>$CHART_VERSION</small> ($CURRENT_DATE)" >> "charts/${CHART}/CHANGELOG.md"
        
        echo "" >> "charts/${CHART}/CHANGELOG.md"
        
        # Add all commit entries
        if [ -s "charts/${CHART}/CHANGELOG.md.tmp-commits" ]; then
            cat "charts/${CHART}/CHANGELOG.md.tmp-commits" >> "charts/${CHART}/CHANGELOG.md"
        fi
        
        # Clean up temp files
        rm -f "charts/${CHART}/CHANGELOG.md.tmp"*
    done
else
    echo -e "Failed to find charts"
    exit 1
fi