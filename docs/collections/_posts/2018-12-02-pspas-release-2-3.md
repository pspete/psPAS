---
title:  "psPAS Release 2.3"
date:   2018-12-02 00:00:00
tags:
  - Release Notes
  - Invoke-PASRestMethod
  - Get-PASGroup
  - Remove-PASGroupMember
  - Set-PASOnboardingRule
  - Add-PASDiscoveredAccount
  - Connect-PASPSMSession
  - Get-PASDirectory
  - Get-PASAccountGroup
  - Get-PASPSMConnectionParameter
---

## 2.3.6 (December 2nd 2018)

- Fixed
  - `Invoke-PASRestMethod`
    - Specify "UseBasicParsing" on each request to prevent issues when run on machines which do not have IE available and initialized.

## 2.3.0 (November 1st 2018)

### Module update to cover CyberArk 10.5 API features

- New Functions
  - `Get-PASGroup`
    - Enables querying of Vault Groups
  - `Remove-PASGroupMember`
    - Enables removal of vault group members
  - `Set-PASOnboardingRule`
    - Enables updates to existing Onboarding Rules
  - `Add-PASDiscoveredAccount`
    - Enables addition of discovered accounts or SSH keys as a pending account in the accounts feed
  - `Connect-PASPSMSession`
    - Retrieves parameters needed to monitor an in-progress PSM session

- Updated Functions
  - `Get-PASDirectory`
    - Now possible to query LDAP Directory by name
  - `Get-PASAccountGroup`
    - Updated to use API endpoint in 10.5
  - `Get-PASPSMConnectionParameter`
    - Updated to cater for Ad-Hoc Connections with unmanaged accounts

- Bug Fixes
  - Use of TLS 1.2 Protocol enforced when using PSCore
