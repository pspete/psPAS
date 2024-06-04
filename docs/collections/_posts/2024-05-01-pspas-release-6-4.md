---
title: "psPAS Release 6.4"
date: 2024-06-04 00:00:00
tags:
  - Release Notes
  - Get-PASPSMRecording
  - Get-PASIPAllowList
  - Set-PASIPAllowList
  - Get-PASBYOKConfig
  - Publish-PASDiscoveredLocalAccount
  - Get-PASDiscoveredLocalAccountActivity
  - Get-PASDiscoveredLocalAccount
  - Clear-PASDiscoveredLocalAccount
  - Add-PASDiscoveredLocalAccount
  - Remove-PASDiscoveredLocalAccount
  - Invoke-PASRestMethod
  - Get-PASPSMSession
  - Set-PASUser
---

## **6.4.85**

### Added
- N/A

### Updated
- N/A

### Fixed
- `Set-PASUser`
  - Adds logic to not attempt conversion to unix time if expiry date is not a valid datetime object, this resolves an issue where an error was raised when updating an account with an existing value for the `expirydate` property
  - Adds logic to not apply time zone offset when specifying Unix epoch time to remove an expiry date from an account which could previously result in an invalid time value in non-GMT time zones.

## **6.4.80**

Includes a general update across multiple module commands to ensure commands which are specific to self-hosted implementations are not able to be run against Privilege Cloud, and any commands which are specific to Privilege Cloud are not able to be run against a Self-Hosted solution.

### Added
- `Get-PASIPAllowList`
  - Privilege Cloud only command to show IP Allow List
- `Set-PASIPAllowList`
  - Privilege Cloud only command to set IP Allow List
- `Get-PASBYOKConfig`
  - Privilege Cloud only command to show BYOK Config
- `Publish-PASDiscoveredLocalAccount`
  - Privilege Cloud only command to publish discovered local account
- `Get-PASDiscoveredLocalAccountActivity`
  - Privilege Cloud only command to show discovered local account activity
- `Get-PASDiscoveredLocalAccount`
  - Privilege Cloud only command to show local discovered account details
- `Clear-PASDiscoveredLocalAccount`
  - Privilege Cloud only command to delete all discovered local accounts from the Pending Accounts list.
- `Add-PASDiscoveredLocalAccount`
  - Privilege Cloud only command to add a specific local account to the Discovered Accounts list
- `Remove-PASDiscoveredLocalAccount`
  - Privilege Cloud only command to remove a local account from the Discovered Accounts list

### Updated
- `Invoke-PASRestMethod`
  - Improvements to error handling

### Fixed
- `Get-PASPSMRecording`
  - Fixes result paging issue
- `Get-PASPSMSession`
  - Fixes result paging issue
