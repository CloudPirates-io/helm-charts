#!/bin/bash

# Update AppVersion script for Helm charts
# This script updates the appVersion in Chart.yaml with the image.tag from values.yaml
# It's designed to be triggered after generate-changelog.sh

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

    if [ ${#missing_deps[@]} -gt 0 ]; then
        log_error "Missing required dependencies: ${missing_deps[*]}"
        log_error "Please install yq: https://github.com/mikefarah/yq"
        exit 1
    fi
}

# Function to extract version from image tag
# This function handles various tag formats and ensures only semantic versions are returned:
# - "1.2.3" -> "1.2.3"
# - "1.2.3@sha256:..." -> "1.2.3"
# - "v1.2.3" -> "1.2.3"
# - "v1.2.3@sha256:..." -> "1.2.3"
# - "1.2.3-alpine" -> "1.2.3" (removes non-semver suffixes)
# - "1.2.3-alpha.1" -> "1.2.3-alpha.1" (keeps semver pre-release)
# - "RELEASE.2025-09-07T16-13-09Z" -> null (not semver)
# - "464e93ac" -> null (not semver)
extract_version_from_tag() {
    local tag="$1"
    
    # Remove quotes if present
    tag=$(echo "$tag" | sed 's/^"//;s/"$//')
    
    # Split by @ to remove digest if present
    tag=$(echo "$tag" | cut -d'@' -f1)
    
    # Remove 'v' prefix if present (but keep it for versions that start with v followed by number)
    if [[ "$tag" =~ ^v[0-9] ]]; then
        tag=$(echo "$tag" | sed 's/^v//')
    fi
    
    # Extract semantic version - prioritize core version (MAJOR.MINOR.PATCH)
    # Only keep pre-release if it follows strict semver rules
    
    # First, try to extract the core version (MAJOR.MINOR.PATCH or MAJOR.MINOR)
    local core_version
    core_version=$(echo "$tag" | grep -oE '^[0-9]+\.[0-9]+(\.[0-9]+)?' || echo "")
    
    if [ -z "$core_version" ]; then
        # No valid core version found
        echo ""
        return
    fi
    
    # If we only have MAJOR.MINOR, convert to MAJOR.MINOR.0 for strict semver compliance
    if [[ "$core_version" =~ ^[0-9]+\.[0-9]+$ ]]; then
        core_version="${core_version}.0"
    fi
    
    # Check if there's anything after the core version
    local remaining_part
    remaining_part=$(echo "$tag" | sed "s/^$(echo "$core_version" | sed 's/\.0$//')//")
    
    if [ -z "$remaining_part" ]; then
        # Just the core version, perfect
        echo "$core_version"
        return
    fi
    
    # Check if the remaining part is a valid semver pre-release/build
    # Valid pre-release: -alpha, -alpha.1, -rc.1, -beta.2 (alphanumeric + hyphen, no leading zeros in numeric parts)
    if [[ "$remaining_part" =~ ^-([a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*)(\+[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)*)?$ ]]; then
        local prerelease_part="${BASH_REMATCH[1]}"
        
        # Validate each identifier in pre-release (no leading zeros in numeric identifiers)
        local valid_prerelease=true
        IFS='.' read -ra IDENTIFIERS <<< "$prerelease_part"
        for identifier in "${IDENTIFIERS[@]}"; do
            # Check if it's a numeric identifier with leading zero (invalid)
            if [[ "$identifier" =~ ^0[0-9]+$ ]]; then
                valid_prerelease=false
                break
            fi
            # Check for mixed patterns like "alpine3", "management", "pg17" which are not valid semver
            if [[ "$identifier" =~ [a-zA-Z][0-9] ]] || [[ "$identifier" =~ [0-9][a-zA-Z] ]]; then
                valid_prerelease=false
                break
            fi
            # Check for words like "management", "alpine" (common non-semver suffixes)
            if [[ "$identifier" =~ ^(alpine|management|ubuntu|debian|slim|fat)$ ]]; then
                valid_prerelease=false
                break
            fi
        done
        
        if [ "$valid_prerelease" = true ]; then
            # Valid semver pre-release, keep the full version
            echo "${core_version}${remaining_part}"
        else
            # Invalid pre-release, return just core version
            echo "$core_version"
        fi
    else
        # Not a valid semver pre-release format, return just core version
        echo "$core_version"
    fi
}

# Function to update appVersion in Chart.yaml
update_chart_appversion() {
    local chart_name="$1"
    local chart_dir="charts/${chart_name}"
    local chart_yaml="${chart_dir}/Chart.yaml"
    local values_yaml="${chart_dir}/values.yaml"

    log_info "Processing chart: $chart_name"

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

    # Validate values.yaml exists
    if [ ! -f "$values_yaml" ]; then
        log_error "values.yaml not found: $values_yaml"
        return 1
    fi

    # Extract current appVersion from Chart.yaml
    local current_app_version
    current_app_version=$(yq eval '.appVersion' "$chart_yaml" 2>/dev/null || echo "null")

    if [ "$current_app_version" = "null" ]; then
        log_warn "No appVersion found in $chart_yaml"
        current_app_version="(not set)"
    fi

    # Extract image tag from values.yaml
    # Try different possible paths for the image tag
    local image_tag=""
    
    # Try image.tag first (most common)
    image_tag=$(yq eval '.image.tag' "$values_yaml" 2>/dev/null || echo "null")
    
    # If not found, try other common patterns
    if [ "$image_tag" = "null" ]; then
        # Try under different sections that might contain image configurations
        for path in \
            '.*.image.tag' \
            '.images.*.tag' \
            '.global.image.tag' \
            '.*.*.image.tag'; do
            
            local temp_tag
            temp_tag=$(yq eval "$path" "$values_yaml" 2>/dev/null | head -1 || echo "null")
            if [ "$temp_tag" != "null" ] && [ -n "$temp_tag" ]; then
                image_tag="$temp_tag"
                log_info "Found image tag at path: $path"
                break
            fi
        done
    fi

    if [ "$image_tag" = "null" ] || [ -z "$image_tag" ]; then
        log_warn "No image tag found in $values_yaml for chart $chart_name"
        log_warn "Skipping appVersion update"
        return 0
    fi

    log_info "Found image tag: $image_tag"

    # Extract version from the image tag
    local new_app_version
    new_app_version=$(extract_version_from_tag "$image_tag")

    if [ -z "$new_app_version" ]; then
        log_warn "Could not extract valid semantic version from image tag: $image_tag"
        log_warn "Skipping appVersion update for chart $chart_name"
        return 0
    fi

    log_info "Extracted semantic version: $new_app_version"

    # Check if appVersion needs to be updated
    if [ "$current_app_version" = "\"$new_app_version\"" ] || [ "$current_app_version" = "$new_app_version" ]; then
        log_info "appVersion is already up to date ($new_app_version)"
        return 0
    fi

    # Update appVersion in Chart.yaml
    log_info "Updating appVersion from $current_app_version to $new_app_version"
    
    # Use yq to update the appVersion
    yq eval ".appVersion = \"$new_app_version\"" -i "$chart_yaml"
    
    if [ $? -eq 0 ]; then
        log_info "Successfully updated appVersion in $chart_yaml"
    else
        log_error "Failed to update appVersion in $chart_yaml"
        return 1
    fi

    return 0
}

# Function to process all charts or specific charts
process_charts() {
    local chart_names=("$@")
    local success_count=0
    local fail_count=0
    local skip_count=0

    for chart_name in "${chart_names[@]}"; do
        # Skip the 'common' chart as it typically doesn't have an image
        if [ "$chart_name" = "common" ]; then
            log_info "Skipping 'common' chart (no image expected)"
            skip_count=$((skip_count + 1))
            continue
        fi

        if update_chart_appversion "$chart_name"; then
            success_count=$((success_count + 1))
        else
            fail_count=$((fail_count + 1))
        fi
    done

    # Summary
    log_info "AppVersion update complete"
    log_info "Success: $success_count, Failed: $fail_count, Skipped: $skip_count"

    if [ $fail_count -gt 0 ]; then
        return 1
    fi

    return 0
}

# Main script logic
main() {
    log_info "Starting appVersion update"

    # Check dependencies
    check_dependencies

    # Parse command line arguments
    local chart_names=()
    local update_all=false

    while [[ $# -gt 0 ]]; do
        case $1 in
            --chart)
                chart_names+=("$2")
                shift 2
                ;;
            --all)
                update_all=true
                shift
                ;;
            --help|-h)
                echo "Usage: $0 [OPTIONS]"
                echo ""
                echo "Description:"
                echo "  Updates the appVersion in Chart.yaml with the version extracted from image.tag in values.yaml"
                echo "  Designed to be run after generate-changelog.sh to keep appVersion in sync with image versions"
                echo ""
                echo "Options:"
                echo "  --chart CHART_NAME     Update appVersion for specific chart (can be specified multiple times)"
                echo "  --all                  Update appVersion for all charts"
                echo "  --help, -h             Show this help message"
                echo ""
                echo "Examples:"
                echo "  $0 --chart nginx --chart redis"
                echo "  $0 --all"
                echo ""
                echo "Version Extraction Logic:"
                echo "  - Removes SHA256 digest: '1.2.3@sha256:...' -> '1.2.3'"
                echo "  - Removes 'v' prefix: 'v1.2.3' -> '1.2.3'"
                echo "  - Extracts semantic version only: '1.2.3-alpine' -> '1.2.3'"
                echo "  - Preserves semver pre-release: '1.2.3-alpha.1' -> '1.2.3-alpha.1'"
                echo "  - Skips non-semver tags: 'RELEASE.2025-09-07' -> (skipped)"
                echo "  - Skips git hashes: '464e93ac' -> (skipped)"
                echo ""
                echo "Supported tag paths in values.yaml:"
                echo "  - image.tag (most common)"
                echo "  - *.image.tag"
                echo "  - images.*.tag"
                echo "  - global.image.tag"
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
    if [ "$update_all" = true ]; then
        log_info "Discovering all charts..."
        while IFS= read -r chart_dir; do
            local chart_name
            chart_name=$(basename "$chart_dir")
            chart_names+=("$chart_name")
        done < <(find ./charts -mindepth 1 -maxdepth 1 -type d)
    fi

    # Validate we have charts to process
    if [ ${#chart_names[@]} -eq 0 ]; then
        log_error "No charts specified. Use --chart, --all, or --help"
        exit 1
    fi

    log_info "Processing ${#chart_names[@]} chart(s): ${chart_names[*]}"

    # Process charts
    if process_charts "${chart_names[@]}"; then
        log_info "All updates completed successfully"
        exit 0
    else
        log_error "Some updates failed"
        exit 1
    fi
}

# Run main function
main "$@"