---
title:  "psPAS Release 3.3"
date:   2019-12-13 00:00:00
tags:
  - Release Notes
  - New-PASSession
  - New-PASRequest
  - Get-PASAccountPassword
  - Set-PASUser
  - Remove-PASUser
  - Get-PASPlatform
  - Add-PASDiscoveredAccount
  - Set-PASDirectoryMapping
  - Disable-PASCPMAutoManagement
  - Enable-PASCPMAutoManagement
  - Remove-PASDirectoryMapping
  - Get-PASPlatformSafe
  - New-PASGroup
---

## 3.3.88 (December 13th 2019)

### Module update to cover CyberArk 11.1 API features

- New Functions
  - `New-PASGroup`
    - Creates CyberArk Groups
    - Requires 11.1
  - `Get-PASPlatformSafe`
    - List safes by platform id
    - Requires 11.1
  - `Remove-PASDirectoryMapping`
    - Delete Directory Mappings
    - Requires 11.1
  - `Enable-PASCPMAutoManagement`
    - Enable Automatic CPM Management for an Account.
    - Requires 10.4+
  - `Disable-PASCPMAutoManagement`
    - Disable Automatic CPM Management for an Account.
    - Requires 10.4+

- Updated Functions
  - `Set-PASDirectoryMapping`
    - MappingAuthorizations parameter no longer accepts pipeline input
  - `Add-PASDiscoveredAccount`
    - Added features introduced in version 10.8
    - Supports Account Dependency & AWS specific parameters
  - `Get-PASPlatform`
    - Added features introduced in version 11.1
    - New options for finding platforms
  - `Remove-PASUser`
    - Added features introduced in version 11.1
    - Delete User by ID
  - `Set-PASUser`
    - Added features introduced in version 11.1
    - Expanded options for updating users.
  - `New-PASSession`
    - Added `Certificate` parameter to allow specification of a client certificate to be used for a secure web request.

- Fixes & Other Updates
  - `Get-PASAccountPassword`
    - Fixed incorrectly escaped value for passwords beginning with "\"
  - `New-PASRequest`
    - Fixed incorrect parameter name which prevented requests specifying multiple access as required being created.
  - Error Reporting
    - Added more verbose error messages.
