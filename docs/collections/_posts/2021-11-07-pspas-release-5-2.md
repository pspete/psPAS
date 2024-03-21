---
title:  "psPAS Release 5.2"
date:   2021-11-07 00:00:00
tags:
 - Release Notes
 - Get-PASAccountDetail
 - Invoke-PASCPMOperation
 - Unblock-PASUser
 - Set-PASUser
 - Remove-PASUser
 - New-PASUser
 - Add-PASGroupMember
 - Get-PASGroup
 - Get-PASUser
 - Get-PASSafe
 - Get-PASPlatformSummary
 - Clear-PASLinkedAccount
 - Revoke-PASJustInTimeAccess
 - Get-PASAccountDetail
 - Set-PASSafe
 - Remove-PASSafeMember
 - Set-PASSafeMember
 - Request-PASJustInTimeAccess
 - Get-PASSafeMember
---

## **5.2.59 (November 7th 2021)**

- Fix
  - Resolves issue where `Get-PASSafeMember` would fail with error when using Gen2 API and specifying `MemberName` parameter.
  - Resolves issue where `Set-PASSafe` would fail with error when using Gen2 API.
    - (Thanks [alexR148](https://github.com/alexR148)!).

## **5.2.54 (July 28th 2021)**

- Fix
  - Added `Request-PASJustInTimeAccess` as Exported Function in `psPAS.psd1`.

## **5.2.52 (July 27th 2021)**

### Module update to cover all CyberArk 12.2 API features

- Breaking Changes
  - `Request-PASJustInTimeAccess`
    - Command renamed from `Request-PASAdHocAccess` in line with CyberArk feature nomenclature.
  - `Get-PASSafeMember`
    - Adds capability to get permissions for individual safe member using the Gen2 API from 12.2 onward.
    - Addition of `UseGen1API` parameter allows operation against Gen1 API if required.
  - `Set-PASSafeMember`
    - Adds Gen2 API capability introduced in 12.2.
    - Default operation is now via Gen2 API.
    - Addition of `UseGen1API` parameter allows operation against Gen1 API if required.
  - `Remove-PASSafeMember`
    - Adds support for operation against Gen2 API introduced in PAS 12.2
    - Default operation now requires 12.2
    - `UseGen1API` parameter added to force operation against Gen1 API for earlier PAS versions.
  - `Set-PASSafe`
    - Adds Gen2 API capability introduced in 12.2.
    - Default operation is now via Gen2 API.
    - Addition of `UseGen1API` parameter allows operation against Gen1 API if required.
- New Commands
  - `Get-PASAccountDetail`
    - New experimental function developed using unofficial documentation
  - `Revoke-PASJustInTimeAccess`
    - New API function supported from 12.0 (previously missed)
    - Revokes requested JIT access.
  - `Clear-PASLinkedAccount`
    - Unlinks associated Logon/Reconcile/ExtraPass accounts
  - `Get-PASPlatformSummary`
    - Returns basic platform system type information
- Other Updates
  - `Get-PASSafe`
    - Implements Get Individual Safe details using Gen2 API feature of PAS 12.2.
    - Adds `UseGen1API` parameter to allow backward compatibility when using the `SafeName` parameter.
    - Changes depreciation of Gen1 API operations from 12.2 to 12.3.
  - `Get-PASUser`
    - New `sort` parameter added, supported from 12.2.
    - Added ability to filter by UserName using Gen2 API.
    - Gen1 search by UserName now accessible by also specifying the introduced `UseGen1API` parameter.
  - `Get-PASGroup`
    - New `sort` parameter added, supported from 12.2.
  - `Add-PASGroupMember`
    - Added version check to prevent use of Gen1 API starting from 12.3 in line with documented plan for API depreciation
  - `New-PASUser`
    - Added version check to prevent use of Gen1 API starting from 12.3 in line with documented plan for API depreciation
  - `Remove-PASUser`
    - Added version check to prevent use of Gen1 API starting from 12.3 in line with documented plan for API depreciation
  - `Set-PASUser`
    - Added version check to prevent use of Gen1 API starting from 12.3 in line with documented plan for API depreciation
  - `Unblock-PASUser`
    - Added version check to prevent use of Gen1 API starting from 12.3 in line with documented plan for API depreciation
  - Account Methods updated to apply to account details obtained via Gen2 API calls
    - `VerifyPassword()`
      - Updated method to use `Invoke-PASCPMOperation`
    - `ChangePassword()`
      - Updated method to use `Invoke-PASCPMOperation`
    - `ReconcilePassword()`
      - New method using `Invoke-PASCPMOperation`
    - `GetDetails()`
      - New method using `Get-PASAccountDetail`
  - Alias Removal
    - Removed alias values for previously deprecated command names
