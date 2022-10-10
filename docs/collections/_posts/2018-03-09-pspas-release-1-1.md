---
title:  "psPAS Release 1.1"
date:   2018-02-12 00:00:00
tags:
  - Release Notes
  - Add-PASAccountGroupMember
  - New-PASAccountGroup
  - Get-PASOnboardingRule
  - New-PASOnboardingRule
  - Remove-PASOnboardingRule
---

## 1.1.8 (March 09 2018)

- Bug Fixes:
  - `Add-PASAccountGroupMember` now sends AccountID with request.
  - `New-PASAccountGroup` fixed an incorrect parameter name (_GroupPlatformID_).
  - `New-PASSAMLSession` - basic authentication token now sent in request header.
  - `Get-PASOnboardingRule`, `New-PASOnboardingRule` & `Remove-PASOnboardingRule`,
    parameters updated to allow specification of alternate PVWA application name
    (in-line with the rest of the module's functions).
