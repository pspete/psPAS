---
title: "psPAS Release 7.2"
date: 2026-07-19 00:00:00
tags:
  - Release Notes
  - Clear-PASDependentLinkedAccount
  - Set-PASDependentLinkedAccount
  - Register-PASFIDO2Device
  - Get-PASVRMServiceConfig
  - Get-PASVRMServiceConfigParameter
  - Get-PASVRMServiceStatus
  - Get-PASVRMDRSystemHealth
  - Set-PASVRMServiceConfig
  - Start-PASVRMService
  - Stop-PASVRMService
  - Restart-PASVRMService
  - Invoke-PASVRMFailover
  - Import-PASTicketingSystem
  - Export-PASTicketingSystemLog
  - Rename-PASPlatform
  - Add-PASDependentAccount
  - Get-PASDependentAccount
  - Set-PASDependentAccount
  - Remove-PASDependentAccount
  - Approve-PASRequest
  - New-PASSession
  - New-PASUser
  - Set-PASUser
  - New-PASDirectoryMapping
  - Set-PASDirectoryMapping
---

## [7.2.0]

**More recognition to [JP-Consulting](https://github.com/johannesconsulting) for the help on this release and ongoing project sponsorship**

### Added

- `Clear-PASDependentLinkedAccount`
  - New Function to remove a linked account from a dependent account
- `Set-PASDependentLinkedAccount`
  - New Function to link an account to a dependent account
- `Register-PASFIDO2Device`
  - New Function to register a FIDO2 device, either for the logged on user or, as an administrator, on behalf of another user
  - Performs the WebAuthn ceremony locally via `webauthn.dll`; requires Windows 10 1903+ and CyberArk 14.6+
- Vault Remote Manager (VRM) commands
  - `Get-PASVRMServiceConfig`
  - `Get-PASVRMServiceConfigParameter`
  - `Get-PASVRMServiceStatus`
  - `Get-PASVRMDRSystemHealth`
  - `Set-PASVRMServiceConfig`
  - `Start-PASVRMService`
  - `Stop-PASVRMService`
  - `Restart-PASVRMService`
  - `Invoke-PASVRMFailover`
- Custom Ticketing System commands
  - `Import-PASTicketingSystem`
  - `Export-PASTicketingSystemLog`
- `Rename-PASPlatform`
  - New Function to rename a platform ID

### Updated

- `Add-PASDependentAccount`
  - Adds logic to work against ISPSS endpoints which use different URL paths to Self-Hosted
- `Get-PASDependentAccount`
  - Adds logic to work against ISPSS endpoints which use different URL paths to Self-Hosted
- `Set-PASDependentAccount`
  - Adds logic to work against ISPSS endpoints which use different URL paths to Self-Hosted
- `Remove-PASDependentAccount`
  - Adds logic to work against ISPSS endpoints which use different URL paths to Self-Hosted
- `Approve-PASRequest`
  - Adds logic to prevent bulk approvals being sent to ISPSS as this is not a supported action.
- `New-PASSession`
  - Replaces third-party `DSInternals.Win32.WebAuthn.dll` dependency with an inline P/Invoke wrapper around the built-in Windows `webauthn.dll` for FIDO2 authentication
- `New-PASUser` / `Set-PASUser` / `New-PASDirectoryMapping` / `Set-PASDirectoryMapping`
  - Adds `PKIPN` as an allowed value for `allowedAuthenticationMethods`
- `Set-PASUser`
  - Extends `loginToHour` to accept a range of 0-24 (previously 0-23)
  - Adds `IBVSDK` as an allowed value for `unAuthorizedInterfaces`
  - Adds a missing `vaultAuthorization` value

### Fixed

- `ConvertTo-FilterString`
  - Defaults `LogicalOperator` to `AND` to avoid sending filters with an empty logical operator
