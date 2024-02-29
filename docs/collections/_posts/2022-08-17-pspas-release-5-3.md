---
title:  "psPAS Release 5.3"
date:   2022-08-17 00:00:00
tags:
  - Release Notes
  - Set-PASUser
  - New-PASUser
  - Add-PASAccount
  - Set-PASAccount
  - Enable-PASUser
  - Disable-PASUser
  - Get-PASAccount
  - Get-PASGroup
  - Get-PASAccountGroup
---

## **5.3.76 (August 17th 2022)**

- Updates
  - `Set-PASUser` / `New-PASUser`
    - Adds `GUI` as available parameter value for `unAuthorizedInterfaces` parameter.
- Gen1 API Specific
  - `Add-PASAccount` / `Set-PASAccount`
    - Fixes enumeration of dynamic properties for Gen1 requests.
  - Reverts Gen1 specific URL update introduced in last release for "_user_" type commands.
    - Removes forward slash (/) to end of request URL

## **5.3.69 (July 26th 2022)**

### Module update to cover all CyberArk 12.6 API features

- New Commands
  - `Enable-PASUser`
    - New command, supported from 12.6
  - `Disable-PASUser`
    - New command, supported from 12.6
- Updates
  - `Get-PASAccount`
    - Added `savedFilter` parameter, supported from 12.6
  - `Get-PASGroup`
    - Added `id` parameter, supported from 12.6
    - Added `groupName` parameter, supported from 12.2.
  - `Get-PASAccountGroup`
    - Deprecated use of "Get Safe account groups" API
    - Makes ParameterSet based on `Get account group by Safe` API the default.
  - Updates URL formatting to include a forward slash (/) to end of URL for functions which may include a dot (.) via provided parameter values.
  - Updated documentation and help text.
