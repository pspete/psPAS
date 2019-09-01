---
title: "Pipeline Operations"
permalink: /docs/pipeline-operations/
excerpt: "psPAS Pipeline Operations"
last_modified_at: 2019-09-01T01:33:52-00:00
---

- Work with the PowerShell pipeline:

````powershell
#Find directory groups assigned to safes
Get-PASSafe -query JXW | Get-PASSafeMember |
Where-Object { Get-PASGroup -search $_.UserName -filter 'groupType eq Directory' }

UserName                     SafeName           Permissions
--------                     --------           ---------- -
ACC-G-1_TestSafe_049_JXW-Usr 1_TestSafe_049_JXW { ListContent, RestrictedRetrieve, Retrieve, ViewAudit… }
ACC-G-1_TestSafe_049_JXW-Adm 1_TestSafe_049_JXW { ListContent, RestrictedRetrieve, Retrieve, Unlock… }
ACC-G-2_TestSafe_049_JXW-Usr 2_TestSafe_049_JXW { ListContent, RestrictedRetrieve, Retrieve, ViewAudit… }
ACC-G-2_TestSafe_049_JXW-Adm 2_TestSafe_049_JXW { ListContent, RestrictedRetrieve, Retrieve, Unlock… }
ACC-G-3_TestSafe_049_JXW-Usr 3_TestSafe_049_JXW { ListContent, RestrictedRetrieve, Retrieve, ViewAudit… }
ACC-G-3_TestSafe_049_JXW-Adm 3_TestSafe_049_JXW { ListContent, RestrictedRetrieve, Retrieve, Unlock… }
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
Master               ApproveTest { Add, AddRenameFolder, BackupSafe, Delete... }
Batch                ApproveTest { Add, AddRenameFolder, BackupSafe, Delete... }
Backup Users         ApproveTest BackupSafe
Auditors             ApproveTest { ListContent, ViewAudit, ViewMembers }
Operators            ApproveTest { AddRenameFolder, DeleteFolder, ManageSafe, MoveFilesAndFolders... }
DR Users             ApproveTest BackupSafe
Notification Engines ApproveTest { ListContent, ViewAudit, ViewMembers }
PVWAGWAccounts       ApproveTest { ListContent, ViewAudit, ViewMembers }
PasswordManager      ApproveTest { Add, AddRenameFolder, Delete, DeleteFolder... }
SafeAdmin            ApproveTest { Add, AddRenameFolder, BackupSafe, Delete... }
SafeAdmin1           ApproveTest { Add, AddRenameFolder, BackupSafe, Delete... }
zApprover_1          ApproveTest { ListContent, ViewAudit, ViewMembers }
xReq                 ApproveTest { ListContent, RestrictedRetrieve, Retrieve, ViewAudit... }
````
