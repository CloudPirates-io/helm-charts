#!/bin/bash

# Changelog generation script for Helm charts
# This script generates changelogs based on git history and PR information
# It works for both PRs from forks and branches within the main repository

set -eo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to print colored messages
log_info() {
    echo -e "${GREEN}[INFO]${NC} $1" || echo "[INFO] $1"
}

log_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

# Check required tools
check_dependencies() {
    local missing_deps=()

    if ! command -v yq &> /dev/null; then
        missing_deps+=("yq")
    fi

    if ! command -v git &> /dev/null; then
        missing_deps+=("git")
    fi

    if [ ${#missing_deps[@]} -gt 0 ]; then
        log_error "Missing required dependencies: ${missing_deps[*]}"
        exit 1
    fi
}

# Function to format changes for artifacthub.io/changes annotation
format_changes_for_chart_yaml() {
    local chart_name="$1"
    local pr_title="${2:-}"
    local pr_number="${3:-}"
    local pr_url="${4:-}"
    local chart_dir="charts/${chart_name}"
    local commit_limit=8

    # Create changes array - only include recent changes (latest version)
    local changes_yaml=""
    
    # Add new PR if provided
    if [ -n "$pr_title" ] && [ -n "$pr_number" ] && [ -n "$pr_url" ]; then
        changes_yaml="    - kind: added\n      description: \"${pr_title}\"\n      links:\n        - name: \"PR #${pr_number}\"\n          url: \"${pr_url}\""
    else
        # Get the latest tag for this chart
        local latest_tag
        latest_tag=$(git tag -l "${chart_name}-*" 2>/dev/null | sort -V -r | head -n 1 || true)
        
        if [ -n "$latest_tag" ]; then
            # Get the second latest tag to determine the range
            local prev_tag
            prev_tag=$(git tag -l "${chart_name}-*" 2>/dev/null | sort -V -r | sed -n '2p' || true)
            
            local commit_range
            if [ -n "$prev_tag" ]; then
                commit_range="${prev_tag}..${latest_tag}"
            else
                # If no previous tag, just get commits for the latest tag
                commit_range=$(git log --format=%H "$latest_tag" | tail -1)..${latest_tag}
            fi
            
            # Get recent commits for this chart
            local changes_found=false
            while IFS= read -r commit_line; do
                [ -z "$commit_line" ] && continue
                
                local commit_hash
                commit_hash=$(echo "$commit_line" | cut -d' ' -f1)
                local commit_msg
                commit_msg=$(echo "$commit_line" | cut -d' ' -f2-)
                
                # Skip commits that are clearly for other charts
                if echo "$commit_msg" | grep -qE '^\[[a-z]+\]'; then
                    if ! echo "$commit_msg" | grep -qiE '^\[('"${chart_name}"'|all)\]'; then
                        continue
                    fi
                fi

                # Skip commits that contain "chore", "docs", "typo", "bump" (case insensitive)
                if echo "$commit_msg" | grep -qiE '(chore|docs|typo|bump)'; then
                    continue
                fi
                
                # Clean up commit message
                commit_msg=$(echo "$commit_msg" | sed -E "s/^\[${chart_name}\] //i")
                commit_msg=$(echo "$commit_msg" | sed -E "s/^\[$(echo "${chart_name}" | tr '[:lower:]' '[:upper:]')\] //")
                commit_msg=$(echo "$commit_msg" | sed -E "s/^\[all\] //i")
                
                # Escape quotes in commit message for YAML
                commit_msg=$(echo "$commit_msg" | sed 's/"/\\"/g')
                
                # Add to changes (limit to first few)
                if [ "$changes_found" = false ]; then
                    changes_yaml="    - kind: changed\n      description: \"${commit_msg}\"\n      links:\n        - name: \"Commit ${commit_hash:0:8}\"\n          url: \"${GITHUB_REPOSITORY_URL:-https://github.com/${GITHUB_REPOSITORY:-CloudPirates-io/helm-charts}}/commit/${commit_hash}\""
                    changes_found=true
                else
                    changes_yaml="${changes_yaml}\n    - kind: changed\n      description: \"${commit_msg}\"\n      links:\n        - name: \"Commit ${commit_hash:0:8}\"\n          url: \"${GITHUB_REPOSITORY_URL:-https://github.com/${GITHUB_REPOSITORY:-CloudPirates-io/helm-charts}}/commit/${commit_hash}\""
                fi
                
                # Limit to 3 most recent changes to keep annotation reasonable
                local change_count
                change_count=$(echo -e "$changes_yaml" | grep -c "kind:" || echo "0")
                if [ "$change_count" -ge "$commit_limit" ]; then
                    break
                fi
            done < <(git log "$commit_range" --oneline --no-merges -- "$chart_dir" 2>/dev/null | head -3 || true)
            
            if [ "$changes_found" = false ]; then
                changes_yaml="    - kind: changed\n      description: \"Chart updated\""
            fi
        else
            # No tags found, create a basic entry
            changes_yaml="    - kind: added\n      description: \"Initial chart release\""
        fi
    fi
    
    echo -e "$changes_yaml"
}

# Function to update Chart.yaml with artifacthub.io/changes annotation
update_chart_yaml_changes() {
    local chart_yaml="$1"
    local changes_content="$2"
    
    # Create a temporary file for the updated Chart.yaml
    local temp_chart_yaml
    temp_chart_yaml=$(mktemp)
    
    # Check if the file already has artifacthub.io/changes annotation
    if grep -q "artifacthub.io/changes:" "$chart_yaml"; then
        # Remove existing artifacthub.io/changes annotation and its content
        # This is complex because the annotation is multi-line YAML
        yq eval 'del(.annotations."artifacthub.io/changes")' "$chart_yaml" > "$temp_chart_yaml"
    else
        cp "$chart_yaml" "$temp_chart_yaml"
    fi
    
    # Add the new artifacthub.io/changes annotation
    # Create a temporary file with the changes content
    local temp_changes
    temp_changes=$(mktemp)
    echo -e "$changes_content" > "$temp_changes"
    
    # Use yq to add the changes annotation
    yq eval '.annotations."artifacthub.io/changes" = load_str("'"$temp_changes"'")' "$temp_chart_yaml" > "${temp_chart_yaml}.new"
    mv "${temp_chart_yaml}.new" "$temp_chart_yaml"
    
    # Replace the original file
    mv "$temp_chart_yaml" "$chart_yaml"
    
    # Clean up temporary files
    rm -f "$temp_changes"
    
    log_info "Updated artifacthub.io/changes annotation in Chart.yaml"
}

# Function to generate changelog for a single chart
generate_chart_changelog() {
    local chart_name="$1"
    local pr_title="${2:-}"
    local pr_number="${3:-}"
    local pr_url="${4:-}"

    log_info "Generating changelog for chart: $chart_name"

    local chart_dir="charts/${chart_name}"
    local chart_yaml="${chart_dir}/Chart.yaml"
    local changelog_file="${chart_dir}/CHANGELOG.md"

    # Validate chart directory exists
    if [ ! -d "$chart_dir" ]; then
        log_error "Chart directory not found: $chart_dir"
        return 1
    fi

    # Validate Chart.yaml exists
    if [ ! -f "$chart_yaml" ]; then
        log_error "Chart.yaml not found: $chart_yaml"
        return 1
    fi

    # Extract version from Chart.yaml
    local chart_version
    chart_version=$(yq eval '.version' "$chart_yaml")

    if [ -z "$chart_version" ]; then
        log_error "Could not extract version from $chart_yaml"
        return 1
    fi

    log_info "Chart version: $chart_version"

    # Create temporary file for new changelog
    local temp_changelog
    temp_changelog=$(mktemp)

    # Start with header
    echo "# Changelog" > "$temp_changelog"
    echo "" >> "$temp_changelog"

    # Add new version entry if PR info is provided
    if [ -n "$pr_title" ] && [ -n "$pr_number" ] && [ -n "$pr_url" ]; then
        local current_date
        current_date=$(date +'%Y-%m-%d')

        echo "## $chart_version ($current_date)" >> "$temp_changelog"
        echo "" >> "$temp_changelog"
        echo "* ${pr_title} ([#${pr_number}](${pr_url}))" >> "$temp_changelog"

        log_info "Added new version entry: $chart_version ($current_date)"
    fi

    # Get all tags for this chart, sorted by version (newest first)
    local chart_tags
    chart_tags=$(git tag -l "${chart_name}-*" 2>/dev/null | sort -V -r || true)

    if [ -z "$chart_tags" ]; then
        log_warn "No tags found for chart: $chart_name"
    else
        log_info "Found tags for $chart_name"

        # Convert tags to array for easier processing
        local tags_array=()
        while IFS= read -r tag; do
            [ -n "$tag" ] && tags_array+=("$tag")
        done <<< "$chart_tags"

        # Process each tag to generate historical entries
        for i in "${!tags_array[@]}"; do
            local tag="${tags_array[$i]}"
            local prev_older_tag=""

            # Get the previous (older) tag - one position back in the array
            if [ $i -lt $((${#tags_array[@]} - 1)) ]; then
                prev_older_tag="${tags_array[$((i+1))]}"
            fi

            # Get the tag version (strip chart name prefix)
            local tag_version="${tag#${chart_name}-}"

            # Get tag date
            local tag_date
            tag_date=$(git log -1 --format=%ai "$tag" 2>/dev/null | cut -d' ' -f1 || echo "unknown")

            echo "" >> "$temp_changelog"
            echo "## $tag_version ($tag_date)" >> "$temp_changelog"
            echo "" >> "$temp_changelog"

            # Determine commit range
            # Get commits between the previous older tag and this tag
            local commit_range
            if [ -z "$prev_older_tag" ]; then
                # This is the oldest tag - don't show full history, just note it
                echo "* Initial tagged release" >> "$temp_changelog"
                continue
            else
                # Get commits between the previous older tag and this tag
                commit_range="${prev_older_tag}..${tag}"
            fi

            # Get commits that touched this chart's directory
            local commits_found=false
            while IFS= read -r commit_line; do
                [ -z "$commit_line" ] && continue
                commits_found=true

                local commit_hash
                commit_hash=$(echo "$commit_line" | cut -d' ' -f1)

                local commit_msg
                commit_msg=$(echo "$commit_line" | cut -d' ' -f2-)

                # Skip commits that are clearly for other charts (have [other-chart] prefix)
                # But allow commits with [chart-name] prefix, [all] prefix, or no prefix
                if echo "$commit_msg" | grep -qE '^\[[a-z]+\]'; then
                    # Has a chart prefix - check if it's for this chart or [all]
                    if ! echo "$commit_msg" | grep -qiE '^\[('"${chart_name}"'|all)\]'; then
                        # Skip this commit - it's for a different chart
                        continue
                    fi
                fi

                # Remove chart name prefix from commit message (case insensitive)
                commit_msg=$(echo "$commit_msg" | sed -E "s/^\[${chart_name}\] //i")
                commit_msg=$(echo "$commit_msg" | sed -E "s/^\[$(echo "${chart_name}" | tr '[:lower:]' '[:upper:]')\] //")
                commit_msg=$(echo "$commit_msg" | sed -E "s/^\[all\] //i")

                # Add commit to changelog with link
                local repo_url="${GITHUB_REPOSITORY_URL:-https://github.com/${GITHUB_REPOSITORY:-CloudPirates-io/helm-charts}}"
                echo "* ${commit_msg} ([${commit_hash}](${repo_url}/commit/${commit_hash}))" >> "$temp_changelog"
            done < <(git log "$commit_range" --oneline --no-merges -- "$chart_dir" 2>/dev/null || true)

            if [ "$commits_found" = false ]; then
                # No commits found for this tag, add a placeholder
                echo "* No changes recorded" >> "$temp_changelog"
            fi
        done
    fi

    # Replace old changelog with new one
    mv "$temp_changelog" "$changelog_file"

    log_info "Changelog updated: $changelog_file"
    
    # Update Chart.yaml with artifacthub.io/changes annotation
    local changes_for_chart_yaml
    changes_for_chart_yaml=$(format_changes_for_chart_yaml "$chart_name" "$pr_title" "$pr_number" "$pr_url")
    
    if [ -n "$changes_for_chart_yaml" ]; then
        update_chart_yaml_changes "$chart_yaml" "$changes_for_chart_yaml"
        log_info "Chart.yaml updated with artifacthub.io/changes annotation"
    fi
    
    return 0
}

# Main script logic
main() {
    log_info "Starting changelog generation"

    # Check dependencies
    check_dependencies

    # Parse command line arguments
    local chart_names=()
    local pr_title=""
    local pr_number=""
    local pr_url=""
    local generate_all=false

    while [[ $# -gt 0 ]]; do
        case $1 in
            --chart)
                chart_names+=("$2")
                shift 2
                ;;
            --pr-title)
                pr_title="$2"
                shift 2
                ;;
            --pr-number)
                pr_number="$2"
                shift 2
                ;;
            --pr-url)
                pr_url="$2"
                shift 2
                ;;
            --all)
                generate_all=true
                shift
                ;;
            --help|-h)
                echo "Usage: $0 [OPTIONS]"
                echo ""
                echo "Options:"
                echo "  --chart CHART_NAME     Generate changelog for specific chart (can be specified multiple times)"
                echo "  --pr-title TITLE       PR title to add to changelog"
                echo "  --pr-number NUMBER     PR number for reference"
                echo "  --pr-url URL           PR URL for linking"
                echo "  --all                  Generate changelogs for all charts"
                echo "  --help, -h             Show this help message"
                echo ""
                echo "Examples:"
                echo "  $0 --chart nginx --chart redis"
                echo "  $0 --chart nginx --pr-title 'Fix nginx config' --pr-number 123 --pr-url 'https://github.com/org/repo/pull/123'"
                echo "  $0 --all"
                exit 0
                ;;
            *)
                log_error "Unknown option: $1"
                echo "Use --help for usage information"
                exit 1
                ;;
        esac
    done

    # If --all flag is set, find all charts
    if [ "$generate_all" = true ]; then
        log_info "Discovering all charts..."
        while IFS= read -r chart_dir; do
            local chart_name
            chart_name=$(basename "$chart_dir")
            # Skip 'common' chart
            if [ "$chart_name" != "common" ]; then
                chart_names+=("$chart_name")
            fi
        done < <(find ./charts -mindepth 1 -maxdepth 1 -type d ! -name 'common')
    fi

    # Validate we have charts to process
    if [ ${#chart_names[@]} -eq 0 ]; then
        log_error "No charts specified. Use --chart, --all, or --help"
        exit 1
    fi

    log_info "Processing ${#chart_names[@]} chart(s): ${chart_names[*]}"

    # Generate changelogs
    local success_count=0
    local fail_count=0

    for chart_name in "${chart_names[@]}"; do
        if generate_chart_changelog "$chart_name" "$pr_title" "$pr_number" "$pr_url"; then
            success_count=$((success_count + 1))
        else
            fail_count=$((fail_count + 1))
        fi
    done

    # Summary
    log_info "Changelog generation complete"
    log_info "Success: $success_count, Failed: $fail_count"

    if [ $fail_count -gt 0 ]; then
        exit 1
    fi
}

# Run main function
main "$@"
