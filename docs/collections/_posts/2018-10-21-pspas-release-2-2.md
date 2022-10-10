---
title:  "psPAS Release 2.2"
date:   2018-10-21 00:00:00
tags:
  - Release Notes
  - New-PASSession
  - Get-PASAccountPassword
  - Get-PASAccount
  - Export-PASPlatform
---

## 2.2.22 (October 21st 2018)

- Update
  - `New-PASSession`
    - Option added to use Windows integrated authentication with default credentials
      - Thanks [steveredden](https://github.com/steveredden)!

## 2.2.10 (September 23rd 2018)

- Bug Fix
  - `Get-PASAccountPassword`
    - Fix applied to allow accountID from version 10 to be accepted from pipeline object.
  - `Get-PASAccount`
    - Validation added to `limit` parameter.

## 2.2.2 (September 12th 2018)

- Bug Fix
  - `Get-PASAccountPassword`
    - Backward compatibility for retrieving password values from  CyberArk version 9 restored.

## 2.2.0 (July 27th 2018)

- Bug Fix
  - `Export-PASPlatform`
    - Exported files were invalid, now fixed.
    - Thanks [jmk-foofus](https://github.com/jmk-foofus)!
