---
title: "psPAS Release 8.1"
date: 2026-09-29 00:00:00
tags:
  - Release Notes
  - New-PASSession
---

## [8.1.44]

### Added

- OAuth Support
  - `New-PASSession` now supports OAuth authentication for self-hosted implementations
  - Thanks [JP-Consulting](https://github.com/johannesconsulting)!!!!

### Updated

- `New-PASSession`
  - Logic split into private helper functions (`Resolve-PASLogonTarget`, `Get-PASRadiusCredential`,
    `Get-PASLogonRequest`, `Invoke-PASIdentityLogon`, `Get-PASOAuthWebSession`,
    `Initialize-PASSession`), each with its own tests. No change to parameters or logon behaviour.

### Fixed

- `New-PASSession`
  - A piped `Credential` is now sent when using `-type Windows`. The logon request was previously
    built in the `begin` block, before pipeline input is bound, so no credential was sent.
  - Values for `BaseURI` & `PVWAAppName` piped by property name are now used for the logon request.
  - With `-OTPMode Challenge -RadiusChallenge Password`, the password sent as the RADIUS challenge response
    is no longer recorded as plain text by PowerShell module logging.
