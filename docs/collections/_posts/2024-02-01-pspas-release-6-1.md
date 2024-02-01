---
title: "psPAS Release 6.1"
date: 2024-02-01 00:00:00
tags:
  - Release Notes
  - Add-PASPTAExcludedTarget
  - Add-PASPTAIncludedTarget
  - Add-PASPTAPrivilegedGroup
  - Add-PASPTAPrivilegedUser
  - Get-PASPTAExcludedTarget
  - Get-PASPTAIncludedTarget
  - Get-PASPTAPrivilegedGroup
  - Get-PASPTAPrivilegedUser
  - Remove-PASPTAExcludedTarget
  - Remove-PASPTAIncludedTarget
  - Remove-PASPTAPrivilegedGroup
  - Remove-PASPTAPrivilegedUser
  - Get-PASLinkedGroup
  - Get-PASAccountActivity
  - Get-PASPTARiskEvent
  - New-PASDirectoryMapping
  - Set-PASDirectoryMapping
  - Invoke-PASRestMethod
---

## **6.1.47**

### Module update to cover all CyberArk 14.0 API features

### Added
- New commands supported from 14.0:
  - `Add-PASPTAExcludedTarget`
  - `Add-PASPTAIncludedTarget`
  - `Add-PASPTAPrivilegedGroup`
  - `Add-PASPTAPrivilegedUser`
  - `Get-PASPTAExcludedTarget`
  - `Get-PASPTAIncludedTarget`
  - `Get-PASPTAPrivilegedGroup`
  - `Get-PASPTAPrivilegedUser`
  - `Remove-PASPTAExcludedTarget`
  - `Remove-PASPTAIncludedTarget`
  - `Remove-PASPTAPrivilegedGroup`
  - `Remove-PASPTAPrivilegedUser`
- `Get-PASLinkedGroup`
  - New experimental command based on undocumented API.

 ### Updated
- `Get-PASAccountActivity`
  - Adds Gen2 replacement for deprecated Gen1 API.
  - Updates default operation to target Gen2 API.
- `Get-PASPTARiskEvent`
  - New filter parameters `FromTime` & `ToTime`
  - Fixes output and result paging
- `Set-PASPTARiskEvent`
  - New parameters `closeReason` & `reasonText`
  - General Fixes
- `New-PASDirectoryMapping`
  - New parameters `UsedQuota`, `AuthorizedInterfaces` & `EnableENEWhenDisconnected`
- `Set-PASDirectoryMapping`
  - New parameters `UsedQuota`, `AuthorizedInterfaces` & `EnableENEWhenDisconnected`

 ### Fixed
- `Invoke-PASRestMethod`
  - Avoids potential error condition when handling errors in ISPSS environments