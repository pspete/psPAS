---
title:  "psPAS Release 2.4"
date:   2019-02-16 00:00:00
tags:
  - Release Notes
  - New-PASSession
  - Close-PASSession
  - Get-PASPSMSessionActivity
  - Get-PASPSMSessionProperty
  - Get-PASPSMRecordingActivity
  - Get-PASPSMRecordingProperty
  - Export-PASPSMRecording
  - Request-PASAdHocAccess
  - Get-PASPSMRecording
  - Get-PASAccount
  - Get-PASPSMConnectionParameter
---

## 2.4.8 (February 16th 2019)

- Updated Functions / Bug Fix / Breaking Change
  - `Close-PASSession`
    - Now sends request to V10 URL by default.
    - New parameter added to send request to V9 API if required.
  - `psPAS.psm1`
    - Updated to improve module load time.
    - Original import method can be forced by specifying `Import-Module -Name psPAS -ArgumentList $true`

- Fixed
  - `New-PASSession`
    - Fixed unexpected element in request body when specifying UseDefaultCredentials with Windows Authentication.

## 2.4.3 (February 15th 2019)

- Bug Fix
  - Remove debug output which could contain plaintext passwords.
    - Thanks [karrth](https://github.com/karrth)!

## 2.4.0 (February 1st 2019)

### Module update to cover CyberArk 10.6 API features

- New Functions
  - `Get-PASPSMSessionActivity`
    - Returns activity details from an active PSM Session.
  - `Get-PASPSMSessionProperty`
    - Returns property details from an active PSM Session.
  - `Get-PASPSMRecordingActivity`
    - Returns activity details from a PSM Recording.
  - `Get-PASPSMRecordingProperty`
    - Returns property details from a PSM Recording.
  - `Export-PASPSMRecording`
    - Allows saving of PSM Session Recording to a file.
  - `Request-PASAdHocAccess`
    - Enables request of temporary administrative access to a server.
- Updated Functions
  - `Get-PASPSMRecording`
    - Now able to query PSM recordings by ID.
  - `Get-PASAccount`
    - Updated to include return of `InternalProperties` property when using the V9 API.
  - `Get-PASPSMConnectionParameter`
    - Added support for RDP File output
