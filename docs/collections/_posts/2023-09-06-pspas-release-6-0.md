---
title:  "psPAS Release 6.0"
date:   2023-11-14 00:00:00
tags:
  - Release Notes
  - New-PASSession
  - IdentityCommand
  - Add-PASSafeMember
  - Set-PASSafe
  - Get-PASServerWebService
  - Get-PASSafeShareLogo
  - Invoke-PASCPMOperation
  - Get-PASAccountActivity
  - Add-PASPendingAccount
  - Get-PASAccount
  - Add-PASPTARule
  - Set-PASPTARule
  - Add-PASApplication
  - Set-PASPTAEvent
  - Set-PASPTARiskEvent
---

## **6.0.30**

### Added
 - N/A

 ### Updated
- `Add-PASPTARule` & `Set-PASPTARule`
  - Adds scope parameters `vaultUsersMode`, `vaultUsersList`, `machinesMode` & `machinesList`
  - Includes scope property in output by default

 ### Fixed
- `Add-PASApplication`
   - Updates date format of `ExpirationDate` to `MM/dd/yyyy`. Resolves issue observed when sending date format of `MM-dd-yyyy`
- `Set-PASPTAEvent` & `Set-PASPTARiskEvent`
  - Fixes issue where websession object and auth header were not being sent with the request

## **6.0.21**

### Added
 - N/A

 ### Updated
 - N/A

 ### Fixed
 - Debug Trace Output
   - Resolves condition where authentication password value might be revealed in debug trace output in a scenario where  `Set-PSDebug -Trace 2` is active in the console host.

## **6.0.18**

### Added
- N/A

### Changed
- `Set-PASSafe`
  - Allows `0` as valid value for parameter `NumberOfDaysRetention`
- `Get-PASServerWebService`
  - Deprecates Gen1 endpoint from 13.2. Adds Gen2 endpoint as default.
- `Get-PASSafeShareLogo`
  - Deprecates command from 13.2.
- `Invoke-PASCPMOperation`
  - Deprecates Gen1 endpoint from 13.2.
- `Get-PASAccountActivity`
  - Deprecates command from 13.2.
- `Add-PASPendingAccount`
  - Deprecates command from 13.2.

### Fixed
- `Get-PASAccount`
  - Resolves issue where, if number of results of a `SavedFilter` are greater than the page size (either default or set via the `limit` parameter), only the URL of the first request sent would include the SavedFilter value.

## **6.0.4**

- Updated
  - `Add-PASSafeMember`
    - Adds 'Role' to acceptable values in ParameterSet for `memberType` parameter

## **6.0.0**

- Update & Breaking Change
  - `New-PASSession`
    - **All Privilege Cloud Shared Services Authentication via the CyberArk Identity Platform now depends on the pspete `IdentityCommand` module.**
    - Adds Identity User Authentication, using the `IdentityCommand` module to satisfy Identity MFA challenges and obtain required authentication token to use against Privileged Cloud Shared Services.
    - Adds logic to determine correct Identity tenant URL based on provided Privileged Cloud Subdomain value.
    - Both Privileged Cloud API URL & Identity Portal URL are required to be specified if subdomain value is not provided.
    - Service User authentication for Shared Services introduced in recent previous versions requires installation of `IdentityCommand` module and specification of additional attribute.
    - See [the docs](https://pspas.pspete.dev/docs/authentication/#shared-services-authentication) & [New-PASSession](https://pspas.pspete.dev/commands/New-PASSession) for full details.

