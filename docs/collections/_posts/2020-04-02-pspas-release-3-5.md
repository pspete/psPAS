---
title:  "psPAS Release 3.5"
date:   2020-04-02 00:00:00
tags:
  - Release Notes
  - New-PASSession
  - Add-PASApplicationAuthenticationMethod
  - Get-PASSafeMember
  - Get-PASDirectoryMapping
  - Add-PASAccount
---

## 3.5.8 (April 2nd 2020)

- Changes minimum required PowerShell version to 5.1
- Updates + Fixes
  - Marginal performance improvement by suppressing progress bar for `Invoke-WebRequest`.
  - `Add-PASAccount`
    - Fixed bug where mandatory username parameter is not sent in the request body when using the classic API.
  - `Get-PASDirectoryMapping`
    - include MappingID in default table output
  - `Get-PASSafeMember`
    - Updated help text to clarify `MemberName` parameter and expected failure conditions due to request method (`PUT` instead of `GET`)

## 3.5.0 (March 15th 2020)

### Module update to cover CyberArk 11.3

- **Breaking Changes**
  - `Add-PASApplicationAuthenticationMethod` - Parameters Changed
    - Removed `AuthName` & `AuthValue` parameters
    - Added named parameters for each authentication type, which accept the `AuthValue` string.
- Updates + Fixes
  - `New-PASSession`
    - Added Parameter `concurrentSession` - supported from 11.3
    - Added support for Windows + RADIUS authentication
    - PSCredential object can now be used for Windows/IIS Authentication.
    - Added logic to prompt for OTP by supplying a value of `passcode` to the `OTP` parameter
  - `Add-PASApplicationAuthenticationMethod`
    - Added support for configuring Certificate Attribute authentication method
