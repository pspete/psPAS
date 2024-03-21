---
title:  "psPAS Release 4.1"
date:   2020-07-14 00:00:00
tags:
  - Release Notes
  - New-PASSession
  - Get-PASUser
  - Get-PASPlatform
  - Remove-PASGroup
  - Remove-PASPlatform
  - Enable-PASPlatform
  - Disable-PASPlatform
  - Copy-PASPlatform
---

## **4.1.11** (July 14th 2020)

### Module update to cover CyberArk 11.5 API features

- **Behaviour Changes**
  - `Get-PASPlatform`
    - When invoked with no parameters to return details of all configured platforms, defaults to operation against the endpoint for the 11.4 API.
    - When invoked with a value provided for the `Active` parameter, will perform operation against the endpoint for the 11.4 API.
    - To utilise the 11.1 api endpoint, a value should be provided for the `PlatformType` and/or `Search` parameters,  or, `Active` and `PlatformType` and/or `Search` parameters.
  - `New-PASSession`
    - Value for OTP will be prompted for if no value is provided for this parameter.
      - The prompt will now relay the text of the response from the RADIUS server.

- New Functions
  - `Copy-PASPlatform`
    - Duplicates target, dependent, group or rotational group platform to a new platform.
    - 11.4 functionality, missed in the `4.0.0` release.
  - `Disable-PASPlatform`
    - Disables, target, group or rotational group platform.
    - 11.4 functionality, missed in the `4.0.0` release.
  - `Enable-PASPlatform`
    - Enables, target, group or rotational group platform.
    - 11.4 functionality, missed in the `4.0.0` release.
  - `Remove-PASPlatform`
    - Deletes, target, dependent, group or rotational group platform.
    - 11.4 functionality, missed in the `4.0.0` release.
  - `Remove-PASGroup`
    - Deletes a specified vault user group
    - 11.5 functionality.

- Updated Functions
  - `Get-PASPlatform`
    - Update to enable query of dependent, group, rotational group platforms
    - Update to include additional filters available for querying target platoforms
    - 11.4 functionality, missed in the `4.0.0` release.
    - Function now defaults to 11.4 target platform endpoint if no parameters are specified.
  - `Get-PASUser`
    - 11.5 output includes group membership details.
    - group membership property may be included in output when function is executed from earlier versions, but its content will be blank.
  - `New-PASSession`
    - OTP can now be omitted entirely from used parameters in scenarios where the value is unknown.
    - Response from RADIUS now used as message for Read-Host prompt for OTP.
    - Deprecated need for use of OTPMode parameter when a prompt for the OTP is required.

- Other Fixes & Updates
  - Documentation updated.
  - Duplicated code for creating the query portion of a URL replaced with new helper function internal to the module.
