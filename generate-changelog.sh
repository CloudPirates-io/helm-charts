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
