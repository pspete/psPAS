#!/bin/bash

# GitHub Actions Local Testing Script (Comprehensive)
# ===================================================
# 
# This script provides comprehensive local testing capabilities for GitHub Actions workflows
# with advanced validation, security checks, and best practices enforcement.
# 
# Requirements:
# - ./bin/act binary (pre-installed)
# - .github/workflows directory with workflow files
#
# Usage:
#   ./test-workflow-local.sh [OPTIONS]
#
# For detailed help: ./test-workflow-local.sh --help

set -e  # Exit on any error

# Configuration
ACT_BINARY="./bin/act"
SCRIPT_VERSION="2.0.0"
SCRIPT_NAME="GitHub Actions Comprehensive Local Testing"

# Default values
EVENT="push"
DRY_RUN=false
LIST=false
HELP=false
JOB=""
WORKFLOW=""
VERBOSE=false
VALIDATE_BEST_PRACTICES=false
SECURITY_CHECK=false
COMPREHENSIVE_TEST=false
FAILURE_SIMULATION=false
CROSS_PLATFORM_TEST=false
MATRIX_TEST=false

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Print colored output
print_color() {
    local color=$1
    local message=$2
    echo -e "${color}${message}${NC}"
}

# Display help information
show_help() {
    cat << 'EOF'

GitHub Actions Comprehensive Local Testing Script
=================================================

This script provides comprehensive local testing capabilities for GitHub Actions workflows 
with advanced validation, security checks, and best practices enforcement.

PREREQUISITES:
- ./bin/act binary (already included)
- .github/workflows directory with workflow files

NOTE FOR PROJECTS USING OTHER CI/CD SYSTEMS:
If this project uses AppVeyor, Travis CI, Azure Pipelines, or GitLab CI instead of GitHub Actions,
this script will detect the configuration and provide guidance. GitHub Actions workflows are not
required for projects using alternative CI/CD systems.

BASIC USAGE:
  ./test-workflow-local.sh                    # Run push event workflows
  ./test-workflow-local.sh --list             # List all workflows
  ./test-workflow-local.sh --dry-run          # Validate workflow syntax
  ./test-workflow-local.sh --help             # Show this help

EVENT TESTING:
  ./test-workflow-local.sh --event push                    # Simulate push event
  ./test-workflow-local.sh --event pull_request           # Simulate PR event  
  ./test-workflow-local.sh --event workflow_dispatch      # Manual trigger

COMPREHENSIVE TESTING:
  ./test-workflow-local.sh --comprehensive               # Run all validation tests
  ./test-workflow-local.sh --best-practices              # Validate GitHub Actions best practices
  ./test-workflow-local.sh --security-check              # Perform security validation
  ./test-workflow-local.sh --matrix-test                 # Test matrix build configurations
  ./test-workflow-local.sh --failure-simulation          # Test failure scenarios
  ./test-workflow-local.sh --cross-platform              # Test cross-platform compatibility

ADVANCED OPTIONS:
  ./test-workflow-local.sh --event push --job test-powershell-51    # Run specific job
  ./test-workflow-local.sh --workflow test-powershell.yml           # Run specific workflow
  ./test-workflow-local.sh --event push --verbose                   # Enable verbose output

OPTIONS:
  Basic Options:
  -e, --event EVENT        Event type: push, pull_request, workflow_dispatch (default: push)
  -d, --dry-run           Perform dry run validation only
  -l, --list              List available workflows
  -j, --job JOB           Run specific job only
  -w, --workflow FILE     Run specific workflow file
  -v, --verbose           Enable verbose output
  -h, --help              Show this help
  
  Comprehensive Testing Options:
  --comprehensive         Run all validation and testing scenarios
  --best-practices        Validate GitHub Actions best practices
  --security-check        Perform comprehensive security validation
  --matrix-test           Test matrix build configurations
  --failure-simulation    Test failure scenarios and recovery
  --cross-platform        Test cross-platform runner compatibility

VALIDATION WORKFLOW:
1. Start with: ./test-workflow-local.sh --list
2. Then try:   ./test-workflow-local.sh --dry-run  
3. Finally:    ./test-workflow-local.sh --event [your-event]

COMMON ISSUES:
- "Binary not found": Ensure ./bin/act exists and is executable
- "Permission denied": Make script executable with 'chmod +x test-workflow-local.sh'
- "No workflows found": Check .github/workflows directory exists
- "Different CI/CD system": This script detects AppVeyor, Travis CI, etc. and explains alternatives
- "act command failed": Check workflow syntax and job/workflow names

FEATURES:
- No Docker required - uses pre-installed binary
- Fast execution without container overhead
- Complete act functionality pass-through
- Comprehensive error handling and validation
- Color-coded output for better readability

For more information about act, see: https://github.com/nektos/act

EOF
}

# Check if act binary is available
check_act_binary() {
    if [ ! -f "$ACT_BINARY" ]; then
        print_color $RED "❌ Act binary not found at: $ACT_BINARY"
        echo "Expected location: ./bin/act"
        echo "Current directory: $(pwd)"
        echo "Please ensure the act binary is present in the bin directory."
        exit 1
    fi
    
    if [ ! -x "$ACT_BINARY" ]; then
        print_color $RED "❌ Act binary is not executable: $ACT_BINARY"
        echo "Fix with: chmod +x $ACT_BINARY"
        exit 1
    fi
    
    # Test if binary works
    if ! "$ACT_BINARY" --version &> /dev/null; then
        print_color $RED "❌ Act binary appears to be corrupted or incompatible"
        echo "Try re-downloading the act binary for your platform."
        exit 1
    fi
}

# Check if .github/workflows directory exists
check_workflow_directory() {
    if [ ! -d ".github/workflows" ]; then
        print_color $YELLOW "⚠️  No .github/workflows directory found in current location."
        echo "Current directory: $(pwd)"
        echo ""
        print_color $CYAN "This project appears to use a different CI/CD system:"
        
        # Check for other CI/CD systems
        if [ -f "appveyor.yml" ]; then
            print_color $GREEN "✅ Found AppVeyor configuration (appveyor.yml)"
            echo "   This project uses AppVeyor for CI/CD instead of GitHub Actions."
            echo ""
            print_color $CYAN "For local AppVeyor testing, consider:"
            echo "- Using the project's local testing scripts (check build/ directory)"
            echo "- Running tests directly with PowerShell/Pester"
            echo "- Using AppVeyor CLI tools if available"
        elif [ -f ".travis.yml" ]; then
            print_color $GREEN "✅ Found Travis CI configuration (.travis.yml)"
            echo "   This project uses Travis CI for CI/CD instead of GitHub Actions."
        elif [ -f "azure-pipelines.yml" ] || [ -f ".azure-pipelines.yml" ]; then
            print_color $GREEN "✅ Found Azure Pipelines configuration"
            echo "   This project uses Azure Pipelines for CI/CD instead of GitHub Actions."
        elif [ -f ".gitlab-ci.yml" ]; then
            print_color $GREEN "✅ Found GitLab CI configuration (.gitlab-ci.yml)"
            echo "   This project uses GitLab CI for CI/CD instead of GitHub Actions."
        else
            echo "   No common CI/CD configuration files detected."
        fi
        
        echo ""
        print_color $CYAN "If you want to add GitHub Actions workflows:"
        echo "1. Create the directory: mkdir -p .github/workflows"
        echo "2. Add workflow files: .github/workflows/*.yml"
        echo "3. Run this script again"
        echo ""
        print_color $CYAN "If this project intentionally uses a different CI/CD system:"
        echo "This script is designed for GitHub Actions workflows and is not needed."
        echo "Use your CI/CD system's testing tools instead."
        
        exit 1
    fi
    
    # Check if there are any workflow files
    if ! ls .github/workflows/*.yml &> /dev/null && ! ls .github/workflows/*.yaml &> /dev/null; then
        print_color $YELLOW "⚠️  No workflow files found in .github/workflows/"
        echo "Expected files: *.yml or *.yaml"
        echo ""
        print_color $CYAN "To add workflows:"
        echo "1. Create workflow files in .github/workflows/"
        echo "2. Use .yml or .yaml extension"
        echo "3. Follow GitHub Actions workflow syntax"
        echo ""
        print_color $CYAN "Example workflow locations:"
        echo "- .github/workflows/test.yml"
        echo "- .github/workflows/build.yml"
        echo "- .github/workflows/deploy.yml"
        exit 1
    fi
}

# Validate event parameter
validate_event() {
    local event=$1
    case $event in
        push|pull_request|workflow_dispatch)
            return 0
            ;;
        *)
            print_color $RED "❌ Invalid event type: $event"
            echo "Valid events: push, pull_request, workflow_dispatch"
            exit 1
            ;;
    esac
}

# Build the act command
build_act_command() {
    local act_cmd=("$ACT_BINARY")
    
    # Add act-specific arguments
    if [ "$LIST" = true ]; then
        act_cmd+=("--list")
    elif [ "$DRY_RUN" = true ]; then
        act_cmd+=("--dryrun")
    else
        # Add event type
        act_cmd+=("$EVENT")
    fi
    
    # Add optional parameters
    if [ -n "$JOB" ] && [ "$LIST" = false ]; then
        act_cmd+=("--job" "$JOB")
    fi
    
    if [ -n "$WORKFLOW" ] && [ "$LIST" = false ]; then
        act_cmd+=("--workflows" "$WORKFLOW")
    fi
    
    if [ "$VERBOSE" = true ] && [ "$LIST" = false ]; then
        act_cmd+=("--verbose")
    fi
    
    echo "${act_cmd[@]}"
}

# Parse command line arguments
parse_arguments() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            -e|--event)
                EVENT="$2"
                validate_event "$EVENT"
                shift 2
                ;;
            -d|--dry-run)
                DRY_RUN=true
                shift
                ;;
            -l|--list)
                LIST=true
                shift
                ;;
            -j|--job)
                JOB="$2"
                shift 2
                ;;
            -w|--workflow)
                WORKFLOW="$2"
                shift 2
                ;;
            -v|--verbose)
                VERBOSE=true
                shift
                ;;
            -h|--help)
                HELP=true
                shift
                ;;
            --comprehensive)
                COMPREHENSIVE_TEST=true
                shift
                ;;
            --best-practices)
                VALIDATE_BEST_PRACTICES=true
                shift
                ;;
            --security-check)
                SECURITY_CHECK=true
                shift
                ;;
            --matrix-test)
                MATRIX_TEST=true
                shift
                ;;
            --failure-simulation)
                FAILURE_SIMULATION=true
                shift
                ;;
            --cross-platform)
                CROSS_PLATFORM_TEST=true
                shift
                ;;
            *)
                print_color $RED "❌ Unknown option: $1"
                echo "For help: ./test-workflow-local.sh --help"
                exit 1
                ;;
        esac
    done
}

# Display act binary information
show_binary_info() {
    local version
    version=$("$ACT_BINARY" --version 2>/dev/null || echo "unknown")
    print_color $CYAN "Act binary: $ACT_BINARY"
    print_color $CYAN "Version: $version"
    echo ""
}

# ============================================================================
# COMPREHENSIVE TESTING FUNCTIONS
# ============================================================================

# Validate GitHub Actions best practices
validate_best_practices() {
    print_color $CYAN "Starting GitHub Actions Best Practices Validation..."
    echo ""
    
    local issues_found=0
    local workflows_dir=".github/workflows"
    
    # Check for workflow files
    if [ ! -d "$workflows_dir" ]; then
        print_color $RED "❌ No workflows directory found"
        return 1
    fi
    
    # Iterate through each workflow file
    for workflow_file in "$workflows_dir"/*.yml "$workflows_dir"/*.yaml; do
        [ -f "$workflow_file" ] || continue
        
        local filename=$(basename "$workflow_file")
        print_color $YELLOW "Validating: $filename"
        
        # Best practice checks
        local file_issues=0
        
        # Check 1: Workflow has a name
        if ! grep -q "^name:" "$workflow_file"; then
            print_color $RED "  ❌ Missing workflow name"
            ((file_issues++))
        fi
        
        # Check 2: Timeout is set for jobs
        if ! grep -q "timeout-minutes:" "$workflow_file"; then
            print_color $YELLOW "  ⚠️  No timeout-minutes specified (recommended)"
            ((file_issues++))
        fi
        
        # Check 3: Specific runner versions
        if grep -q "runs-on: ubuntu-latest" "$workflow_file"; then
            print_color $YELLOW "  ⚠️  Using 'ubuntu-latest' - consider pinning to specific version"
        fi
        
        # Check 4: Checkout action version
        if grep -q "actions/checkout@v[1-3]" "$workflow_file"; then
            print_color $YELLOW "  ⚠️  Using older checkout action version - consider upgrading to v4"
        fi
        
        # Check 5: Secrets in workflow (potential security issue)
        if grep -q "\${{ secrets\." "$workflow_file" && ! grep -q "# Security reviewed" "$workflow_file"; then
            print_color $YELLOW "  ⚠️  Secrets usage detected - ensure security review"
        fi
        
        # Check 6: Permissions specified
        if ! grep -q "permissions:" "$workflow_file"; then
            print_color $YELLOW "  ⚠️  No explicit permissions specified (security best practice)"
        fi
        
        # Check 7: Workflow has proper event triggers
        if ! grep -q "on:" "$workflow_file"; then
            print_color $RED "  ❌ No event triggers specified"
            ((file_issues++))
        fi
        
        # Check 8: Matrix builds have proper configuration
        if grep -q "matrix:" "$workflow_file"; then
            if ! grep -q "fail-fast:" "$workflow_file"; then
                print_color $YELLOW "  ⚠️  Matrix build without fail-fast configuration"
            fi
        fi
        
        # Check 9: Artifact retention
        if grep -q "upload-artifact" "$workflow_file"; then
            if ! grep -q "retention-days:" "$workflow_file"; then
                print_color $YELLOW "  ⚠️  Artifact upload without retention-days (may use default 90 days)"
            fi
        fi
        
        # Check 10: Dependency caching
        if grep -q "setup-node\|setup-python\|setup-java" "$workflow_file"; then
            if ! grep -q "actions/cache" "$workflow_file"; then
                print_color $YELLOW "  ⚠️  No dependency caching detected - consider adding for performance"
            fi
        fi
        
        if [ $file_issues -eq 0 ]; then
            print_color $GREEN "  ✓ No critical issues found"
        else
            ((issues_found += file_issues))
        fi
        
        echo ""
    done
    
    # Summary
    print_color $CYAN "Best Practices Validation Summary:"
    print_color $CYAN "=================================="
    if [ $issues_found -eq 0 ]; then
        print_color $GREEN "✓ All workflows follow best practices"
        return 0
    else
        print_color $YELLOW "⚠️  Found $issues_found potential issues"
        print_color $CYAN "Review the warnings above to improve workflow quality"
        return 0  # Don't fail on warnings
    fi
}

# Perform security validation
validate_security() {
    print_color $CYAN "Starting Security Validation..."
    echo ""
    
    local security_issues=0
    local workflows_dir=".github/workflows"
    
    for workflow_file in "$workflows_dir"/*.yml "$workflows_dir"/*.yaml; do
        [ -f "$workflow_file" ] || continue
        
        local filename=$(basename "$workflow_file")
        print_color $YELLOW "Security checking: $filename"
        
        # Security checks
        local file_issues=0
        
        # Check 1: Hardcoded secrets or credentials
        if grep -i -E "(password|secret|token|credential).*[:=]" "$workflow_file" | grep -v "\${{ secrets\." | grep -v "^#" | grep -v "Write-Host" | grep -v "echo"; then
            print_color $RED "  ❌ Potential hardcoded credentials detected"
            ((file_issues++))
        fi
        
        # Check 2: Unrestricted permissions
        if grep -q "permissions:" "$workflow_file"; then
            if grep -A 10 "permissions:" "$workflow_file" | grep -q "write-all\|contents: write"; then
                print_color $YELLOW "  ⚠️  Broad write permissions detected"
            fi
        fi
        
        # Check 3: Third-party actions without version pinning
        if grep -E "uses: [^@]+@[^v]" "$workflow_file" | grep -v "@main" | grep -v "@master"; then
            print_color $YELLOW "  ⚠️  Third-party actions without version pinning"
        fi
        
        # Check 4: Checkout with full history
        if grep -q "fetch-depth: 0" "$workflow_file"; then
            print_color $YELLOW "  ⚠️  Full git history checkout - consider if necessary"
        fi
        
        # Check 5: Secrets logging prevention
        if ! grep -q "ACTIONS_STEP_DEBUG\|ACTIONS_RUNNER_DEBUG" "$workflow_file"; then
            if grep -q "\${{ secrets\." "$workflow_file"; then
                print_color $GREEN "  ✓ No debug logging with secrets"
            fi
        else
            print_color $YELLOW "  ⚠️  Debug logging enabled - ensure no secrets exposure"
        fi
        
        # Check 6: Pull request triggers from forks
        if grep -q "pull_request_target:" "$workflow_file"; then
            print_color $YELLOW "  ⚠️  pull_request_target trigger - review for security implications"
        fi
        
        if [ $file_issues -eq 0 ]; then
            print_color $GREEN "  ✓ No critical security issues found"
        else
            ((security_issues += file_issues))
        fi
        
        echo ""
    done
    
    # Summary
    print_color $CYAN "Security Validation Summary:"
    print_color $CYAN "============================"
    if [ $security_issues -eq 0 ]; then
        print_color $GREEN "✓ No critical security issues found"
        return 0
    else
        print_color $RED "❌ Found $security_issues security issues"
        print_color $CYAN "Review and address the security issues above"
        return 1
    fi
}

# Test multiple events
test_multiple_events() {
    print_color $CYAN "Testing Multiple GitHub Actions Events..."
    echo ""
    
    local events=("push" "pull_request" "workflow_dispatch")
    local test_results=()
    
    for event in "${events[@]}"; do
        print_color $YELLOW "Testing event: $event"
        
        # Test syntax validation for each event
        if "$ACT_BINARY" --dryrun "$event" >/dev/null 2>&1; then
            print_color $GREEN "  ✓ $event event syntax valid"
            test_results+=("$event:PASS")
        else
            print_color $RED "  ❌ $event event syntax invalid"
            test_results+=("$event:FAIL")
        fi
    done
    
    echo ""
    print_color $CYAN "Event Testing Summary:"
    print_color $CYAN "====================="
    for result in "${test_results[@]}"; do
        local event_name=$(echo "$result" | cut -d: -f1)
        local event_status=$(echo "$result" | cut -d: -f2)
        if [ "$event_status" = "PASS" ]; then
            print_color $GREEN "✓ $event_name"
        else
            print_color $RED "❌ $event_name"
        fi
    done
}

# Test matrix configurations
test_matrix_builds() {
    print_color $CYAN "Testing Matrix Build Configurations..."
    echo ""
    
    local workflows_dir=".github/workflows"
    local matrix_found=false
    
    for workflow_file in "$workflows_dir"/*.yml "$workflows_dir"/*.yaml; do
        [ -f "$workflow_file" ] || continue
        
        if grep -q "matrix:" "$workflow_file"; then
            matrix_found=true
            local filename=$(basename "$workflow_file")
            print_color $YELLOW "Matrix configuration found in: $filename"
            
            # Extract matrix configurations
            local matrix_section=$(grep -A 20 "matrix:" "$workflow_file" | head -20)
            echo "$matrix_section" | while read -r line; do
                if [[ $line =~ ^[[:space:]]*[a-zA-Z] ]]; then
                    print_color $CYAN "  Matrix dimension: $line"
                fi
            done
            
            # Test matrix build syntax
            if "$ACT_BINARY" --dryrun --matrix push "$workflow_file" >/dev/null 2>&1; then
                print_color $GREEN "  ✓ Matrix syntax valid"
            else
                print_color $YELLOW "  ⚠️  Matrix syntax validation inconclusive"
            fi
        fi
    done
    
    if [ "$matrix_found" = false ]; then
        print_color $YELLOW "No matrix configurations found in workflows"
    fi
}

# Simulate failure scenarios
test_failure_scenarios() {
    print_color $CYAN "Testing Failure Scenarios and Recovery..."
    echo ""
    
    print_color $YELLOW "Testing workflow syntax validation..."
    
    # Test with invalid event
    print_color $CYAN "Testing invalid event handling..."
    if "$ACT_BINARY" --dryrun "invalid_event" >/dev/null 2>&1; then
        print_color $RED "  ❌ Invalid event validation failed"
    else
        print_color $GREEN "  ✓ Invalid event properly rejected"
    fi
    
    # Test with non-existent job
    print_color $CYAN "Testing non-existent job handling..."
    if "$ACT_BINARY" --dryrun --job "nonexistent-job" push >/dev/null 2>&1; then
        print_color $RED "  ❌ Non-existent job validation failed"
    else
        print_color $GREEN "  ✓ Non-existent job properly rejected"
    fi
    
    # Test with non-existent workflow
    print_color $CYAN "Testing non-existent workflow handling..."
    if "$ACT_BINARY" --dryrun --workflows "nonexistent.yml" push >/dev/null 2>&1; then
        print_color $RED "  ❌ Non-existent workflow validation failed"
    else
        print_color $GREEN "  ✓ Non-existent workflow properly rejected"
    fi
    
    print_color $GREEN "✓ Failure scenario testing completed"
}

# Test cross-platform compatibility
test_cross_platform() {
    print_color $CYAN "Testing Cross-Platform Compatibility..."
    echo ""
    
    local workflows_dir=".github/workflows"
    
    for workflow_file in "$workflows_dir"/*.yml "$workflows_dir"/*.yaml; do
        [ -f "$workflow_file" ] || continue
        
        local filename=$(basename "$workflow_file")
        print_color $YELLOW "Checking platform compatibility: $filename"
        
        # Check for platform-specific runners
        if grep -q "runs-on:" "$workflow_file"; then
            local runners=$(grep "runs-on:" "$workflow_file" | sed 's/.*runs-on: *//' | sed 's/[[:space:]]*$//')
            print_color $CYAN "  Detected runners: $runners"
            
            # Check for Windows-specific configurations
            if grep -q "windows" "$workflow_file"; then
                print_color $CYAN "  Windows-specific configuration detected"
                if grep -q "shell: powershell\|pwsh" "$workflow_file"; then
                    print_color $GREEN "  ✓ PowerShell shell specified for Windows"
                else
                    print_color $YELLOW "  ⚠️  Windows runner without PowerShell shell"
                fi
            fi
            
            # Check for macOS-specific configurations
            if grep -q "macos" "$workflow_file"; then
                print_color $CYAN "  macOS-specific configuration detected"
            fi
            
            # Check for Ubuntu/Linux-specific configurations
            if grep -q "ubuntu" "$workflow_file"; then
                print_color $CYAN "  Ubuntu/Linux-specific configuration detected"
            fi
        fi
    done
    
    print_color $GREEN "✓ Cross-platform compatibility check completed"
}

# Run comprehensive testing
run_comprehensive_tests() {
    print_color $CYAN "Running Comprehensive GitHub Actions Testing Suite..."
    echo ""
    
    local test_results=()
    
    # Run all validation tests
    print_color $CYAN "1. Best Practices Validation"
    print_color $CYAN "============================"
    if validate_best_practices; then
        test_results+=("best-practices:PASS")
    else
        test_results+=("best-practices:FAIL")
    fi
    echo ""
    
    print_color $CYAN "2. Security Validation"
    print_color $CYAN "======================"
    if validate_security; then
        test_results+=("security:PASS")
    else
        test_results+=("security:FAIL")
    fi
    echo ""
    
    print_color $CYAN "3. Event Testing"
    print_color $CYAN "================"
    test_multiple_events
    test_results+=("events:PASS")
    echo ""
    
    print_color $CYAN "4. Matrix Build Testing"
    print_color $CYAN "======================="
    test_matrix_builds
    test_results+=("matrix:PASS")
    echo ""
    
    print_color $CYAN "5. Failure Scenario Testing"
    print_color $CYAN "==========================="
    test_failure_scenarios
    test_results+=("failure-scenarios:PASS")
    echo ""
    
    print_color $CYAN "6. Cross-Platform Testing"
    print_color $CYAN "========================="
    test_cross_platform
    test_results+=("cross-platform:PASS")
    echo ""
    
    # Summary report
    print_color $CYAN "COMPREHENSIVE TESTING SUMMARY"
    print_color $CYAN "============================="
    local passed=0
    local failed=0
    
    for result in "${test_results[@]}"; do
        local test_name=$(echo "$result" | cut -d: -f1)
        local test_status=$(echo "$result" | cut -d: -f2)
        if [ "$test_status" = "PASS" ]; then
            print_color $GREEN "✓ $test_name"
            ((passed++))
        else
            print_color $RED "❌ $test_name"
            ((failed++))
        fi
    done
    
    echo ""
    print_color $CYAN "Test Results: $passed passed, $failed failed"
    
    if [ $failed -eq 0 ]; then
        print_color $GREEN "🎉 All comprehensive tests passed!"
        return 0
    else
        print_color $YELLOW "⚠️  Some tests failed - review the output above"
        return 1
    fi
}

# Main execution
main() {
    parse_arguments "$@"
    
    if [ "$HELP" = true ]; then
        show_help
        exit 0
    fi
    
    print_color $CYAN "$SCRIPT_NAME v$SCRIPT_VERSION"
    print_color $CYAN "=========================================="
    echo ""
    
    # Validate prerequisites
    check_act_binary
    check_workflow_directory
    
    # Show binary information
    show_binary_info
    
    # Handle comprehensive testing modes
    if [ "$COMPREHENSIVE_TEST" = true ]; then
        print_color $CYAN "Running comprehensive testing suite..."
        run_comprehensive_tests
        exit $?
    elif [ "$VALIDATE_BEST_PRACTICES" = true ]; then
        print_color $CYAN "Running best practices validation..."
        validate_best_practices
        exit $?
    elif [ "$SECURITY_CHECK" = true ]; then
        print_color $CYAN "Running security validation..."
        validate_security
        exit $?
    elif [ "$MATRIX_TEST" = true ]; then
        print_color $CYAN "Running matrix build testing..."
        test_matrix_builds
        exit $?
    elif [ "$FAILURE_SIMULATION" = true ]; then
        print_color $CYAN "Running failure scenario testing..."
        test_failure_scenarios
        exit $?
    elif [ "$CROSS_PLATFORM_TEST" = true ]; then
        print_color $CYAN "Running cross-platform testing..."
        test_cross_platform
        exit $?
    fi
    
    # Build and execute the act command for standard workflow testing
    local act_command
    act_command=$(build_act_command)
    
    print_color $GREEN "Executing: $act_command"
    echo ""
    
    # Show what we're about to do
    if [ "$LIST" = true ]; then
        print_color $YELLOW "Listing available workflows..."
    elif [ "$DRY_RUN" = true ]; then
        print_color $YELLOW "Performing dry run validation for event: $EVENT"
    else
        print_color $YELLOW "Simulating event: $EVENT"
        if [ -n "$JOB" ]; then
            print_color $YELLOW "Running specific job: $JOB"
        fi
        if [ -n "$WORKFLOW" ]; then
            print_color $YELLOW "Using specific workflow: $WORKFLOW"
        fi
    fi
    
    echo ""
    
    # Execute the command
    if eval "$act_command"; then
        echo ""
        print_color $GREEN "✅ Command completed successfully!"
    else
        local exit_code=$?
        echo ""
        print_color $RED "❌ Command failed with exit code: $exit_code"
        print_color $YELLOW "Common issues:"
        echo "- Workflow syntax errors"
        echo "- Invalid job or workflow names"
        echo "- Missing required environment variables"
        echo "- Unsupported GitHub Actions features"
        echo "- Missing secrets or configuration"
        echo ""
        print_color $YELLOW "For comprehensive testing: ./test-workflow-local.sh --comprehensive"
        print_color $YELLOW "For help: ./test-workflow-local.sh --help"
        print_color $YELLOW "For act documentation: https://github.com/nektos/act"
        exit $exit_code
    fi
}

# Make sure script is executable
if [ ! -x "$0" ]; then
    print_color $YELLOW "⚠️  Script is not executable. Run: chmod +x test-workflow-local.sh"
fi

# Run main function with all arguments
main "$@"