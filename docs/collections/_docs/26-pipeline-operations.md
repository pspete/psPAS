---
title: "Pipeline Operations"
permalink: /docs/pipeline-operations/
excerpt: "psPAS Pipeline Operations"
last_modified_at: 2020-06-28T01:33:52-00:00
---

- Work with the PowerShell pipeline:

````powershell
#Find directory groups assigned to safes
Get-PASSafe -query JXW | Get-PASSafeMember |
Where-Object { Get-PASGroup -search $_.UserName -filter 'groupType eq Directory' }

UserName                     SafeName           Permissions
--------                     --------           ---------- -
ACC-G-1_TestSafe_049_JXW-Usr 1_TestSafe_049_JXW @{Add=True; AddRenameFolder=True; BackupSafe=True...}
ACC-G-1_TestSafe_049_JXW-Adm 1_TestSafe_049_JXW @{Add=True; AddRenameFolder=True; BackupSafe=True...}
ACC-G-2_TestSafe_049_JXW-Usr 2_TestSafe_049_JXW @{Add=True; AddRenameFolder=True; BackupSafe=True...}
ACC-G-2_TestSafe_049_JXW-Adm 2_TestSafe_049_JXW @{Add=True; AddRenameFolder=True; BackupSafe=True...}
ACC-G-3_TestSafe_049_JXW-Usr 3_TestSafe_049_JXW @{Add=True; AddRenameFolder=True; BackupSafe=True...}
ACC-G-3_TestSafe_049_JXW-Adm 3_TestSafe_049_JXW @{Add=True; AddRenameFolder=True; BackupSafe=True...}
````

- Multiple `psPAS` commands can be used together, along with standard PowerShell CmdLets:

````powershell
#Add all "admin" users in the root location to the PVWAMonitor group
Get-PASUser -UserType EPVUser -Search Admin | Where-Object { $_.location -eq "\" } |
Add-PASGroupMember -GroupName PVWAMonitor

#Find an account, then find the members of the account's safe.
Get-PASAccount -id 330_5 | Get-PASSafe | Get-PASSafeMember

UserName             SafeName    Permissions
--------             --------    ---------- -
Master               ApproveTest @{Add=True; AddRenameFolder=True; BackupSafe=True...}
Batch                ApproveTest @{Add=True; AddRenameFolder=True; BackupSafe=True...}
Backup Users         ApproveTest @{Add=False; AddRenameFolder=False; BackupSafe=True...}
Auditors             ApproveTest @{Add=False; AddRenameFolder=False; BackupSafe=False...}
Operators            ApproveTest @{Add=True; AddRenameFolder=True; BackupSafe=True...}
DR Users             ApproveTest @{Add=False; AddRenameFolder=False; BackupSafe=True...}
Notification Engines ApproveTest @{Add=False; AddRenameFolder=False; BackupSafe=False...}
PVWAGWAccounts       ApproveTest @{Add=False; AddRenameFolder=False; BackupSafe=False...}
PasswordManager      ApproveTest @{Add=False; AddRenameFolder=True; BackupSafe=False...}
SafeAdmin            ApproveTest @{Add=True; AddRenameFolder=True; BackupSafe=True...}
SafeAdmin1           ApproveTest @{Add=True; AddRenameFolder=True; BackupSafe=True...}
zApprover_1          ApproveTest @{Add=False; AddRenameFolder=False; BackupSafe=False...}
xReq                 ApproveTest @{Add=False; AddRenameFolder=False; BackupSafe=False...}
````
