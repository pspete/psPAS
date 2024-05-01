---
title: "psPAS Release 6.4"
date: 2024-05-01 00:00:00
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
---

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
