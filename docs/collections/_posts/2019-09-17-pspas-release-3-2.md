---
title:  "psPAS Release 3.2"
date:   2019-09-17 00:00:00
tags:
  - Release Notes
  - New-PASSession
  - Get-PASAccountPassword
  - Add-PASSafeMember
---

## 3.2.37 (Sept 17th 2019)

- Update Format for `psPAS.CyberArk.Vault.User`
  - Change default displayed properties when searching users with V10 API.

## 3.2.34 (Sept 11th 2019)

- Minor updates to Help Text.
  - Clarified version requirements for parameters & api capabilities.

## 3.2.32 (Sept 5th 2019)

- Fixes
  - `Add-PASSafeMember`
    - Update validation of MemberName parameter to not accept values containing `&` symbol.

## 3.2.30 (Sept 1st 2019)

- Update
  - Raise minimum required PowerShell version to 5.0.

## 3.2.27 (Sept 1st 2019)

- Updates
  - `New-PASSession`
    - Adds support for sending OTP in response to RADIUS Challenge
    - Adds support to skip certificate validation

- Fixes
  - `Get-PASAccountPassword`
    - Parameter name corrected to `TicketingSystem` from `TicketingSystemName`
