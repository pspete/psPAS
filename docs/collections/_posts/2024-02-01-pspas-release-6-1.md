---
title: "psPAS Release 6.1"
date: 2024-02-07 00:00:00
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
  - Get-PASPSMRecording
  - Get-PASPSMSession
  - Get-PASAccount
  - Get-PASDiscoveredAccount
  - Get-PASSession
  - Get-PASPlatform
---

## **6.1.62**

### Added
- N/A

### Updated
- `Get-PASPSMRecording`
  - Removes `Offset` Parameter
  - Updates `FromTime` & `ToTime` parameters to `[datetime]` types
  - Returns all pages of results instead of only the first page of results
- `Get-PASPSMSession`
  - Removes `Offset` Parameter
  - Updates `FromTime` & `ToTime` parameters to `[datetime]` types
  - Returns all pages of results instead of only the first page of results
- `Get-PASAccount`
  - Removes `Offset` Parameter
- `Get-PASDiscoveredAccount`
  - Removes `Offset` Parameter

### Fixed
- `Get-PASSession`
  - Removes `UserName` from command output, avoiding error condition on expired session.
- `Get-PASPlatform`
  - Adds `search` parameter to the default `targets` parameterset
- ISPSS Error Handling
  - Fixes issue where error returned from ISPSS solution may not be handled properly

## **6.1.50**

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
