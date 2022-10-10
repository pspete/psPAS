---
title:  "psPAS Release 3.1"
date:   2019-07-19 00:00:00
tags:
  - Release Notes
  - New-PASSession
  - Unblock-PASUser
  - Get-PASUser
  - Set-PASDirectoryMapping
  - New-PASDirectoryMapping
  - Set-PASDirectoryMappingOrder
  - Set-PASUserPassword
  - Get-PASSafeMember
  - Add-PASSafeMember
  - Set-PASAccount
---

## 3.1.13 (July 19th 2019)

- Fixes
  - `New-PASSession`
    - Fixes issue where authentication token was not available to other module functions after authenticating via the v10 API endpoint from CyberArk v9.X.

## 3.1.10 (July 16th 2019)

- Fixes
  - `Set-PASAccount`
    - Fixes non-terminating error when not piping an object into the function and using the Classic API.

## 3.1.7 (July 13th 2019)

- Updates
  - `Add-PASSafeMember`
    - Added parameter aliases for permission name equivalent names returned from Get-PASSafeMember.
  - `Get-PASSafeMember`
    - Updated help text to detail permission name equivalents returned from the API.

## 3.1.0 (July 7th 2019)

### Module update to cover CyberArk 10.10 API features

- New Functions
  - `Set-PASUserPassword`
    - Reset user passwords
  - `Set-PASDirectoryMappingOrder`
    - Reorder directory mappings
- Updated Functions
  - `New-PASDirectoryMapping`
    - Added parameter `UserActivityLogPeriod` for 10.10 API
  - `Set-PASDirectoryMapping`
    - Added parameter `UserActivityLogPeriod` for 10.10 API
  - `Get-PASUser`
    - Added parameter `id` for 10.10 API
  - `Unblock-PASUser`
    - Added parameter `id` for 10.10 API endpoint
