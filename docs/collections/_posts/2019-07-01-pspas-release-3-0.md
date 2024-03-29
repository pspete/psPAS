---
title:  "psPAS Release 3.0"
date:   2019-07-01 00:00:00
tags:
  - Release Notes
  - New-PASSession
  - New-PASUser
  - Export-PASPSMRecording
  - Export-PASPlatform
  - Get-PASPSMConnectionParameter
  - Use-PASSession
  - Get-PASSession
  - Invoke-PASCPMOperation
  - Find-PASSafe
  - Close-PASSession
---

## **3.0.0** (July 1st 2019)

_2 years since first commit Anniversary Edition_

- Breaking Changes
  - Module Wide Parameter Changes
    - `BaseURI`, `WebSession`, `PVWAAppName`, `SessionToken`, `ExternalVersion`
      - no longer required parameters.
      - `New-PASSession` still requires `BaseURI`, and will accept `PVWAAppName`
    - `UseV9API` & `UseV10API` Parameters renamed to `UseClassicAPI`
      - Where functions support operations against both Classic & V10 API, default behaviour is to use the V10 API.
      - Specify the `UseClassicAPI` switch parameter to force usage of the Classic API Endpoint.
    - Values for `BaseURI`, `WebSession`, `PVWAAppName`, `SessionToken` & `ExternalVersion` are not returned from module functions in output.
  - Functions Removed
    - `New-PASSAMLSession`
      - Functionality moved into `New-PASSession`.
    - `New-PASSharedSession`
      - Functionality moved into `New-PASSession`.
    - `Close-PASSAMLSession`
      - Functionality moved into `Close-PASSession`.
    - `Close-PASSharedSession`
      - Functionality moved into `Close-PASSession`.
    - `Start-PASCredChange`
      - Functionality moved into `Invoke-PASCPMOperation`.
    - `Start-PASCredVerify`
      - Functionality moved into `Invoke-PASCPMOperation`.
    - `Invoke-PASCredChange`
      - Functionality moved into `Invoke-PASCPMOperation`.
    - `Invoke-PASCredVerify`
      - Functionality moved into `Invoke-PASCPMOperation`.
    - `Invoke-PASCredReconcile`
      - Functionality moved into `Invoke-PASCPMOperation`.
  - Aliases Removed
    - `Get-PASApplications` - Removed old pluralised alias
    - `Get-PASApplicationAuthenticationMethods` - Removed old pluralised alias
    - `Get-PASAccountCredentials` - Removed old pluralised alias
    - `Get-PASSafeMembers` - Removed old pluralised alias
- New Functions
  - `Find-PASSafe` (Thanks (again) [steveredden](https://github.com/steveredden)!)
    - List or search safes by name
  - `Invoke-PASCPMOperation`
    - Invoke CPM Verify, Change & Reconcile via v10 or Classic API.
  - `Get-PASSession`
    - Return module scope variable values which are used to perform each request to the API.
  - `Use-PASSession`
    - Set module scope variable values which are used to perform each request to the API.
- Updated Functions
  - `New-PASSession`
    - Added `CertificateThumbprint` Parameter
      - Allows requests to be sent with details required for Client Certificate authentication.
    - Added `OTP` Parameter
      - Allows One Time Passcode to be provided, which is then sent with the password value.
        - Tested with Duo RADIUS.
    - Added SAML authentication option.
    - Added Shared authentication option
    - Removed `$SecureMode` & `$AdditionalInfo` parameters.
  - `Get-PASPSMConnectionParameter`
    - Now saves an RDP file returned from an API request.
    - `path` parameter now expects a folder to save the file to.
    - Output file is named automatically
  - `Export-PASPlatform`
    - `path` parameter now expects a folder to save the file to.
    - Output file is named automatically
  - `Export-PASPSMRecording`
    - `path` parameter now expects a folder to save the file to.
    - Output file is named automatically
- Fixes
  - `New-PASUser`
    - Added `ChangePassOnNextLogon` parameter for working with latest API method
    - Fixes issue where `New-PASUser` was failing to set the change password at next logon flag for a new user.
- Other
  - Improvements to exception handling and error reporting.
