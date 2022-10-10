---
title:  "psPAS Release 4.4"
date:   2020-08-24 00:00:00
tags:
  - Release Notes
  - Set-PASUser
  - New-PASUser
  - Add-PASAccount
  - Get-PASAccount
  - Get-PASDiscoveredAccount
  - New-PASAccountObject
  - Get-PASAccountImportJob
  - Start-PASAccountImportJob
---

## **4.4.71** (August 24th 2020)

### Module update to cover all CyberArk 11.6 API features

- New Functions
  - `Start-PASAccountImportJob`
    - Add multiple accounts to existing safes
  - `Get-PASAccountImportJob`
    - Get status of bulk account import jobs
  - `New-PASAccountObject`
    - Formats an object to include in the list of accounts to be added using `Start-PASAccountImportJob`.
  - `Get-PASDiscoveredAccount`
    - Search for and list discovered accounts.
- Updated Functions
  - `Get-PASAccount`
    - Updated to remove repeated code
  - `Add-PASAccount`
    - Updated to use `New-PASAccountObject` to create required request object.
  - `New-PASUser`
    - Updated to remove repeated code
  - `Set-PASUser`
    - Updated to remove repeated code
