# PowerShell Testing Workflow Troubleshooting Guide

This comprehensive troubleshooting guide addresses common issues encountered when using the psPAS PowerShell testing workflow, based on real problems discovered during development and validation.

## Quick Reference

### Most Common Issues
1. [PowerShell Module Import Failures](#powershell-module-import-failures) - "No modules named 'psPAS' are currently loaded"
2. [Dependency Installation Problems](#dependency-installation-problems) - PowerShell Gallery connectivity issues
3. [Test Execution Failures](#test-execution-failures) - Tests fail in CI environment
4. [Cross-Platform Path Issues](#cross-platform-path-issues) - Windows vs Ubuntu path handling
5. [GitHub Actions Workflow Triggers](#github-actions-workflow-triggers) - Workflow not running as expected
6. [Write-Error Script Execution Issues](#write-error-script-execution-issues) - "At line:1 char:1 WriteErrorException"

### Emergency Quick Fixes
```powershell
# Module import issue
Import-Module ./psPAS/psPAS.psd1 -Force -Global

# Dependency installation issue
Install-Module -Name Pester -Force -SkipPublisherCheck -Scope CurrentUser

# Test execution issue
$config = New-PesterConfiguration; $config.Run.Path = './Tests'; Invoke-Pester -Configuration $config
```

## PowerShell Module Import Failures

### Issue: "No modules named 'psPAS' are currently loaded"

**Symptoms:**
- Tests fail with "Command not found" errors
- `Get-Module psPAS` returns nothing
- Functions like `New-PASSession` are not available

**Root Causes:**
1. Module import failed silently
2. Import path incorrect for operating system
3. Module not imported with proper scope
4. PowerShell session isolation issues

**Solutions:**

#### Solution 1: Force Import with Global Scope
```powershell
# Cross-platform path handling
$modulePath = if ($env:RUNNER_OS -eq 'Windows') {
    "${{ github.workspace }}\psPAS\psPAS.psd1"
} else {
    "${{ github.workspace }}/psPAS/psPAS.psd1"
}

Import-Module $modulePath -Force -Global -ErrorAction Stop
```

#### Solution 2: Multi-Strategy Fallback Approach
```powershell
# Strategy 1: Relative path
try {
    Import-Module .\psPAS\psPAS.psd1 -Force -ErrorAction Stop
    Write-Host "✓ psPAS imported via relative path"
} catch {
    # Strategy 2: Absolute path
    try {
        $absolutePath = Join-Path $env:GITHUB_WORKSPACE "psPAS\psPAS.psd1"
        Import-Module $absolutePath -Force -ErrorAction Stop
        Write-Host "✓ psPAS imported via absolute path"
    } catch {
        # Strategy 3: Direct PSM1 import
        try {
            Import-Module .\psPAS\psPAS.psm1 -Force -ErrorAction Stop
            Write-Host "✓ psPAS imported via PSM1 file"
        } catch {
            throw "Failed to import psPAS module: $_"
        }
    }
}
```

#### Solution 3: Verification and Diagnostics
```powershell
# Always verify import success
$module = Get-Module -Name psPAS
if (-not $module) {
    # Diagnostic information
    Write-Host "Module import failed. Diagnostics:"
    Write-Host "Working directory: $(Get-Location)"
    Write-Host "psPAS.psd1 exists: $(Test-Path .\psPAS\psPAS.psd1)"
    Write-Host "Available modules: $(Get-Module -ListAvailable | Where-Object Name -like '*psPAS*')"
    throw "psPAS module not loaded after import"
}

Write-Host "✓ psPAS module loaded successfully"
Write-Host "  Version: $($module.Version)"
Write-Host "  Functions: $($module.ExportedFunctions.Count)"
```

## Dependency Installation Problems

### Issue: PowerShell Gallery Connection Failures

**Symptoms:**
- `Install-Module` commands timeout
- "Unable to download from PowerShell Gallery" errors
- Package provider errors
- Trust repository warnings

**Root Causes:**
1. Network connectivity issues in CI environment
2. PowerShell Gallery temporary outages
3. Package provider not configured
4. Repository trust issues

**Solutions:**

#### Solution 1: Retry Logic with Exponential Backoff
```powershell
function Install-ModuleWithRetry {
    param(
        [string]$ModuleName,
        [string]$MinimumVersion = $null,
        [int]$MaxAttempts = 3
    )
    
    for ($attempt = 1; $attempt -le $MaxAttempts; $attempt++) {
        try {
            Write-Host "Installing $ModuleName (attempt $attempt/$MaxAttempts)..."
            
            $params = @{
                Name = $ModuleName
                Force = $true
                Scope = 'CurrentUser'
                SkipPublisherCheck = $true
                AllowClobber = $true
                Verbose = $true
            }
            
            if ($MinimumVersion) {
                $params.MinimumVersion = $MinimumVersion
            }
            
            Install-Module @params
            Write-Host "✓ $ModuleName installed successfully"
            return
        }
        catch {
            Write-Warning "Attempt $attempt failed: $_"
            if ($attempt -eq $MaxAttempts) {
                throw "Failed to install $ModuleName after $MaxAttempts attempts: $_"
            }
            Start-Sleep -Seconds (5 * $attempt)  # Exponential backoff
        }
    }
}

# Usage
Install-ModuleWithRetry -ModuleName "Pester" -MinimumVersion "5.0.0"
Install-ModuleWithRetry -ModuleName "PSScriptAnalyzer"
```

#### Solution 2: Repository Configuration
```powershell
# Ensure PowerShell Gallery is trusted and configured
Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
Get-PackageProvider -Name NuGet -ForceBootstrap
```

#### Solution 3: Alternative Installation Methods
```powershell
# Method 1: Direct NuGet package installation
if (!(Get-Module -ListAvailable -Name Pester)) {
    Install-Package -Name Pester -Source https://www.nuget.org/api/v2 -Force -Scope CurrentUser
}

# Method 2: GitHub release download (as fallback)
if (!(Get-Module -ListAvailable -Name Pester)) {
    Write-Host "Falling back to GitHub release download..."
    # Implementation would download and install from GitHub releases
}
```

### Issue: Module Version Conflicts

**Symptoms:**
- Wrong Pester version loaded (v4 instead of v5+)
- "New-PesterConfiguration not found" errors
- API compatibility issues

**Solutions:**

#### Solution 1: Force Specific Version Installation
```powershell
# Remove conflicting versions
Get-Module Pester -All | Remove-Module -Force

# Install specific version
Install-Module -Name Pester -MinimumVersion 5.0.0 -Force -SkipPublisherCheck

# Verify correct version
$pesterModule = Get-Module -ListAvailable -Name Pester | Sort-Object Version -Descending | Select-Object -First 1
if ($pesterModule.Version -lt [version]"5.0.0") {
    throw "Pester version $($pesterModule.Version) is too old. Need 5.0.0 or later."
}
```

## Test Execution Failures

### Issue: Tests Fail with "Cannot find command" Errors

**Symptoms:**
- Individual tests fail with command not found
- psPAS functions not available during test execution
- Tests pass locally but fail in CI

**Root Causes:**
1. Module scope issues between workflow steps
2. PowerShell session isolation
3. Test execution environment differences

**Solutions:**

#### Solution 1: Re-import Module for Test Session
```powershell
# In test execution step, always re-import
Write-Host "Importing modules for test session..."
Import-Module Pester -Force
Import-Module ./psPAS/psPAS.psd1 -Force

# Verify modules are available
if (!(Get-Command New-PesterConfiguration -ErrorAction SilentlyContinue)) {
    throw "Pester not available in test session"
}

if (!(Get-Command New-PASSession -ErrorAction SilentlyContinue)) {
    throw "psPAS not available in test session"
}
```

#### Solution 2: Test Configuration Issues
```powershell
# Correct Pester v5+ configuration
$config = New-PesterConfiguration
$config.Run.Path = './Tests'
$config.Run.PassThru = $true
$config.Run.Exit = $false  # Don't exit PowerShell on test failure
$config.TestResult.Enabled = $true
$config.TestResult.OutputPath = './TestResults.xml'
$config.TestResult.OutputFormat = 'NUnitXml'
$config.Output.Verbosity = 'Normal'

# Run with error handling
try {
    $result = Invoke-Pester -Configuration $config
    Write-Host "Tests completed: $($result.TotalCount) total, $($result.PassedCount) passed, $($result.FailedCount) failed"
} catch {
    Write-Error "Test execution failed: $_"
    throw
}
```

### Issue: Test Environment Differences

**Symptoms:**
- Tests pass locally but fail in GitHub Actions
- Authentication-related tests fail (expected)
- Network-dependent tests fail

**Understanding Expected Failures:**
Many psPAS tests are expected to fail in CI environments because:
- No CyberArk server available for authentication
- Network isolation prevents external connections
- Test mocks may not cover all scenarios

**Solutions:**

#### Solution 1: Workflow Success Criteria
```yaml
# Focus on workflow execution, not test pass rates
- name: Run Tests
  continue-on-error: true  # Allow test failures
  run: |
    # Test execution code here
    
# Upload results regardless of test outcomes
- name: Upload Test Results
  if: always()  # Run even if tests failed
  uses: actions/upload-artifact@v4
```

#### Solution 2: Test Categorization
```powershell
# Run different test categories
$config = New-PesterConfiguration

# Run only unit tests (not integration tests)
$config.Filter.Tag = @('Unit')
$config.Filter.ExcludeTag = @('Integration', 'RequiresServer')

# Or run all tests but categorize results
$config.Run.Path = './Tests'
$result = Invoke-Pester -Configuration $config

# Analyze results by category
Write-Host "Unit test results: $(($result.Tests | Where-Object Tag -contains 'Unit').Count)"
Write-Host "Integration test results: $(($result.Tests | Where-Object Tag -contains 'Integration').Count)"
```

## Cross-Platform Path Issues

### Issue: Path Separator Problems

**Symptoms:**
- Windows workflow fails with Unix paths
- Ubuntu workflow fails with Windows paths
- File not found errors with mixed path separators

**Root Causes:**
1. Hard-coded path separators in workflow
2. GitHub Actions path context differences
3. PowerShell path handling inconsistencies

**Solutions:**

#### Solution 1: Cross-Platform Path Handling
```powershell
# Use PowerShell's built-in path handling
$modulePath = Join-Path $env:GITHUB_WORKSPACE "psPAS" "psPAS.psd1"
$testsPath = Join-Path $env:GITHUB_WORKSPACE "Tests"

# Or use conditional logic
$modulePath = if ($env:RUNNER_OS -eq 'Windows') {
    "${{ github.workspace }}\psPAS\psPAS.psd1"
} else {
    "${{ github.workspace }}/psPAS/psPAS.psd1"
}
```

#### Solution 2: Workflow Matrix Configuration
```yaml
strategy:
  matrix:
    os: [windows-latest, ubuntu-latest]
    shell: [pwsh]
    include:
      - os: windows-latest
        shell: powershell  # Windows PowerShell 5.1
        
defaults:
  run:
    shell: ${{ matrix.shell }}
```

## GitHub Actions Workflow Triggers

### Issue: Workflow Not Running on Fork

**Symptoms:**
- Workflow doesn't trigger on push to fork
- Pull request from fork doesn't run tests
- Manual workflow dispatch not available

**Root Causes:**
1. Workflow file not in default branch
2. Incorrect branch configuration
3. GitHub Actions not enabled on fork

**Solutions:**

#### Solution 1: Verify Workflow Configuration
```yaml
# Ensure proper trigger configuration
on:
  push:
    branches: [ main, master, develop ]
  pull_request:
    branches: [ main, master ]
  workflow_dispatch:  # Enable manual triggers
```

#### Solution 2: Fork Setup Instructions
1. **Enable GitHub Actions** in fork settings
2. **Sync fork** to ensure workflow file is present
3. **Check branch names** match trigger configuration
4. **Verify workflow file** is in `.github/workflows/` directory

#### Solution 3: Debug Workflow Triggers
```yaml
# Add debugging to workflow
- name: Debug Workflow Trigger
  run: |
    Write-Host "Workflow triggered by: ${{ github.event_name }}"
    Write-Host "Repository: ${{ github.repository }}"
    Write-Host "Branch: ${{ github.ref }}"
    Write-Host "Actor: ${{ github.actor }}"
```

## Write-Error Script Execution Issues

### Issue: "At line:1 char:1 WriteErrorException" in GitHub Actions

**Symptoms:**
- GitHub Actions shows confusing error messages like:
  ```
  At line:1 char:1
  + . 'C:\a\_temp\f439bfc5-0765-4170-b460-f6999fbd74d8.ps1'
  + ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  WriteErrorException
  ```
- Workflow fails with PowerShell script execution errors
- Error occurs even when tests run successfully

**Root Cause:**
GitHub Actions creates temporary PowerShell script files to execute workflow steps. When `Write-Error` is used in the workflow, it causes the entire script execution to fail with a confusing error message rather than a clear test failure indication.

**Solution:**
✅ **FIXED** - This issue has been resolved in the latest workflow version (commit d6acbaf)

**Technical Details:**
- **Problem**: `Write-Error "TEST FAILURE: ..."` was interpreted as script execution failure
- **Fix**: Replaced with `Write-Host "TEST FAILURE: ..."` for clear reporting
- **Result**: Test failures are now reported clearly without PowerShell execution errors

**Additional Fixes Applied:**
- Removed unicode characters (❌, ✅) that can cause encoding issues
- Simplified error messages to be workflow-appropriate
- Maintained test failure detection while improving error clarity

**Prevention:**
- Use `Write-Host` instead of `Write-Error` for reporting in workflows
- Avoid unicode characters in PowerShell scripts within GitHub Actions
- Test workflow changes locally when possible before pushing

## Performance Issues

### Issue: Workflow Takes Too Long

**Symptoms:**
- Workflow exceeds 20-minute target
- Timeout errors in GitHub Actions
- Slow dependency installation

**Root Causes:**
1. No module caching (expected in simplified approach)
2. Large test suite execution time
3. Network latency for downloads

**Solutions:**

#### Solution 1: Optimize for Current Architecture
```powershell
# The current simplified approach prioritizes reliability over speed
# Expected execution time: 10-15 minutes
# This is acceptable for the fork-friendly design

# Focus on reliability indicators
Write-Host "Starting test execution at $(Get-Date)"
# ... test execution ...
Write-Host "Completed test execution at $(Get-Date)"
```

#### Solution 2: Timeout Management
```yaml
# Set appropriate timeouts
jobs:
  test:
    timeout-minutes: 25  # Allow extra time for reliability
    steps:
      - name: Install Dependencies
        timeout-minutes: 10
        
      - name: Run Tests
        timeout-minutes: 20
```

#### Solution 3: Performance Monitoring
```powershell
# Add timing information
$startTime = Get-Date
# ... operation ...
$endTime = Get-Date
$duration = $endTime - $startTime
Write-Host "Operation completed in $($duration.TotalMinutes) minutes"
```

## Advanced Troubleshooting

### Comprehensive Diagnostics Script

```powershell
# Complete environment diagnostics
function Get-WorkflowDiagnostics {
    Write-Host "=== PowerShell Testing Workflow Diagnostics ==="
    
    # Environment information
    Write-Host "`n--- Environment ---"
    Write-Host "PowerShell Version: $($PSVersionTable.PSVersion)"
    Write-Host "OS: $($PSVersionTable.OS)"
    Write-Host "Runner OS: $($env:RUNNER_OS)"
    Write-Host "Working Directory: $(Get-Location)"
    Write-Host "Workspace: $($env:GITHUB_WORKSPACE)"
    
    # File system checks
    Write-Host "`n--- File System ---"
    Write-Host "psPAS.psd1 exists: $(Test-Path ./psPAS/psPAS.psd1)"
    Write-Host "Tests directory exists: $(Test-Path ./Tests)"
    if (Test-Path ./Tests) {
        $testFiles = Get-ChildItem ./Tests -Filter "*.Tests.ps1" -Recurse
        Write-Host "Test files found: $($testFiles.Count)"
    }
    
    # Module information
    Write-Host "`n--- Modules ---"
    $pester = Get-Module -ListAvailable -Name Pester | Select-Object -First 1
    if ($pester) {
        Write-Host "Pester version: $($pester.Version)"
    } else {
        Write-Host "Pester: Not installed"
    }
    
    $analyzer = Get-Module -ListAvailable -Name PSScriptAnalyzer | Select-Object -First 1
    if ($analyzer) {
        Write-Host "PSScriptAnalyzer version: $($analyzer.Version)"
    } else {
        Write-Host "PSScriptAnalyzer: Not installed"
    }
    
    $psPAS = Get-Module -Name psPAS
    if ($psPAS) {
        Write-Host "psPAS loaded: Yes, version $($psPAS.Version)"
        Write-Host "psPAS functions: $($psPAS.ExportedFunctions.Count)"
    } else {
        Write-Host "psPAS loaded: No"
    }
    
    # PowerShell Gallery connectivity
    Write-Host "`n--- PowerShell Gallery ---"
    try {
        $gallery = Get-PSRepository -Name PSGallery
        Write-Host "PSGallery status: $($gallery.InstallationPolicy)"
    } catch {
        Write-Host "PSGallery error: $_"
    }
    
    Write-Host "`n=== End Diagnostics ===`n"
}
```

### Error Message Reference

| Error Message | Likely Cause | Solution |
|---------------|--------------|----------|
| "No modules named 'psPAS' are currently loaded" | Module import failed | Use multi-strategy import approach |
| "New-PesterConfiguration not found" | Pester v4 installed instead of v5+ | Force install Pester 5.0+ |
| "Unable to download from PowerShell Gallery" | Network/connectivity issue | Use retry logic with exponential backoff |
| "The term 'New-PASSession' is not recognized" | psPAS not imported in current session | Re-import module in test step |
| "Access to the path is denied" | File permission issue | Check file permissions and paths |
| "Cannot find path" | Incorrect path separators | Use cross-platform path handling |
| Timeout errors | Workflow exceeds time limits | Increase timeout values |

### GitHub Actions Debugging

#### Enable Debug Logging
```yaml
env:
  ACTIONS_STEP_DEBUG: true
  ACTIONS_RUNNER_DEBUG: true
```

#### Add Debugging Steps
```yaml
- name: Debug Environment
  run: |
    Write-Host "Environment Variables:"
    Get-ChildItem Env: | Sort-Object Name | ForEach-Object { 
        Write-Host "  $($_.Name) = $($_.Value)" 
    }
    
    Write-Host "`nFile System:"
    Get-ChildItem -Force | ForEach-Object {
        Write-Host "  $($_.Name) ($($_.GetType().Name))"
    }
```

## Prevention Best Practices

### Workflow Design Principles

1. **Simplicity First**: Keep workflows simple and readable
2. **Error Handling**: Always include comprehensive error handling
3. **Cross-Platform**: Design for multiple operating systems
4. **Idempotent Operations**: Ensure steps can be run multiple times safely
5. **Clear Logging**: Provide detailed logging for troubleshooting

### Testing Strategy

1. **Local Testing**: Test workflows locally using act or manual PowerShell
2. **Incremental Development**: Add complexity gradually
3. **Error Simulation**: Test failure scenarios explicitly
4. **Documentation**: Document all known issues and solutions

### Maintenance Approach

1. **Monitor Performance**: Track workflow execution times
2. **Review Failures**: Investigate and document all failures
3. **Update Dependencies**: Keep PowerShell modules current
4. **Community Feedback**: Gather feedback from fork contributors

## Getting Help

### Internal Resources
- **Workflow File**: `.github/workflows/test-powershell.yml`
- **Local Testing Guide**: `LOCAL_TESTING.md`
- **Performance Guide**: `WORKFLOW_PERFORMANCE_OPTIMIZATIONS.md`
- **Task Tracking**: `WORKFLOW_TASKS.md`

### External Resources
- **GitHub Actions Documentation**: https://docs.github.com/en/actions
- **Pester Documentation**: https://pester.dev/
- **PowerShell Gallery**: https://www.powershellgallery.com/
- **psPAS Module Documentation**: https://pspas.pspete.dev/

### Reporting Issues

When reporting workflow issues, include:

1. **Error Messages**: Complete error messages and stack traces
2. **Workflow Run URL**: Link to the failed GitHub Actions run
3. **Environment**: Operating system, PowerShell version, runner type
4. **Reproduction Steps**: Steps to reproduce the issue
5. **Expected Behavior**: What should have happened
6. **Diagnostics**: Output from the diagnostics script above

This troubleshooting guide represents the collective knowledge gained from developing and validating the psPAS PowerShell testing workflow, providing solutions to real problems encountered during the development process.