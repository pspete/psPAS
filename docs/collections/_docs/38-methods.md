---
title: "Methods"
permalink: /docs/methods/
excerpt: "psPAS Methods"
last_modified_at: 2026-08-03T01:33:52-00:00
---

## Using Methods

Methods present on objects returned from psPAS functions can be leveraged to get the data you need with ease.

### Safe (`psPAS.CyberArk.Vault.Safe`)

Objects returned by `Get-PASSafe`.

- `SafeMembers()` runs a query for the members of the safe:

```powershell
#List all safes where AppUser is not a member
Get-PASSafe | Where-Object{ ($_.safemembers() | Select-Object -ExpandProperty UserName) -notcontains "AppUser"}
```

- `Remove([bool]$force)` removes the safe, optionally bypassing the confirmation prompt:

```powershell
#Remove a safe, without confirmation
(Get-PASSafe -SafeName "Unused_Safe").Remove($true)
```

### Safe Member (`psPAS.CyberArk.Vault.Safe.Member` / `.Gen2`)

Objects returned by `Get-PASSafeMember`.

- `UserSource()`, `UserType()`, `IsAgentUser()`, `IsExpired()`, `IsDisabled()` and `IsSuspended()` look up the underlying user via `Get-PASUser` and return the relevant property:

```powershell
#Find safe members whose user account is disabled
Get-PASSafe | Get-PASSafeMember | Where-Object{ $_.IsDisabled() }
```

- `GetPermissions()` (Gen2 only) flattens the `Permissions` property into a hashtable:

```powershell
(Get-PASSafe -SafeName "Finance" | Get-PASSafeMember).GetPermissions()
```

- `Remove([bool]$force)` removes the safe member:

```powershell
Get-PASSafe -SafeName "Finance" | Get-PASSafeMember -MemberName "AppUser" | ForEach-Object{ $_.Remove($true) }
```

### Account (`psPAS.CyberArk.Vault.Account.V10`)

Objects returned by `Get-PASAccount`.

- `GetActivity()`, `GetDetails()` and `GetPassword()` are shortcuts for `Get-PASAccountActivity`, `Get-PASAccountDetail` and `Get-PASAccountPassword`:

```powershell
$account = Get-PASAccount -id 330_5
$account.GetActivity()
$account.GetPassword() | Select-Object -ExpandProperty Password
```

- `VerifyPassword()`, `ChangePassword()` and `ReconcilePassword()` trigger the equivalent `Invoke-PASCPMOperation` task:

```powershell
Get-PASAccount -id 330_5 | ForEach-Object{ $_.ChangePassword() }
```

- `Remove([bool]$force)` removes the account:

```powershell
(Get-PASAccount -id 330_5).Remove($true)
```

- `ToHashtable()` converts the account object back into a parameter hashtable suitable for `Add-PASAccount`/`Set-PASAccount`-style calls (useful for cloning an account):

```powershell
$params = (Get-PASAccount -id 330_5).ToHashtable()
Add-PASAccount @params
```

### Credential (`psPAS.CyberArk.Vault.Credential`)

Objects returned by `Get-PASAccountPassword`.

- `ToSecureString()` converts the retrieved password into a `SecureString`:

```powershell
(Get-PASAccount -id 330_5 | Get-PASAccountPassword).ToSecureString()
```

- `ToCredential()` / `ToPsCredential()` (identical, one is an alias of the other) build a `PSCredential`, optionally overriding the username:

```powershell
$cred = (Get-PASAccount -id 330_5 | Get-PASAccountPassword).ToCredential()
$cred = (Get-PASAccount -id 330_5 | Get-PASAccountPassword).ToPsCredential("svc_account")
```

### User (`psPAS.CyberArk.Vault.User`)

Objects returned by `Get-PASUser`.

- `Activate()`, `Disable()` and `Enable()` are shortcuts for `Unblock-PASUser`/`Set-PASUser`:

```powershell
Get-PASUser -UserName "jsmith" | ForEach-Object{ $_.Disable() }
```

- `Remove([bool]$force)` removes the user:

```powershell
(Get-PASUser -UserName "jsmith").Remove($true)
```

### ACL (`psPAS.CyberArk.Vault.ACL.Policy` / `.Account`)

Objects returned by `Get-PASPolicyACL` / `Get-PASAccountACL`.

- `Remove([bool]$force)` removes the ACL rule:

```powershell
Get-PASAccountACL -id 330_5 | ForEach-Object{ $_.Remove($true) }
```

### Discovery Scan (`psPAS.CyberArk.Vault.DiscoveryScan`)

Objects returned by `Get-PASDiscoveryScan`.

- `Stop([bool]$force)` stops an in-progress scan, and `Remove([bool]$force)` removes the scan:

```powershell
Get-PASDiscoveryScan | Where-Object{ $_.Status -eq "Running" } | ForEach-Object{ $_.Stop($true) }
```

> For all `Remove([bool]$force)`/`Stop([bool]$force)` methods, pass `$true` to bypass the `-Confirm` prompt, or `$false` (or call with no argument) to be prompted as normal.
