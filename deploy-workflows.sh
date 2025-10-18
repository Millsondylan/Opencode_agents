#!/bin/bash

#######################################################################
# Deploy 24/7 GitHub Workflows to All Repositories
#######################################################################
#
# This script deploys the Gemini 2.5 Pro workflows to all your
# GitHub repositories automatically.
#
# Usage:
#   ./deploy-workflows.sh [options]
#
# Options:
#   --org ORG          Deploy to all repos in organization
#   --repos FILE       Deploy to repos listed in file (one per line)
#   --single REPO      Deploy to single repo (format: owner/repo)
#   --dry-run          Show what would be deployed without doing it
#
# Examples:
#   ./deploy-workflows.sh --org your-org-name
#   ./deploy-workflows.sh --repos repos.txt
#   ./deploy-workflows.sh --single username/repo-name
#
#######################################################################

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
WORKFLOW_DIR="$SCRIPT_DIR/.github/workflows"

# Default values
DRY_RUN=false
ORG_NAME=""
REPOS_FILE=""
SINGLE_REPO=""

#######################################################################
# Functions
#######################################################################

print_header() {
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}  24/7 Workflow Deployment with Gemini 2.5 Pro${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
}

print_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

print_error() {
    echo -e "${RED}❌ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠️  $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ️  $1${NC}"
}

check_prerequisites() {
    print_info "Checking prerequisites..."

    # Check if git is installed
    if ! command -v git &> /dev/null; then
        print_error "git is not installed. Please install git first."
        exit 1
    fi

    # Check if gh (GitHub CLI) is installed
    if ! command -v gh &> /dev/null; then
        print_error "GitHub CLI (gh) is not installed."
        echo "Install from: https://cli.github.com/"
        exit 1
    fi

    # Check if authenticated with GitHub CLI
    if ! gh auth status &> /dev/null; then
        print_error "Not authenticated with GitHub CLI."
        echo "Run: gh auth login"
        exit 1
    fi

    # Check if workflow files exist
    if [ ! -d "$WORKFLOW_DIR" ]; then
        print_error "Workflow directory not found: $WORKFLOW_DIR"
        exit 1
    fi

    if [ ! -f "$WORKFLOW_DIR/code-enhancement.yml" ]; then
        print_error "Workflow files not found in $WORKFLOW_DIR"
        exit 1
    fi

    print_success "All prerequisites met"
    echo ""
}

get_repos_from_org() {
    local org=$1
    print_info "Fetching repositories from organization: $org"

    # Get all repos in the organization
    local repos=$(gh repo list "$org" --limit 1000 --json nameWithOwner -q '.[].nameWithOwner')

    if [ -z "$repos" ]; then
        print_error "No repositories found in organization: $org"
        exit 1
    fi

    echo "$repos"
}

get_repos_from_file() {
    local file=$1

    if [ ! -f "$file" ]; then
        print_error "Repos file not found: $file"
        exit 1
    fi

    cat "$file"
}

deploy_to_repo() {
    local repo=$1
    local temp_dir="temp-$(echo "$repo" | tr '/' '-')"

    print_info "Deploying to: $repo"

    # Clone repository
    if [ -d "$temp_dir" ]; then
        rm -rf "$temp_dir"
    fi

    if $DRY_RUN; then
        print_warning "[DRY RUN] Would clone: $repo"
        print_warning "[DRY RUN] Would copy workflows to: $repo/.github/workflows/"
        print_warning "[DRY RUN] Would commit and push"
        print_success "[DRY RUN] Would complete deployment to: $repo"
        return 0
    fi

    # Clone with error handling
    if ! gh repo clone "$repo" "$temp_dir" 2>/dev/null; then
        print_error "Failed to clone: $repo (skipping)"
        return 1
    fi

    cd "$temp_dir"

    # Create .github/workflows directory
    mkdir -p .github/workflows

    # Copy workflow files
    cp "$WORKFLOW_DIR"/*.yml .github/workflows/ 2>/dev/null || {
        print_error "Failed to copy workflow files"
        cd ..
        rm -rf "$temp_dir"
        return 1
    }

    # Copy README
    if [ -f "$WORKFLOW_DIR/README.md" ]; then
        cp "$WORKFLOW_DIR/README.md" .github/workflows/
    fi

    # Check if there are changes
    if ! git diff --quiet .github/workflows/; then
        # Add files
        git add .github/workflows/

        # Commit
        git commit -m "Add 24/7 automation workflows with Gemini 2.5 Pro

- Code enhancement (runs every 6 hours)
- Automated debugging (runs every 8 hours)
- 24/7 maintenance (runs every 6 hours)

All workflows use Gemini 2.5 Pro for AI-powered analysis.

Setup required:
1. Add GOOGLE_GENERATIVE_AI_API_KEY secret
2. Add GEMINI_API_KEY secret

See .github/workflows/README.md for details." || {
            print_warning "Nothing to commit (workflows already up to date)"
            cd ..
            rm -rf "$temp_dir"
            return 0
        }

        # Push
        if git push; then
            print_success "Deployed to: $repo"
        else
            print_error "Failed to push to: $repo"
            cd ..
            rm -rf "$temp_dir"
            return 1
        fi
    else
        print_warning "No changes needed for: $repo"
    fi

    # Cleanup
    cd ..
    rm -rf "$temp_dir"

    return 0
}

show_summary() {
    local total=$1
    local success=$2
    local failed=$3

    echo ""
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${BLUE}  Deployment Summary${NC}"
    echo -e "${BLUE}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo ""
    echo "Total repositories: $total"
    print_success "Successfully deployed: $success"
    if [ $failed -gt 0 ]; then
        print_error "Failed deployments: $failed"
    fi
    echo ""

    if [ $success -gt 0 ]; then
        echo -e "${YELLOW}Next steps:${NC}"
        echo "1. Add secrets to each repository:"
        echo "   - GOOGLE_GENERATIVE_AI_API_KEY"
        echo "   - GEMINI_API_KEY"
        echo ""
        echo "2. Enable workflows in repository settings"
        echo ""
        echo "3. Monitor workflow runs in the Actions tab"
        echo ""
        print_info "See .github/workflows/README.md in each repo for setup instructions"
    fi
}

#######################################################################
# Parse Arguments
#######################################################################

while [[ $# -gt 0 ]]; do
    case $1 in
        --org)
            ORG_NAME="$2"
            shift 2
            ;;
        --repos)
            REPOS_FILE="$2"
            shift 2
            ;;
        --single)
            SINGLE_REPO="$2"
            shift 2
            ;;
        --dry-run)
            DRY_RUN=true
            shift
            ;;
        --help)
            cat << EOF
Deploy 24/7 GitHub Workflows to All Repositories

Usage:
  $0 [options]

Options:
  --org ORG          Deploy to all repos in organization
  --repos FILE       Deploy to repos listed in file (one per line)
  --single REPO      Deploy to single repo (format: owner/repo)
  --dry-run          Show what would be deployed without doing it
  --help             Show this help message

Examples:
  $0 --org your-org-name
  $0 --repos repos.txt
  $0 --single username/repo-name
  $0 --org your-org-name --dry-run

Workflow Files Deployed:
  - code-enhancement.yml (runs every 6 hours)
  - automated-debugging.yml (runs every 8 hours)
  - 24-7-maintenance.yml (runs every 6 hours)
  - README.md (setup instructions)

Requirements:
  - git installed
  - GitHub CLI (gh) installed and authenticated
  - GOOGLE_GENERATIVE_AI_API_KEY configured as repository secret

For more information, see:
  .github/workflows/README.md
EOF
            exit 0
            ;;
        *)
            print_error "Unknown option: $1"
            echo "Use --help for usage information"
            exit 1
            ;;
    esac
done

#######################################################################
# Main
#######################################################################

print_header

# Check prerequisites
check_prerequisites

# Determine which repos to deploy to
REPOS=()

if [ -n "$SINGLE_REPO" ]; then
    REPOS=("$SINGLE_REPO")
    print_info "Deploying to single repository"
elif [ -n "$ORG_NAME" ]; then
    print_info "Deploying to organization: $ORG_NAME"
    readarray -t REPOS < <(get_repos_from_org "$ORG_NAME")
elif [ -n "$REPOS_FILE" ]; then
    print_info "Deploying to repositories from file: $REPOS_FILE"
    readarray -t REPOS < <(get_repos_from_file "$REPOS_FILE")
else
    print_error "No deployment target specified"
    echo "Use --org, --repos, or --single"
    echo "Use --help for more information"
    exit 1
fi

# Confirm deployment
echo ""
echo "Repositories to deploy to: ${#REPOS[@]}"
echo ""
for repo in "${REPOS[@]}"; do
    echo "  - $repo"
done
echo ""

if $DRY_RUN; then
    print_warning "DRY RUN MODE - No changes will be made"
    echo ""
else
    read -p "Continue with deployment? (y/N) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        print_warning "Deployment cancelled"
        exit 0
    fi
    echo ""
fi

# Deploy to each repository
total=0
success=0
failed=0

for repo in "${REPOS[@]}"; do
    total=$((total + 1))

    if deploy_to_repo "$repo"; then
        success=$((success + 1))
    else
        failed=$((failed + 1))
    fi

    echo ""
done

# Show summary
show_summary $total $success $failed

if $DRY_RUN; then
    echo ""
    print_info "This was a dry run. Run without --dry-run to actually deploy."
fi

exit 0
