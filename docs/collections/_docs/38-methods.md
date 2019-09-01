---
title: "Methods"
permalink: /docs/methods/
excerpt: "psPAS Methods"
last_modified_at: 2019-09-01T01:33:52-00:00
---

## Using Methods

Methods present on objects returned from psPAS functions can be leveraged to get the data you need with ease.

- The `psPAS.CyberArk.Vault.Safe` object returned by `Get-PASSafe` has a ScriptMethod (`SafeMembers()`), which will run a query for the members of the safe:

```powershell
#List all safes where AppUser is not a member
Get-PASSafe | Where-Object{ ($_.safemembers() | Select-Object -ExpandProperty UserName) -notcontains "AppUser"}
```

- Retrieved credentials can be immediately converted into Secure Strings:

```powershell
(Get-PASAccount -id 330_5 | Get-PASAccountPassword).ToSecureString()
```
