---
title: "psPAS Release 7.0"
date: 2025-09-15 00:00:00
tags:
  - Release Notes
  - Remove-PASPublicSSHKey
  - Get-PASPublicSSHKey
  - Add-PASPublicSSHKey
  - Get-PASAccountPassword
  - Get-PASSAMLResponse
  - Get-PASSafe
  - New-PASAccountObject
  - New-PASAccountPassword
  - Enable-PASTheme
  - Remove-PASTheme
  - Import-PASThemeImage
  - Export-PASThemeImage
  - Reset-PASTheme
  - Publish-PASTheme
  - Get-PASTheme
  - New-PASTheme
  - Set-PASTheme
  - Get-PASStoredPlatform
  - Remove-PASStoredPlatform
  - Get-PASUserLicenseReport
  - Get-PASReport
  - Get-PASReportSchedule
  - New-PASReportSchedule
  - Export-PASReport
  - Remove-PASUserAllowedAuthenticationMethod
  - Add-PASUserAllowedAuthenticationMethod
  - Remove-PASFIDO2Device
  - Get-PASMasterPolicy
  - Set-PASMasterPolicy
  - Remove-PASDependentAccount
  - Resume-PASDependentAccount
  - Get-PASDependentAccount
  - Sync-PASDependentAccount
  - Set-PASDependentAccount
  - Add-PASDependentAccount
  - Remove-PASPTASecurityConfigurationProperty
  - Reset-PASPTASecurityConfigurationProperty
  - Reset-PASPTASecurityConfigurationCategory
  - Get-PASPTASecurityConfigurationCategory
  - Add-PASPTASyslog
  - Remove-PASPTASyslog
  - Set-PASPTASMTP
  - Get-PASAccountSearchProperty
  - Add-PASSafeMember
  - Set-PASSafeMember
  - Get-PASAccount
  - Add-PASAccount
  - Import-PASPlatform
  - New-PASDirectoryMapping
  - Set-PASDirectoryMapping
  - New-PASUser
  - Set-PASUser
  - Get-PASComponentSummary
  - Approve-PASRequest
  - Deny-PASRequest
---

## [7.0.232]

### Added

- N/A

### Updated

- Tests updated for latest module commands
- Applies a general code format update across module functions ensuring consistency.

### Fixed

- `Add-PASSafeMember` & `Set-PASSafeMember`
  - Resolves issue introduced in previous release where, when adding or setting safe permissions in a loop, the loop could break preventing completion fo the task.
  - Thanks [Slasky86](https://github.com/Slasky86)!!
- `Get-PASDependentAccount`
  - Fixes result pagination to ensure all results are returned on command execution.
  - Fixes incorrect filter string being used for request in certain circumstances.
- `Set-PASPTASMTP`
  - Fixes validation logic when specifying parameter values from the pipeline
- `Get-PASAccount`
  - Ensures dynamic parameters are only presented for Self-Hosted users.
  - Thanks [JP-Consulting](https://github.com/johannesconsulting)!!!
- `Get-PASAccountSearchProperty`
  - Enforces command to only be able to be run against self-hosted solutions.
- `Get-PASPTASecurityConfigurationCategory`
  - Fixes issue where URI for request may not be set on command execution.

## **7.0.209**

**Special shout out to [JP-Consulting](https://github.com/johannesconsulting) for the help on this release**

_Update includes almost all updates for the 14.2, 14.4 & 14.6 CyberArk Self-Hosted Releases_

### Added

- `Enable-PASTheme`
  - New 14.6 command to activate a custom UI theme
  - Thanks [JP-Consulting](https://github.com/johannesconsulting)!!!
- `Remove-PASTheme`
  - New 14.6 command to delete a custom UI theme
  - Thanks [JP-Consulting](https://github.com/johannesconsulting)!!!
- `Import-PASThemeImage`
  - New 14.6 command to import an image to use in a custom UI theme
- `Export-PASThemeImage`
  - New 14.6 command to export an image used in a custom UI theme
- `Reset-PASTheme`
  - New 14.6 command to reset the UI theme to default
- `Publish-PASTheme`
  - New 14.6 command to change the draft status of a custom UI theme
- `Get-PASTheme`
  - New 14.6 command to return details of custom UI themes
- `New-PASTheme`
  - New 14.6 command to create a new custom UI theme
- `Set-PASTheme`
  - New 14.6 command to update a custom UI theme
- `Get-PASStoredPlatform`
  - New 14.6 command to get details of platforms stored in memory for import
- `Remove-PASStoredPlatform`
  - New 14.6 command to delete a stored platform from memory
- `Get-PASUserLicenseReport`
  - Returns information about usage of Privilege Cloud user licenses
- `Get-PASReport`
  - New 14.6 command to list reports available to your user
- `Get-PASReportSchedule`
  - New 14.6 command to list report schedules
- `New-PASReportSchedule`
  - New 14.6 command to create a scheduled report
- `Export-PASReport`
  - New 14.6 command to export an available report
- `Remove-PASUserAllowedAuthenticationMethod`
  - New 14.4 command to remove allowed authentication methods from multiple users in a single request
- `Add-PASUserAllowedAuthenticationMethod`
  - New 14.4 command to add allowed authentication methods to multiple users in a single request
- `Remove-PASFIDO2Device`
  - New 14.6 command to remove a configured FIDO2 device from a user
  - Thanks [JP-Consulting](https://github.com/johannesconsulting)!!!
- `Get-PASMasterPolicy`
  - New 14.6 command to list Master Policy settings
- `Set-PASMasterPolicy`
  - New 14.6 command to update Master Policy settings
- `Remove-PASDependentAccount`
  - New 14.6 command to delete dependent accounts
- `Resume-PASDependentAccount`
  - New 14.6 command to resume password management of dependent accounts
  - Thanks [JP-Consulting](https://github.com/johannesconsulting)!!!
- `Get-PASDependentAccount`
  - New 14.6 command to list details of dependent accounts
- `Sync-PASDependentAccount`
  - New 14.6 command to synchronise the password of a dependent account with its master account
  - Thanks [JP-Consulting](https://github.com/johannesconsulting)!!!
- `Set-PASDependentAccount`
  - New 14.6 command to update a dependent account
- `Add-PASDependentAccount`
  - New 14.6 command to add a new dependent account
- `Remove-PASPTASecurityConfigurationProperty`
  - New 14.6 command to delete PTA security configuration properties
  - Thanks [JP-Consulting](https://github.com/johannesconsulting)!!!
- `Reset-PASPTASecurityConfigurationProperty`
  - New 14.6 command to reset PTA security configuration properties
  - Thanks [JP-Consulting](https://github.com/johannesconsulting)!!!
- `Reset-PASPTASecurityConfigurationCategory`
  - New 14.6 command to reset PTA security configuration categories
  - Thanks [JP-Consulting](https://github.com/johannesconsulting)!!!
- `Get-PASPTASecurityConfigurationCategory`
  - New 14.6 command to return PTA security configuration categories
  - Thanks [JP-Consulting](https://github.com/johannesconsulting)!!!
- `Add-PASPTASyslog`
  - New 14.6 command to add a new syslog configuration to PTA
  - Thanks [JP-Consulting](https://github.com/johannesconsulting)!!!
- `Remove-PASPTASyslog`
  - New 14.6 command to remove a syslog configuration from PTA
  - Thanks [JP-Consulting](https://github.com/johannesconsulting)!!!
- `Set-PASPTASMTP`
  - New 14.4 command to add a new SMTP configuration to PTA
  - Thanks [JP-Consulting](https://github.com/johannesconsulting)!!!
- `Get-PASAccountSearchProperty`
  - New 14.6 command to list configured search properties

### Updated

- `Add-PASSafeMember`
  - Updated to include permission pre-sets to match functionality available via PVWA
  - Thanks [Slasky86](https://github.com/Slasky86)!!
- `Set-PASSafeMember`
  - Updated to include permission pre-sets to match functionality available via PVWA
  - Thanks [Slasky86](https://github.com/Slasky86)!!
- `Get-PASAccount`
  - Updated to handle new quoting model for filter operations in version 14.6
  - Adds dynamic search properties to the filter parameters list
  - Thanks [JP-Consulting](https://github.com/johannesconsulting)!!!
- `Add-PASAccount`
  - Added `AllowAccountDuplications` parameter, which works in conjunction with the 14.6 `AccountDuplicationEnforcementLevel` setting
- `Import-PASPlatform`
  - New parameter sets added to support updating existing platforms and side-by-side imports
- `New-PASDirectoryMapping`, `Set-PASDirectoryMapping`
  - Added the `allowedAuthenticationMethods` parameter
  - Thanks [JP-Consulting](https://github.com/johannesconsulting)!!!
- `New-PASUser`, `Set-PASUser`
  - Added the `allowedAuthenticationMethods` parameter
  - Thanks [JP-Consulting](https://github.com/johannesconsulting)!!!
- `Get-PASComponentSummary`
  - Now includes vault replication data in command output
  - Thanks [JP-Consulting](https://github.com/johannesconsulting)!!!
- `Approve-PASRequest`
  - Adds support for bulk approvals using a single request
- `Deny-PASRequest`
  - Adds support for bulk rejections using a single request
- `New-PASAccountPassword`
  - Updated to include additional error checking
- `New-PASAccountObject`
  - Updated to create formatted objects for Dependent Account operations
- `Get-PASSafe`
  - Fixed issue with incorrectly defined `sort` parameter
  - Adds sortDirection parameter to enable ascending or descending sort of safes by SafeName or Managing CPM
- Script Methods
  - `ToCredential()`
    - Available on password objects
    - Allows password values returned from the API to be converted to Credential objects
  - `GetPermissions()`
    - Available on Safe Member objects
    - Enables conversion of safe ACL to hashtable which can be used to splat against Add-PASSafeMember & Set-PASSafeMember
  - `ToHashtable()`
    - Available on Account objects.
    - Converts an Account object to a hashtable so that it can be splatted against Add-PASAccount
- Various corrections to help file contents

### Fixed

- `Get-PASSAMLResponse`
  - Fixes a responsibly disclosed security vulnerability where TLS 1.2 was not enforced when a value for the SAMLResponse parameter was not provided to the New-PASSession command when using the Gen2SAML ParameterSet.
  - Much Respect to [Cristian Gaber](https://cgaber.com) for highlighting this to us.
- `Get-PASAccountPassword`
  - Fixes a parsing issue that could affect password values returned from the command.
  - Thanks [ChristopherRanney](https://github.com/ChristopherRanney)!!
- `Add-PASPublicSSHKey`, `Get-PASPublicSSHKey`, `Remove-PASPublicSSHKey`
  - Corrects the URLs used by the commands
  - Thanks [JP-Consulting](https://github.com/johannesconsulting)!!!
