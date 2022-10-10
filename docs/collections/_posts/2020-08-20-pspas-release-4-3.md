---
title:  "psPAS Release 4.3"
date:   2020-08-20 00:00:00
tags:
  - Release Notes
  - Add-PASDiscoveredAccount
  - Get-PASAccount
  - New-PASRequest
  - Get-PASGroup
  - New-PASPSMSession
  - Set-PASPlatformPSMConfig
  - Get-PASPlatformPSMConfig
  - Get-PASPSMServer
  - Get-PASConnectionComponent
  - Set-PASAuthenticationMethod
  - Add-PASAuthenticationMethod
  - Get-PASAuthenticationMethod
  - Get-PASAccountSSHKey
  - Add-PASAllowedReferrer
  - Get-PASAllowedReferrer
  - Get-PASPTAEvent
  - Get-PASUser
  - Get-PASApplicationAuthenticationMethod
---

## **4.3.65** (August 20th 2020)

- Fixes
  - `Get-PASAccount`
    - Fixes issue where no output would be shown if `filter` parameter was used.
  - `Get-PASApplicationAuthenticationMethod`
    - Adds properties `Subject`, `Issuer` & `SubjectAlternativeName` to output view.

## **4.3.62** (August 14th 2020)

- Updated Functions
  - `New-PASRequest`
    - Added Parameters:
      - `AllowMappingLocalDrives`
      - `AllowConnectToConsole`
      - `RedirectSmartCards`
      - `PSMRemoteMachine`
      - `LogonDomain`
      - `AllowSelectHTML5`
    - These are the documented properties expected to be sent as connectionParams.
    - Removes the need for a module user to specify these as a hashtable.
  - `Get-PASAccount`
    - `categoryModificationTime` added to list output
  - `Get-PASUser`
    - Fixed issue where an object with no property values would be returned if no user was found.
  - `Get-PASPTAEvent`
    - Adds parameter `fromUpdateDate`.
    - Removes parameter `UseLegacyMethod`.
    - Lowers required version from 11.4 to 11.3 when using certain parameter combinations.
- Other Fixes & Updates
  - Fixed issue where json displayed in debug output may not have been valid.
  - Updates to codebase and refactored functions to remove repeated code.

### Module update to cover all CyberArk 11.5 API features

- **Behaviour Changes**
  - Renamed `Get-PASPSMConnectionParameter` to `New-PASPSMSession`
- New Functions
  - `Get-PASAllowedReferrer`
    - Lists configured allowed referrers.
    - Requires PAS 11.5
  - `Add-PASAllowedReferrer`
    - Adds a new allowed referrer
    - Requires PAS 11.5
  - `Get-PASAccountSSHKey`
    - Retrieves Private SSH Key of Account
    - Requires PAS 11.5
  - `Get-PASAuthenticationMethod`
    - Lists Authentication method details
    - Requires PAS 11.5
  - `Add-PASAuthenticationMethod`
    - Adds new authentication method
    - Requires PAS 11.5
  - `Set-PASAuthenticationMethod`
    - Updates authentication method
    - Requires PAS 11.5
  - `Get-PASConnectionComponent`
    - Lists all connection components
    - Requires PAS 11.5
  - `Get-PASPSMServer`
    - Lists all configured PSM Servers
    - Requires PAS 11.5
  - `Get-PASPlatformPSMConfig`
    - Returns PSM configuration of Platform
    - Requires PAS 11.5
  - `Set-PASPlatformPSMConfig`
    - Updates PSM configuration of platform
    - Requires PAS 11.5
- Updated Functions
  - `New-PASPSMSession`
    - Removed Parameter: `connectionParams`
    - Added Parameters:
      - `AllowMappingLocalDrives`
      - `AllowConnectToConsole`
      - `RedirectSmartCards`
      - `PSMRemoteMachine`
      - `LogonDomain`
      - `AllowSelectHTML5`
    - These are the documented properties expected to be sent as connectionParams.
    - This update removes the need for a module user to specify these as a hashtable.
  - `Get-PASAccount`
    - Added parameters `safeName` & `modificationTime`.
      - Can be used instead of specifying a correctly formated value for `filter`.
      - `modificationTime` is documented as a valid filter option since 11.4
  - `Get-PASGroup`
    - Adds parameter `groupType`
      - Can be used instead of specifying a correctly formated value for `filter`.
- Other Fixes & Updates
  - `New-PASRequest`
    - Fixed potential issue with date values converted into UNIXTimeStamp.
  - `Get-PASAccount`
    - Fixed potential issue with date values converted into UNIXTimeStamp.
  - `Add-PASDiscoveredAccount`
    - Fixed potential issue with date values converted into UNIXTimeStamp.
