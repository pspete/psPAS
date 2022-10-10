---
title:  "psPAS Release 3.4"
date:   2020-01-27 00:00:00
tags:
  - Release Notes
  - Get-PASAccount
  - Test-PASPSMRecording
  - New-PASDirectoryMapping
  - Set-PASDirectoryMapping
---

## 3.4.100 (January 27th 2020)

### Module update to cover CyberArk 11.2 API features

- **Breaking Changes**
  - Parameters Changed: `New-PASDirectoryMapping` & `Set-PASDirectoryMapping`
    - Functions updated to use enum flag for mapping authorization options
    - `MappingAuthorizations`
      - Parameter now accepts string values representing the authorizations to configure for the mapping instead of an integer representation of them.
    - The following parameters are no longer accepted by the functions, the string values must now be provided to the `MappingAuthorizations` parameter instead:
      - `AddUpdateUsers`
      - `AddSafes`
      - `AddNetworkAreas`
      - `ManageServerFileCategories`
      - `AuditUsers`
      - `BackupAllSafes`
      - `RestoreAllSafes`
      - `ResetUsersPasswords`
      - `ActivateUsers`

- New Function
  - Added `Test-PASPSMRecording`
    - New in 11.2

- Fixes & Other Updates
  - Update `Get-PASAccount` to accept `searchType` parameter. Relevant to 11.2+.
  - Fixed incorrectly declared mandatory parameter in `Set-PASUser`
    - No longer required to set new password on user update.
  - Update `psPAS.CyberArk.Vault.User.Formats`
    - Include expiry & last logon date in friendly format.
    - New table format for displaying user information returned from API requests.
  - Performance related updates to internal module mechanics.
  - All functions help text updated to include link to function documentation on <https://pspas.pspete.dev>
  - Corrections & updates to documentation on <https://pspas.pspete.dev>
