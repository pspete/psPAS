---
title:  "psPAS Release 5.5"
date:   2023-03-06 00:00:00
tags:
  - Release Notes
  - New-PASSession
  - Get-PASPTAGlobalCatalog
  - Add-PASPTAGlobalCatalog
  - Set-PASPTARule
  - Get-PASComponentDetail
  - Add-PASSafe
  - Add-PASSafeMember
  - Get-PASAccount
  - Add-PASPublicSSHKey
  - Get-PASPublicSSHKey
  - Remove-PASPublicSSHKey
---

## **5.5.110 (March 7th 2023)**

### Module update to cover all CyberArk 13.0 API features

- New
  - Adds `Get-PASPTAGlobalCatalog` & `Add-PASPTAGlobalCatalog` commands, available for v13.
- Updates
  - `New-PASSession`
    - Adds Shared Services Auth Support
    - Allows null or empty `OTPDelimiter` to be specified
  - `Set-PASPTARule`
    - Updates validation for parameter `id`
  - `Get-PASComponentDetail`
    - Adds `pta` as option for parameter `component`
  - `Add-PASSafe`
    - Allows `0` as valid value for parameter `NumberOfDaysRetention`
  - `Add-PASSafeMember`
    - Adds optional `memberType` parameter, accepted from 12.6 onward.
- Other
  - Allow UPN UserName format
    - Updates the parameter validation logic of the `*-PASPublicSSHKey` functions to allow UPN style usernames to be specified and accepted.
  - Updates `psPAS.CyberArk.Vault.OnboardingRule` format in line with expected output according to product documentation.
  - Documentation update
    - Correct version requirement information for the `Get-PASAccount` `searchType` parameter.

