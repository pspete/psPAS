# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Commands

### Testing
- **Run all tests**: `pwsh.exe -File .\build\test.ps1` or `Invoke-Pester -Configuration $config` where config points to `.\Tests`
- **Run specific test**: `Invoke-Pester -Path .\Tests\<FunctionName>.Tests.ps1`
- **Test framework**: Pester (PowerShell testing framework)
- **PowerShell compatibility**: Supports PowerShell 5.1+ and PowerShell 7.x cross-platform (Windows, Linux)

### Development Workflow
- **Build package**: `pwsh.exe -File .\build\build.ps1`
- **Install dependencies**: `pwsh.exe -File .\build\install.ps1`
- **Import module locally**: `Import-Module .\psPAS\psPAS.psd1 -Force`
- **Validate module**: `Get-Module -ListAvailable psPAS` and `Get-Command -Module psPAS`

### Code Quality
- **PSScriptAnalyzer**: Integrated into test suite for code quality validation
- **Help validation**: All functions must have comprehensive comment-based help
- **Version validation**: Automatic version requirement checking for CyberArk API features

## Architecture Overview

### Module Structure
- **Entry Point**: `/psPAS/psPAS.psd1` (module manifest) and `/psPAS/psPAS.psm1` (root module with dynamic loading)
- **Public Functions**: `/psPAS/Functions/` organized by domain (Authentication, Accounts, Safes, Users, etc.)
- **Private Functions**: `/psPAS/Private/` containing core utilities like `Invoke-PASRestMethod.ps1`
- **Type Definitions**: `/psPAS/xml/` contains custom PowerShell type and format definitions
- **Tests**: `/Tests/` with one `.Tests.ps1` file per public function
- **Documentation**: `/docs/` Jekyll-based website with function documentation

### Core Components

#### Session Management (`psPAS.psm1`)
- Dynamic function loading mechanism using dot-sourcing
- `$psPASSession` script variable stores authentication state, API endpoints, version info
- Support for multiple concurrent authenticated sessions via `Use-PASSession`

#### REST API Wrapper (`/psPAS/Private/Invoke-PASRestMethod.ps1`)
- Central API communication handler with error processing
- Automatic certificate handling and TLS configuration
- Response formatting via `Get-PASResponse.ps1`

#### Functional Domains
Functions organized by CyberArk functionality:
- **Authentication**: Session management, SSH keys, authentication methods, SAML/LDAP/RADIUS
- **Accounts**: Account CRUD, password operations, discovery, CPM operations
- **Safes**: Safe management and member permissions
- **Users/Groups**: User administration and group management
- **Platforms**: Platform configuration and PSM settings
- **Monitoring**: PSM sessions, recordings, activities
- **EventSecurity**: PTA (Privileged Threat Analytics) configuration
- **Requests**: Access request workflow management

### Development Patterns

#### Version Compatibility
- Functions include `Assert-VersionRequirement` checks for CyberArk API version compatibility
- Version requirements documented in each function and centrally tracked
- Module supports CyberArk PAS up to v14.0

#### API Design Consistency
- All functions support pipeline input where appropriate
- Consistent parameter naming conventions across the module
- Comprehensive error handling with meaningful error messages
- Support for `-WhatIf` and `-Confirm` on destructive operations

#### Testing Strategy
- Unit tests for all public functions with mock API responses
- Integration tests via `psPAS.Tests.ps1`
- Help documentation validation
- Code coverage tracking (when enabled)

### Build and CI/CD
- **GitHub Actions**: Fork-friendly PowerShell testing workflow for contributors
  - Cross-platform testing: Windows PowerShell 5.1, PowerShell 7.x on Windows and Ubuntu
  - Complete test suite execution (1870+ tests across 205+ files)
  - Self-contained workflow requiring no external setup or secrets
  - Artifact generation with TestResults.xml for analysis
- **AppVeyor**: Primary production CI/CD pipeline
  - Automated versioning: Build version must be greater than current manifest version
  - Full Pester test suite execution with NUnit XML output
  - Packaging: Creates versioned ZIP releases
  - Publishing: Automatic deployment to PowerShell Gallery and GitHub releases
  - Code signing: Configured for release builds (when certificates available)

### Key Files for Development
- `/psPAS/psPAS.psd1`: Module manifest with exported functions and metadata
- `/psPAS/Private/Invoke-PASRestMethod.ps1`: Core API communication
- `/psPAS/Functions/Authentication/New-PASSession.ps1`: Authentication entry point
- `/Tests/psPAS.Tests.ps1`: Module-level integration tests
- `/build/test.ps1`: Test execution script
- `/build/build.ps1`: Build and packaging script

### Documentation
- Each function has comprehensive comment-based help following PowerShell standards
- External help files generated in `/psPAS/en-US/`
- Website documentation auto-generated from help content
- Examples included in function documentation and separate example repository

This module demonstrates enterprise-grade PowerShell development with comprehensive testing, CI/CD automation, and mature API design patterns for CyberArk Privileged Access Security management.