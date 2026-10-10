---
title: "psPAS Release 8.2"
date: 2026-10-10 00:00:00
version: 8.2.0
tags:
  - Release Notes
  - Set-PASPTARule
  - Get-PASPTARule
  - Get-PASAccountSSHKey
  - New-PASPSMSession
---

## [8.2.0]

### Added

- Faster module import
  - psPAS is now published as a single built `psPAS.psm1`, instead of loading each of its ~300 function files at import.
  - Format and type files are merged into one `psPAS.Format.ps1xml` and one `psPAS.Types.ps1xml`.
  - Import time drops from ~530 ms to ~190 ms on PowerShell 7, and from ~550 ms to ~140 ms on Windows PowerShell 5.1.

### Updated

- Build, test and release move from AppVeyor to GitHub Actions, using [pspete.Build](https://github.com/pspete/pspete.Build).
  - Tests run against the built module on Windows PowerShell 5.1, PowerShell 7 on Windows, and PowerShell 7 on Linux.
- Removed PSScriptAnalyzer suppressions that no longer match any finding.

### Fixed

- `Set-PASPTARule`
  - Fixed an error on Windows PowerShell 5.1 when `Get-PASPTARule` returns a single rule.
- Saving files on Linux and macOS
  - `Get-PASAccountSSHKey` and `New-PASPSMSession` now save to the system temp folder when no `-Path` is given. Previously they failed, because `$env:TEMP` is not set on those systems.
