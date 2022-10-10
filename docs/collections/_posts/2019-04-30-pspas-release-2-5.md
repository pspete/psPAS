---
title:  "psPAS Release 2.5"
date:   2019-04-30 00:00:00
tags:
  - Release Notes
  - Get-PASSafeMember
  - Unlock-PASAccount
  - Get-PASAccountActivity
  - Add-PASApplication
  - Get-PASAccount
  - Get-PASSafe
  - Get-PASDirectoryMapping
  - Remove-PASDirectory
  - Add-PASDirectory
  - Get-PASDirectory
  - New-PASDirectoryMapping
  - Set-PASSafe
---

## 2.5.11 (April 30th 2019)

- Updates
  - `Get-PASSafeMember`
    - Added `MemberName` parameter
      - Returns all safe permissions of a specific user.
  - `Get-PASAccountActivity`
    - Added Alias `id` to `AccountID` parameter
  - `Invoke-PASCredChange`
    - Added Alias `id` to `AccountID` parameter
  - `Invoke-PASCredReconcile`
    - Added Alias `id` to `AccountID` parameter
  - `Invoke-PASCredVerify`
    - Added Alias `id` to `AccountID` parameter
  - `Start-PASCredChange`
    - Added Alias `id` to `AccountID` parameter
  - `Start-PASCredVerify`
    - Added Alias `id` to `AccountID` parameter
  - `Unlock-PASAccount`
    - Added Alias `id` to `AccountID` parameter

## 2.5.6 (April 11th 2019)

- Fix
  - `Add-PASApplication`
    - Parameter `BusinessOwnerPhone` changed to `[string]` type

## 2.5.2 (April 6th 2019)

- Updated Functions (Thanks [steveredden](https://github.com/steveredden)!)
  - `Get-PASAccount`
    - Support for nextLink implemented to return maximum number of query results.
    - TimeoutSec parameter added
  - `Get-PASSafe`
    - TimeoutSec parameter added

## 2.5.0 (March 28th 2019)

### Module update to cover CyberArk 10.7 API features

- New Functions
  - `Get-PASDirectoryMapping`
    - Get directory mappings configured for a directory
  - `Get-PASDirectoryMapping`
    - Adds a new Directory Mapping for an existing directory
  - `Remove-PASDirectory`
    - Removes a directory configured in the Vault
- Updated Functions
  - `Add-PASDirectory`
    - Added parameter `DCList`
  - `Get-PASDirectory`
    - Function output updated to contain more properties
  - `New-PASDirectoryMapping`
    - Added parameters `VaultGroups`, `Location`, `LDAPQuery`
  - `Set-PASSafe`
    - Now supports renaming a safe via `NewSafeName` parameter
- Other Updates
  - Updated comment based help content based on user feedback.
