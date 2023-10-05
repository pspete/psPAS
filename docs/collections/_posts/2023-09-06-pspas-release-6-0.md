---
title:  "psPAS Release 6.0"
date:   2023-10-06 00:00:00
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

---

## **6.0.18**

### Added
- N/A

### Changed
- `Set-PASSafe`
  - Allows `0` as valid value for parameter `NumberOfDaysRetention`
- `Get-PASServerWebService`
  - Depreciates Gen1 endpoint from 13.2. Adds Gen2 endpoint as default.
- `Get-PASSafeShareLogo`
  - Depreciates command from 13.2.
- `Invoke-PASCPMOperation`
  - Depreciates Gen1 endpoint from 13.2.
- `Get-PASAccountActivity`
  - Depreciates command from 13.2.
- `Add-PASPendingAccount`
  - Depreciates command from 13.2.

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