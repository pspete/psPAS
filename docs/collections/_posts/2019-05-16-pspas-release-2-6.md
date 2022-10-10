---
title:  "psPAS Release 2.6"
date:   2019-05-16 00:00:00
tags:
  - Release Notes
  - Add-PASDirectory
  - New-PASUser
  - Get-PASUser

---

## 2.6.17 (May 16th 2019)

- Fix
  - `Add-PASDirectory`
    - Parameter `SSLConnect` added (required if adding LDAPS hosts)
    - Thanks (again) [jmk-foofus](https://github.com/jmk-foofus)!

## 2.6.15 (May 2nd 2019)

### Module update to cover CyberArk 10.9 API features

- Updated Functions
  - `New-PASUser`
    - Added support for the updated Add User API method for v10.9
  - `Get-PASUser`
    - Added support for the updated Get Users API method for v10.9
