---
title:  "psPAS Release 5.1"
date:   2021-07-13 00:00:00
tags:
 - Release Notes
 - New-PASSession
 - Add-PASSafeMember
 - Get-PASPlatform
 - Remove-PASGroupMember
 - Get-PASSession
 - Get-PASAccountPassword
 - Set-PASUser
 - Get-PASGroup
---

## **5.1.44 (July 13th 2021)**

- Updates
  - `Get-PASGroup`
    - Added `includeMembers` parameter based on [this article](https://cyberark-customers.force.com/s/article/PVWA-REST-Get-groups-API-does-not-return-members).

## **5.1.37 (June 28th 2021)**

- Updates
  - Resolves issue where the `ConvertTo-UnixTime` helper function provided invalid values when the culture was not 'en-US'.
    - (Thanks [liamwh](https://github.com/liamwh)!).
  - `Set-PASUser`
    - Sets `ValueFromPipelinebyPropertyName = $false` for `ExpiryDate` parameter, avoids parameter validation exception when piping object representing user, such as the output from `Get-PASUSer`, into `Set-PASUser`.
  - `Get-PASAccountPassword`
    - MachineName parameter changed to `string` type (previously was incorrectly specified as `switch`)
    - Added `UserName` parameter & `ToPsCredential()` Method to enable return of Credential Object.
      - (Thanks [zamothh](https://github.com/zamothh)!)

## **5.1.21 (June 7th 2021)**

- Updates
  - `Get-PASSession`
    - Catch errors getting the username of the logged on user so session token and other information can still be extracted from the module scope.
  - `Add-PASSafeMember`
    - Makes `InitiateCPMAccountManagementOperations` non-mandatory; fixes issue introduced in `5.1.16`.
  - `Remove-PASGroupMember`
    - Resolves issue where attempting to remove group member with an '@' symbol in the user name reported a 404 error.
  - `Get-PASPlatform`
    - Fixes issue where expected output was not displayed when using the `platforms` parameterset.

## **5.1.16** (May 23rd 2021)

- Updates
  - `New-PASSession`
    - Introduce support for providing response to RADIUS challenges featuring sub-options.
    - Fixes Gen2 SAML Authentication:
      - Code to get SAML Response via SSO using default credentials updated to correctly format authentication request.
      - `SAMLResponse` Parameter added for user to provide their own SAMLResponse as string value.
  - `Add-PASSafeMember`
    - Fixes issue where some permissions may not be applied when piping object into function and using the Gen2 API.
