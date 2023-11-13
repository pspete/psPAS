---
title:  "psPAS Release 5.6"
date:   2023-07-31 00:00:00
tags:
  - Release Notes
  - Get-PASUserTypeInfo
  - Get-PASPTARiskEvent
  - Set-PASPTARiskEvent
  - Get-PASPTARiskSummary
  - New-PASRequestObject
  - Unlock-PASAccount
  - Get-PASUser
  - New-PASUser
  - Set-PASUser
  - New-PASRequest
  - Get-PASRequest
  - New-PASSession
---

## **5.6.135 (July 31st 2023)**

### Module update to cover all CyberArk 13.2 API features

- New
  - `Get-PASUserTypeInfo`
    - Output information on User Types
  - `Get-PASPTARiskEvent`
    - Output PTA Risk Events
  - `Set-PASPTARiskEvent`
    - Update PTA Risk Events
  - `Get-PASPTARiskSummary`
    - Output PTA Risk Summary
  - `New-PASRequestObject`
    - Enables creation of request objects for bulk account access requests using `New-PASRequest`.
- Updates
  - `New-PASSession`
    - Adds option for PKIPN authentication.
      - Thanks ([JesseMcWilliamss](https://github.com/JesseMcWilliamss))!
    - Adds options to Shared Services Authentication capability
      - Supports different subdomains for Identity & Privilege Cloud tenants
      - Supports ability to provide tenant URLs for Identity & Privilege Cloud systems.
  - `Unlock-PASAccount`
    - Adds Unlock capability, in addition to the existing check-in capability.
      - Thanks & Credit to ([Qrelis](https://github.com/Qrelis)) for this!
  - `Get-PASUser`
    - Adds `source` parameter (allows filter by cyberark or ldap source).
    - Adds `userStatus` parameter (allows filter by active, disabled, or suspended status).
  - `New-PASUser` & `Set-PASUser`
    - Adds parameters `userActivityLogRetentionDays`, `loginFromHour` & `loginToHour`
  - `New-PASRequest`
    - Adds new ParameterSets `BulkSearch`, `BulkFilter` & `BulkItems`.
  - `Get-PASRequest`
    - Adds `id` parameter to support get status bulk request actions.
- Other

