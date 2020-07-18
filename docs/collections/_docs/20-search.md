---
title: "Search"
permalink: /docs/search/
excerpt: "Basic Operations - Searching"
last_modified_at: 2020-06-28T01:33:52-00:00
---

## Safes

- Get information relating to Safes you have access to:

````powershell
Find-PASSafe -search 3_TestSafe_028_XYJ

SafeUrlId          SafeName           Description                  Location
-------- - --------           ---------- - --------
3_TestSafe_028_XYJ 3_TestSafe_028_XYJ TestSafe: 3_TestSafe_028_XYJ \

Get-PASSafe -SafeName 3_TestSafe_028_XYJ

SafeName           ManagingCPM     NumberOfDaysRetention NumberOfVersionsRetention Description
--------           ---------- - -------------------- - ------------------------ - ---------- -
3_TestSafe_028_XYJ PasswordManager                       3                         TestSafe: 3_TestSafe_028_XYJ
````

## Safe Members

- Find Safe Members:

````powershell
Get-PASSafeMember -SafeName 3_TestSafe_028_XYJ -MemberName ACC-G-3_TestSafe_028_XYJ-Usr

UserName                     SafeName           Permissions
--------                     --------           ---------- -
ACC-G-3_TestSafe_028_XYJ-Usr 3_TestSafe_028_XYJ @{Add=True; AddRenameFolder=True; BackupSafe=True...
````

## Users

- Query for Vault Users:

````powershell
Get-PASUser -Search xap

ID  UserName    Source UserType ComponentUser Location
--  --------    ------ -------- ------------ - --------
657 xApprover_A LDAP   EPVUser  False         \SomeLocation\Users
658 xApprover_1 LDAP   EPVUser  False         \SomeLocation\Users
659 xApprover_B LDAP   EPVUser  False         \SomeLocation\Users
660 xApprover_2 LDAP   EPVUser  False         \SomeLocation\Users
661 xApprover_C LDAP   EPVUser  False         \SomeLocation\Users
662 xApprover_3 LDAP   EPVUser  False         \SomeLocation\Users
````

## Accounts

- Return Account data:

````powershell
Get-PASAccount -SafeName "3_TestSafe_028_XYJ" -search sbwudlov

AccountID                 : 286_4
Safe                      : 3_TestSafe_028_XYJ
address                   : SOMEDOMAIN.COM
userName                  : sbwudlov
name                      : Operating System-Z_WINDOMAIN_OFF-SOMEDOMAIN.COM-sbwudlov
platformId                : Z_WINDOMAIN_OFF
secretType                : password
platformAccountProperties : @{LogonDomain = SOMEDOMAIN }
secretManagement          : @{automaticManagementEnabled = True; lastModifiedTime = 1559864222 }
createdTime               : 06/06/2019 23:37:02
````

### Classic API

- There is a limitation of only returning details of the first found account when using the Classic API.
- The `keywords` & `safe` parameters of `Get-PASAccount` force use of the Classic API:

````powershell
Get-PASAccount -Safe 3_TestSafe_028_XYJ
WARNING: 2 matching accounts found. Only the first result will be returned

AccountID          : 286_3
Safe               : 3_TestSafe_028_XYJ
Folder             : Root
Name               : Operating System-Z_WINDOMAIN_OFF-SOMEDOMAIN.COM-kmgrsebf
UserName           : kmgrsebf
PlatformID         : Z_WINDOMAIN_OFF
DeviceType         : Operating System
Address            : SOMEDOMAIN.COM
InternalProperties : @{CreationMethod = PVWA }
````

- More results can be returned by specifying alternative parameters and avoiding the Classic API:

````powershell
PS>Get-PASAccount -SafeName "3_TestSafe_028_XYJ"

AccountID                 : 286_3
Safe                      : 3_TestSafe_028_XYJ
address                   : SOMEDOMAIN.COM
userName                  : kmgrsebf
name                      : Operating System-Z_WINDOMAIN_OFF-SOMEDOMAIN.COM-kmgrsebf
platformId                : Z_WINDOMAIN_OFF
secretType                : password
platformAccountProperties : @{LogonDomain = SOMEDOMAIN }
secretManagement          : @{automaticManagementEnabled = True; lastModifiedTime = 1559864221 }
createdTime               : 06/06/2019 23:37:01

AccountID                 : 286_4
Safe                      : 3_TestSafe_028_XYJ
address                   : SOMEDOMAIN.COM
userName                  : sbwudlov
name                      : Operating System-Z_WINDOMAIN_OFF-SOMEDOMAIN.COM-sbwudlov
platformId                : Z_WINDOMAIN_OFF
secretType                : password
platformAccountProperties : @{LogonDomain = SOMEDOMAIN }
secretManagement          : @{automaticManagementEnabled = True; lastModifiedTime = 1559864222 }
createdTime               : 06/06/2019 23:37:02
````