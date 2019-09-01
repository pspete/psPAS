---
title: "CPM Operations"
permalink: /docs/cpm-operations/
excerpt: "psPAS CPM Operations"
last_modified_at: 2019-09-01T01:33:52-00:00
---

## Verify

- Verify passwords

```powershell
# immediate verification
Invoke-PASCPMOperation -AccountID $ID -VerifyTask
```

## Change

- Change passwords for accounts or account groups

```powershell
# immediate change
Invoke-PASCPMOperation -AccountID $ID -ChangeTask

# immediate change to a specific password value
Invoke-PASCPMOperation -AccountID $ID -ChangeTask -ChangeImmediately $true -NewCredentials $SecureString

# change password in the Vault only
Invoke-PASCPMOperation -AccountID $ID -ChangeTask -NewCredentials $SecureString

# change password for account group
Invoke-PASCPMOperation -AccountID $ID -ChangeTask -ChangeEntireGroup $true

# change password for account group to a specific password value
Invoke-PASCPMOperation -AccountID $ID -ChangeTask -ChangeEntireGroup $true -NewCredentials $SecureString
```

## Reconcile

- Reconcile passwords

```powershell
# immediate reconcile
Invoke-PASCPMOperation -AccountID $ID -ReconcileTask
```
