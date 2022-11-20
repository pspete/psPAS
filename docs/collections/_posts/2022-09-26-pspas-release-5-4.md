---
title:  "psPAS Release 5.4"
date:   2022-11-20 00:00:00
tags:
  - Release Notes
  - New-PASSession
  - Get-PASGroup
  - Publish-PASDiscoveredAccount
  - Get-PASLinkedAccount
  - Add-PASPersonalAdminAccount
  - Get-PASAccount
  - Get-PASSafe
  - Get-PASSafeMember
---

## **5.4.94 (September 26th 2022)**

- Breaking Changes
  - `Get-PASAccount`
    - Removes `Gen2Filter` ParameterSet.
    - Equivalent functionality remains available via other available parameters.
  - `Get-PASGroup`
    - Removes `filter` ParameterSet.
    - Equivalent functionality remains available via other available parameters.
- New Commands
  - `Publish-PASDiscoveredAccount`
    - Feature Request: Onboards a discovered account.
    - Based on swagger documentation
  - `Get-PASLinkedAccount`
    - Gets details of linked accounts
  - `Add-PASPersonalAdminAccount`
    - Specific for Adding Personal Admin Accounts in Privilege Cloud.
    - Based on swagger documentation
- Other Updates
  - `New-PASSession`
    - Feature Request: Adds support for PKI Authentication.
  - `Get-PASAccount`
    - Adds `limit` & `offset` parameters.
  - `Get-PASSafe`
    - Corrects ambiguous invocation options (Gen1).
  - Documentation
    - General updates throughout.

## **5.4.101 (November 20th 2022)**

- Fix `Get-PASSafeMember`
  - Corrects format of URL value when returning many safe members
    - Thanks [InconstantRO](https://github.com/InconstantRO)!
- Documentation
  - Additional example added to `Get-PASAccount` help file
    - Thanks [rorobig](https://github.com/rorobig)!
