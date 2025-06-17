# Comprehensive GitHub Actions Testing Guide

## Overview

This guide provides detailed documentation for the comprehensive local testing capabilities implemented for the psPAS PowerShell module's GitHub Actions workflows. The enhanced testing script provides advanced validation, security checks, and best practices enforcement.

## Enhanced Testing Script Features

### 1. Version Information
- **Script Version**: 2.0.0
- **Name**: GitHub Actions Comprehensive Local Testing
- **Based on**: act binary (nektos/act)

### 2. Comprehensive Testing Modes

#### Best Practices Validation (`--best-practices`)
Validates GitHub Actions workflows against industry best practices:

**Checks Performed:**
- ✅ Workflow has a descriptive name
- ✅ Timeout settings are configured for jobs
- ✅ Specific runner versions (vs. "latest")
- ✅ Modern action versions (checkout@v4, etc.)
- ✅ Proper secret handling with security review
- ✅ Explicit permissions specification
- ✅ Proper event triggers configuration
- ✅ Matrix build fail-fast configuration
- ✅ Artifact retention policies
- ✅ Dependency caching implementation

**Usage:**
```bash
./test-workflow-local.sh --best-practices
```

#### Security Validation (`--security-check`)
Performs comprehensive security analysis of workflows:

**Security Checks:**
- 🔒 Hardcoded credentials detection
- 🔒 Overly broad permissions analysis
- 🔒 Third-party action version pinning
- 🔒 Full git history checkout warnings
- 🔒 Debug logging with secrets exposure
- 🔒 Pull request target security implications

**Usage:**
```bash
./test-workflow-local.sh --security-check
```

#### Event Testing (`--comprehensive` includes this)
Tests multiple GitHub Actions event types:

**Events Tested:**
- `push` - Repository push events
- `pull_request` - Pull request events
- `workflow_dispatch` - Manual workflow triggers

**Usage:**
```bash
# Individual event testing
./test-workflow-local.sh --event push
./test-workflow-local.sh --event pull_request
./test-workflow-local.sh --event workflow_dispatch
```

#### Matrix Build Testing (`--matrix-test`)
Analyzes and validates matrix build configurations:

**Matrix Validation:**
- ✅ Matrix configuration detection
- ✅ Matrix dimension analysis
- ✅ Syntax validation for matrix builds
- ✅ Fail-fast configuration assessment

**Usage:**
```bash
./test-workflow-local.sh --matrix-test
```

#### Failure Scenario Testing (`--failure-simulation`)
Tests workflow resilience and error handling:

**Failure Scenarios:**
- ❌ Invalid event handling
- ❌ Non-existent job validation
- ❌ Non-existent workflow validation
- ❌ Syntax error detection

**Usage:**
```bash
./test-workflow-local.sh --failure-simulation
```

#### Cross-Platform Testing (`--cross-platform`)
Validates cross-platform compatibility:

**Platform Checks:**
- 🖥️ Windows-specific configurations
- 🍎 macOS-specific configurations  
- 🐧 Ubuntu/Linux-specific configurations
- 🔧 Shell configuration validation

**Usage:**
```bash
./test-workflow-local.sh --cross-platform
```

### 3. Comprehensive Testing Suite

Run all validation tests in sequence:

```bash
./test-workflow-local.sh --comprehensive
```

**Test Sequence:**
1. Best Practices Validation
2. Security Validation
3. Event Testing
4. Matrix Build Testing
5. Failure Scenario Testing
6. Cross-Platform Testing

## Testing Workflow Recommendations

### Initial Validation
```bash
# 1. List available workflows
./test-workflow-local.sh --list

# 2. Validate workflow syntax
./test-workflow-local.sh --dry-run

# 3. Run comprehensive validation
./test-workflow-local.sh --comprehensive
```

### Targeted Testing
```bash
# Test specific aspects
./test-workflow-local.sh --security-check
./test-workflow-local.sh --best-practices
./test-workflow-local.sh --failure-simulation
```

### Continuous Integration Testing
```bash
# Test specific workflows
./test-workflow-local.sh --workflow test-powershell.yml --event push
./test-workflow-local.sh --workflow test-minimal.yml --event pull_request

# Test specific jobs
./test-workflow-local.sh --job test-powershell-51 --event push
```

## Security Best Practices Detected

### ✅ Good Practices
- Proper secret usage with `${{ secrets.* }}`
- Explicit permissions specification
- Version-pinned third-party actions
- Timeout configuration for jobs
- Artifact retention policies

### ⚠️ Warnings
- Using `ubuntu-latest` instead of specific versions
- Missing timeout configurations
- No explicit permissions (defaults to broad permissions)
- Broad write permissions
- Full git history checkout

### ❌ Critical Issues
- Hardcoded credentials in workflow files
- Secrets exposure through debug logging
- Insecure pull request target usage

## Performance and Optimization Features

### Caching Analysis
The testing script analyzes workflow caching strategies:
- Multi-tier caching implementation
- Cache hit rate analysis
- Performance impact assessment
- Cache key optimization

### Execution Efficiency
- Parallel execution where possible
- Optimized PowerShell configurations
- Dependency management optimization
- Resource usage monitoring

## Troubleshooting Common Issues

### Act Binary Issues
```bash
# Verify act binary
./test-workflow-local.sh --version
chmod +x ./bin/act

# Test basic functionality
./test-workflow-local.sh --list
```

### Workflow Syntax Errors
```bash
# Validate syntax
./test-workflow-local.sh --dry-run

# Check specific workflow
./test-workflow-local.sh --workflow filename.yml --dry-run
```

### Security Validation Failures
```bash
# Run security check
./test-workflow-local.sh --security-check

# Review workflow files for:
# - Hardcoded secrets
# - Broad permissions
# - Unpinned action versions
```

## Integration with Development Workflow

### Pre-commit Testing
```bash
# Add to pre-commit hooks
./test-workflow-local.sh --comprehensive --dry-run
```

### CI/CD Pipeline Integration
```bash
# Automated testing in CI
./test-workflow-local.sh --security-check
./test-workflow-local.sh --best-practices
```

### Code Review Process
```bash
# Validate changes before PR
./test-workflow-local.sh --comprehensive
```

## Testing Results Interpretation

### Exit Codes
- `0` - All tests passed
- `1` - Critical issues found (security violations)
- `2` - Warning issues found (best practices)

### Output Analysis
- ✅ **Green** - Passed checks
- ⚠️ **Yellow** - Warnings (non-blocking)
- ❌ **Red** - Critical issues (blocking)

### Reporting
The script provides detailed reports for:
- Individual test results
- Summary statistics
- Performance metrics
- Recommendations for improvement

## Advanced Usage

### Environment Variables
```bash
# Configure testing behavior
export GITHUB_ACTIONS_TESTING_VERBOSE=1
export GITHUB_ACTIONS_TESTING_STRICT=1
```

### Custom Configuration
```bash
# Test with custom runner
./test-workflow-local.sh --platform ubuntu-20.04

# Test with specific act version
ACT_BINARY="/path/to/custom/act" ./test-workflow-local.sh --comprehensive
```

## Maintenance and Updates

### Regular Testing Schedule
- Daily: Basic workflow validation
- Weekly: Comprehensive testing suite
- Monthly: Security and best practices review

### Monitoring and Alerting
- Set up alerts for test failures
- Monitor performance metrics
- Track security compliance

### Documentation Updates
- Keep testing documentation current
- Update examples and use cases
- Maintain troubleshooting guides

## Conclusion

The comprehensive testing framework provides robust validation of GitHub Actions workflows, ensuring:
- Security compliance
- Best practices adherence
- Cross-platform compatibility
- Performance optimization
- Failure resilience

Regular use of these testing capabilities helps maintain high-quality, secure, and efficient CI/CD workflows.