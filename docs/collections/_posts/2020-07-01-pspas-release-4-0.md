---
title:  "psPAS Release 4.0"
date:   2020-07-01 00:00:00
tags:
  - Release Notes
  - New-PASSession
  - Add-PASSafeMember
  - Set-PASSafeMember
  - Get-PASPTAEvent
  - Set-PASPTAEvent
  - Get-PASSafeMember
---

## **4.0.0** (July 1st 2020)

### Module update to cover CyberArk 11.4 API features

- **Breaking Changes**
  - `Get-PASSafeMember`, `Add-PASSafeMember` & `Set-PASSafeMember`: Output Changed
    - "Permission" property of returned object now contains a nested property=value pair for each permission instead of an array containing only the name of the assigned permissions.
    - Existing scripts which rely on the legacy array value of the `Permissions` property when working with the `*-PASSafeMember` functions must either be updated to work with the new output or use an earlier compatible psPAS version.

- New Function
  - Added `Set-PASPTAEvent`
    - Appeared in 11.3
    - Set status of PTA events

- Updated Functions
  - `New-PASSession`
    - Adds support for updated saml auth updated in 11.4
  - `Get-PASPTAEvent`
    - Adds newly documented parameters for 11.4 and updates request format for filtering events

- Fixes
  - `Set-PASUser`
    - Corrects issue where an incorrectly formed json body was being sent with the request if using the parameters introduced in psPAS 3.3.88.
  - `Add-PASSafeMember` & `Set-PASSafeMember`
    - Update ensures json body of request is always sent with the permission properties statically ordered.
