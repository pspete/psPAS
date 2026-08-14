---
title: "psPAS Release 8.0"
date: 2026-08-14 00:00:00
tags:
  - Release Notes
  - Set-PASPlatform
  - New-PASPlatformSecret
  - Stop-PASCPMTask
  - Resume-PASCPMAutoManagement
  - Remove-PASOAuthProvider
  - Remove-PASReportTask
  - Test-PASDiscoveredLocalAccount
  - New-PASDiscoveredAccountObject
  - Disable-PASBYOKConfig
  - Enable-PASBYOKConfig
  - Set-PASBYOKConfig
  - Get-PASBYOKPolicyStatement
  - Invoke-PASBYOKRotation
  - Hide-PASDiscoveredLocalAccount
  - Restore-PASDiscoveredLocalAccount
  - Set-PASDiscoveredLocalAccount
  - Get-PASDiscoveryScan
  - Remove-PASDiscoveryScan
  - Stop-PASDiscoveryScan
  - Add-PASDiscoveryScan
  - Get-PASReportActivity
  - Add-PASOAuthProvider
  - Get-PASOAuthProvider
  - Set-PASOAuthProvider
  - Set-PASReportTask
  - Get-PASSessionTimeout
  - Get-PASPlatform
  - Get-PASReportTask
  - New-PASReportTask
  - Get-PASReport
  - Get-PASMasterPolicy
  - Set-PASMasterPolicy
  - Set-PASSafe
  - Get-PASVRMServiceStatus
  - Start-PASVRMService
  - Stop-PASVRMService
  - Restart-PASVRMService
  - Get-PASGroup
  - Remove-PASAccount
  - Clear-PASDependentLinkedAccount
  - Set-PASDependentLinkedAccount
  - Clear-PASLinkedAccount
  - Set-PASLinkedAccount
  - Resume-PASDependentAccount
  - Unlock-PASAccount
  - Invoke-PASCPMOperation
  - Add-PASDiscoveredLocalAccount
  - Publish-PASDiscoveredLocalAccount
  - Get-PASSafeMember
  - Get-PASSafe
  - Find-PASSafe
  - Get-PASPSMSession
  - Get-PASPSMRecording
  - Get-PASDependentAccount
  - Get-PASAccount
  - Clear-PASDiscoveredAccount
  - Add-PASDiscoveredAccount
  - Set-PASPTAEvent
  - New-PASUser
  - Set-PASUser
  - New-PASDirectoryMapping
  - Set-PASDirectoryMapping
  - Get-PASUser
  - New-PASSession
  - Get-PASAccountSSHKey
  - Get-PASServer
  - Get-PASLoggedOnUser
  - Get-PASSession
  - Out-PASFile
  - Export-PASTicketingSystemLog
---

## [8.0.3]

### Fixed

- `Set-PASLinkedAccount`, `Clear-PASLinkedAccount`, `Resume-PASDependentAccount`
  - Fixes a regression introduced in 8.0.0's bulk operation support, where the `safe`/`extraPasswordIndex`/`name`/`folder`/`dependentAccountId` parameters were incorrectly changed to accept multiple values.
  - This caused request bodies to send these values as JSON arrays instead of the single scalar values the API expects, resulting in `PASWS168E`/invalid parameter errors even for standard, non-bulk usage.
  - `Set-PASLinkedAccount`/`Clear-PASLinkedAccount` bulk requests continue to be driven by supplying more than one `-AccountID`.
  - `Resume-PASDependentAccount` bulk requests are now correctly driven by supplying more than one `-dependentAccountId` for a single `-AccountID`, reflecting that a dependent account can only ever belong to one source account.

## [8.0.0]

_Update includes almost all updates for the 15.2, Idira Self-Hosted & latest Privilege Cloud Releases_

psPAS 8.0.0 is the module's biggest release in a while, bringing coverage for a wide swathe of new CyberArk 15.2/Self-Hosted and Privilege Cloud API surface alongside a set of quality-of-life and security fixes across existing commands. Highlights include:

- **Platform management** - `Set-PASPlatform` and `New-PASPlatformSecret` add the ability to update target platform settings and generate platform secrets, and `Get-PASPlatform` now merges the newer "Get Platforms" API into its results by default (a breaking change to its output shape, removing the `PlatformType` parameter in the process).
- **Discovery** - a full set of discovery scan commands (`Get-PASDiscoveryScan`, `Add-PASDiscoveryScan`, `Stop-PASDiscoveryScan`, `Remove-PASDiscoveryScan`) plus new Privilege Cloud discovered-local-account handling (`Hide-`/`Restore-`/`Set-PASDiscoveredLocalAccount`, `Test-PASDiscoveredLocalAccount`) round out account discovery workflows.
- **OAuth Identity Providers** - `Add-`/`Get-`/`Set-`/`Remove-PASOAuthProvider` let you configure and inspect OAuth 2.0 identity providers on Self-Hosted environments.
- **Reporting** - `Get-PASReportSchedule`/`New-PASReportSchedule` are renamed to `Get-PASReportTask`/`New-PASReportTask`, gain a new `Remove-PASReportTask` counterpart, pagination, filtering and a `Filters` parameter, and `Get-PASReportActivity` exposes the activity groups available for reports.
- **BYOK (Bring Your Own Key)** - `Enable-`/`Disable-`/`Set-PASBYOKConfig`, `Get-PASBYOKPolicyStatement` and `Invoke-PASBYOKRotation` bring key management for Privilege Cloud tenants into psPAS for the first time.
- **Session lifecycle** - `New-PASSession` adds SAML-based logon (`ISPSS-Subdomain-SAML`/`ISPSS-URL-SAML` parameter sets) and now tracks the server's idle session timeout (via the new `Get-PASSessionTimeout`), with `Get-PASSession` surfacing `IdleTimeout`/`SessionTimeRemaining` and helper methods so scripts can detect and avoid idle timeouts.
- **Bulk operations** - `Resume-PASCPMAutoManagement`, `Invoke-PASCPMOperation`, `Clear-PASLinkedAccount`, `Set-PASLinkedAccount`, `Resume-PASDependentAccount`, `Stop-PASCPMTask` and `Unlock-PASAccount` gain or extend support for sending a single bulk request instead of one call per account.
- **Security hardening** - secret-bearing request bodies across `New-PASSession`, `New-PASUser`, `Set-PASUser`, `Add-PASAccount` and others now convert and decode secrets as late as possible, reducing the window in which plaintext could be captured by PowerShell's parameter-binding trace or Module Logging.
- **`-WhatIf`/`-Confirm` support** lands on a large batch of previously non-`ShouldProcess` state-changing commands (`Add-PASAccount`, `Add-PASSafe`, `Add-PASSafeMember`, `Enable-`/`Disable-PASCPMAutoManagement`, and more).
- **Argument completers** - tab-completion is added or extended in several places: `Get-PASPlatform` swaps a `ValidateSet` for an `ArgumentCompleter` on target scope values; `New-PASUser`/`Set-PASUser`/`New-PASDirectoryMapping`/`Set-PASDirectoryMapping` gain completers for `AuthorizedInterfaces`/`unAuthorizedInterfaces` sourced from the environment's licensed client IDs; `New-PASUser`/`Set-PASUser`/`Get-PASUser` gain a `UserType` completer sourced from the environment's configured user types; and `Set-PASAccount` gains one for `Path`. In each case the values are pulled live from the connected environment rather than hard-coded, so completions are accurate for your environment's configuration.

As always, huge thanks to [JP-Consulting](https://github.com/johannesconsulting) for another large wave of contributions across this release. The full breakdown of additions, updates and fixes follows below:

### Added

- `Set-PASPlatform`
  - New function to update settings of a target platform
  - Requires Idira 15.2+ Self-Hosted
  - Thanks [JP-Consulting](https://github.com/johannesconsulting)!!!
- `New-PASPlatformSecret`
  - New function to generate a secret for a platform
  - Requires Idira 15.2+ Self-Hosted
- `Stop-PASCPMTask`
  - New function to cancel a pending CPM task for an account
  - Requires Idira 15.2+ Self-Hosted
- `Resume-PASCPMAutoManagement`
  - New function to resume CPM automatic management of an account
  - Requires Idira 15.2+ Self-Hosted
- `Remove-PASOAuthProvider`
  - New function to delete a configured OAuth Identity Provider
  - Requires Idira 15.0+ Self-Hosted
  - Thanks [JP-Consulting](https://github.com/johannesconsulting)!!!
- `Remove-PASReportTask`
  - New function to delete a report task
- `Test-PASDiscoveredLocalAccount`
  - New function to check whether discovered accounts already exist in the vault
- `New-PASDiscoveredAccountObject`
  - New helper function to build a correctly structured discovered account object for use with `Test-PASDiscoveredLocalAccount`
- `Disable-PASBYOKConfig`, `Enable-PASBYOKConfig`, `Set-PASBYOKConfig`, `Get-PASBYOKPolicyStatement`, `Invoke-PASBYOKRotation`
  - New functions to manage Bring Your Own Key (BYOK) configuration
  - Requires Privilege Cloud
- `Hide-PASDiscoveredLocalAccount`, `Restore-PASDiscoveredLocalAccount`, `Set-PASDiscoveredLocalAccount`
  - New functions to ignore/restore/edit Privilege Cloud discovered local accounts
  - Requires Privilege Cloud
- `Get-PASDiscoveryScan`, `Remove-PASDiscoveryScan`, `Stop-PASDiscoveryScan`, `Add-PASDiscoveryScan`
  - New functions to retrieve, delete, add, and stop discovery scans
  - Requires Idira 12.2+ Self-Hosted
- `Get-PASReportActivity`
  - New function to get the list of activity groups available for reports
  - Requires Idira 15.0+
- `Add-PASOAuthProvider`, `Get-PASOAuthProvider`, `Set-PASOAuthProvider`
  - New functions to configure and retrieve OAuth 2.0 Identity Providers
  - Requires Idira 15.0+ Self-Hosted
- `Set-PASReportTask`
  - New function to update an existing report task schedule
  - Requires Idira 14.6+
- `Get-PASSessionTimeout`
  - New function to retrieve the idle session timeout configured on the server
  - Requires Idira 13.2+ Self-Hosted

### Updated

- `Get-PASPlatform`
  - Breaking change: removes the `PlatformType` parameter/parameter set
  - The "Get Platforms" API is now additionally called by default, with its results merged into those of the legacy platform details endpoint, so the shape of the returned results differ from previous versions, but the command is hopefully less confusing to run.
  - Adds a `target-details` parameter set exposing the new "Get target platform settings" API
    - Requires Idira 15.2+ Self-Hosted
  - Replaces a `ValidateSet` with an `ArgumentCompleter` for target scope values
- `Get-PASReportSchedule`, `New-PASReportSchedule`
  - Renamed to `Get-PASReportTask` and `New-PASReportTask` respectively
  - `Get-PASReportTask` adds pagination, and `search`/`subType`/`name`/`FilterLogicalOperator`/`limit` parameters
- `Get-PASReport`
  - Replaces the `filter` parameter with individual parameters for each filterable report property
  - Adds `limit` and `search` parameters, and result pagination
  - Allows sorting results by the `createdAt` property
- `Get-PASMasterPolicy`, `Set-PASMasterPolicy`
  - Adds a `PolicyId` parameter, defaulted to `1`, to support master policy exceptions defined on platforms
  - Requires Idira 15.0+ Self-Hosted when a `PolicyId` other than `1` is specified
- `Set-PASSafe`
  - Adds a `Quota` parameter
    - Requires Idira 15.2+
  - Allows `NumberOfVersionsRetention` to be set to `0`
- `Get-PASVRMServiceStatus`, `Start-PASVRMService`, `Stop-PASVRMService`, `Restart-PASVRMService`
  - Adds the `ENE` service name value
    - Requires Idira 15.2+
- `Get-PASGroup`
  - Pipes `groupType` query results through pagination
  - Adds a `limit` parameter (maximum `20000`) to the `groupType` parameter set
- `Remove-PASAccount`
  - Adds a `DeleteSSHKey` parameter, mapped to `deleteOnlyPrivateSshKey` for Privilege Cloud or `deleteSshKeyFromVaultAndTarget` for Self-Hosted
    - Self-Hosted requires Idira 15.2+
- `Clear-PASDependentLinkedAccount`, `Set-PASDependentLinkedAccount`
  - Adds support for Self-Hosted environments
  - Thanks [JP-Consulting](https://github.com/johannesconsulting)!!!
- `Clear-PASLinkedAccount`, `Set-PASLinkedAccount`, `Resume-PASDependentAccount`, `Stop-PASCPMTask`, `Unlock-PASAccount`
  - Enhances bulk operation support
  - Thanks [JP-Consulting](https://github.com/johannesconsulting)!!!
- `Resume-PASCPMAutoManagement`, `Invoke-PASCPMOperation`
  - Adds bulk operation support: `AccountID` accepts `string[]`, sending a single bulk request instead of one call per account when multiple IDs are passed
  - Bulk requires Idira 15.2+ Self-Hosted, and isn't available to `Invoke-PASCPMOperation` via `-UseGen1API`/`-ImmediateChangeByCPM`
- `Add-PASDiscoveredLocalAccount`, `Publish-PASDiscoveredLocalAccount`
  - Adds a `tags` parameter
- `New-PASReportTask`
  - Adds a `Filters` parameter, with validation of filter names against known values for the report `subType`
    - Requires Idira 15.0+ when `Filters` is specified
  - `subType` is now validated against a `ValidateSet` of known report types
- `Get-PASReportTask`, `Get-PASReport`
  - Output objects gain a `psPAS.CyberArk.Vault.Task`/`psPAS.CyberArk.Vault.Report` type name, enabling default formatting
- `Get-PASSafe`, `Find-PASSafe`, `Get-PASSafeMember`, `Get-PASReportTask`, `Get-PASReport`, `Get-PASPSMSession`, `Get-PASPSMRecording`, `Get-PASDependentAccount`
  - Use an updated `Get-NextLink` helper, capable of paginating result sets which don't return a `NextLink`/`NextCursor` property
- `Get-PASAccount`
  - Adds `DeleteInsightStatus` savedFilter value, applicable to Privilege Cloud
- `Clear-PASDiscoveredAccountList`
  - Renamed to `Clear-PASDiscoveredAccount`
- `Add-PASDiscoveredAccount`
  - Allows account duplications
- `Set-PASPTAEvent`
  - Adds additional parameters for closing events
- `New-PASUser`, `Set-PASUser`, `New-PASDirectoryMapping`, `Set-PASDirectoryMapping`
  - `AuthorizedInterfaces`/`unAuthorizedInterfaces` parameters gain an `ArgumentCompleter` sourced from the licensed client IDs of the current environment
- `New-PASUser`, `Set-PASUser`, `Get-PASUser`
  - `UserType` parameter gains an `ArgumentCompleter` sourced from the configured user types of the current environment
- `Set-PASAccount`
  - Adds an `ArgumentCompleter` for the `Path` parameter
- `New-PASSession`
  - Adds `ISPSS-Subdomain-SAML` and `ISPSS-URL-SAML` parameter sets, allowing a SAML assertion to be exchanged for an authenticated Identity Shared Services/Privilege Cloud session, alongside the existing IdentityUser/ServiceUser flows
  - Rationalises the command's examples down to one per parameter set, and refreshes the description to drop outdated CyberArk version-support trivia
- `Get-PASAccountSSHKey`
  - Adds a `Path` parameter, to save the retrieved SSH key directly to a file
- `Add-PASAccountGroupMember`, `New-PASAccountGroup`, `Get-PASAccount`, `Get-PASDependentAccount`, `Get-PASDiscoveredAccount`, `Get-PASDiscoveredLocalAccount`, `Set-PASDependentLinkedAccount`, `Set-PASLinkedAccount`, `Add-PASAuthenticationMethod`, `Add-PASOpenIDConnectProvider`, `Set-PASAuthenticationMethod`, `Set-PASDirectoryMapping`, `Get-PASPSMRecording`, `Get-PASPSMSession`, `Get-PASPlatform`, `Get-PASReport`, `Get-PASReportTask`, `New-PASReportTask`, `Set-PASReportTask`, `Get-PASSafeMember`, `Find-PASSafe`, `Get-PASSafe`, `Get-PASGroup`, `Get-PASUser`, `New-PASGroup`, `New-PASUser`, `Set-PASGroup`, `Set-PASUser`
  - Adds parameter length validation attributes
  - Thanks [JP-Consulting](https://github.com/johannesconsulting)!!!
- `Get-PASServer`, `Get-PASLoggedOnUser`
  - Use their Gen2 endpoints by default
- `Get-PASSession`
  - Adds `IdleTimeout`, `SessionTimeRemaining` and `SessionWarningThreshold` to the returned session data, and `GetRemainingSessionTime()`/`Refresh()` methods to the returned object, to help track and avoid idle session timeouts - see [API Sessions](https://pspas.pspete.dev/docs/api-sessions/) and [Methods](https://pspas.pspete.dev/docs/methods/)
- `New-PASSession`
  - Retrieves and stores the idle session timeout (via `Get-PASSessionTimeout`, where supported) at logon, for use by the above `Get-PASSession` additions
- Requests made via `Invoke-PASRestMethod` now emit a warning when the session is close to idle-timing out, based on the tracked idle timeout
- `Add-PASAccount`, `Add-PASAccountACL`, `Add-PASAccountGroupMember`, `Add-PASAllowedReferrer`, `Add-PASApplication`, `Add-PASApplicationAuthenticationMethod`, `Add-PASAuthenticationMethod`, `Add-PASDirectory`, `Add-PASDiscoveredAccount`, `Add-PASDiscoveredLocalAccount`, `Add-PASGroupMember`, `Add-PASOAuthProvider`, `Add-PASOpenIDConnectProvider`, `Add-PASPTAGlobalCatalog`, `Add-PASPTARule`, `Add-PASPTASyslog`, `Add-PASPendingAccount`, `Add-PASPersonalAdminAccount`, `Add-PASPolicyACL`, `Add-PASPublicSSHKey`, `Add-PASSafe`, `Add-PASSafeMember`, `Disable-PASCPMAutoManagement`, `Enable-PASCPMAutoManagement`, `Revoke-PASJustInTimeAccess`
  - Adds `SupportsShouldProcess`/`-WhatIf`/`-Confirm` support to state-changing functions which did not already have it

### Fixed

- Secret-bearing request bodies
  - `New-PASSession`, `New-PASUser`, `Set-PASUser`, `Set-PASUserPassword`, `Add-PASAccount`, `Publish-PASDiscoveredAccount`, `Publish-PASDiscoveredLocalAccount`, Vault Remote Manager functions and others now convert decoded secrets to UTF8 bytes, and decode secrets as late as possible in each function, reducing the risk of plaintext secret exposure via PowerShell's ParameterBinding trace/Windows Module Logging
- `New-PASSession`
  - Fixes an edge case where a variable name could collide with a parameter name
- `New-PASReportTask`
  - Adds `-Depth 4` to the `ConvertTo-Json` call, as the `Subscribers` parameter accepts objects that nest to 4 levels
  - Corrects the nested structure used for Schedule Recurrence
- `Get-PASReportTask`
  - Fixes an output issue when the `id` parameter is specified
- `Test-PASDiscoveredLocalAccount`
  - Corrects the request body property name (`accounts` instead of `account`)
- `New-PASRequest`
  - Fixes JSON conversion of the `BulkItems` request body, which nests 5 levels deep
- `Out-PASFile`
  - Allows a full path, including filename, to be specified, in addition to a path to a folder
  - Thanks [everyone who reported #551](https://github.com/pspete/psPAS/issues/551)!
- `Export-PASTicketingSystemLog`
  - Updates the API URL and renames the `UserId` parameter to `username`, in line with changes made in vendor documentation
- `Get-PASAccount`
  - Fixes an issue where dynamic search-property lookups performed against Idira 14.4+ (to build search parameters) could overwrite `LastCommand`/`LastCommandResult` in the session; results are now read from a cache instead of calling `Get-PASAccountSearchProperty` directly, and internal helper calls no longer clobber session state
