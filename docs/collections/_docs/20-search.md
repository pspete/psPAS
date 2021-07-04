---
title: "Search"
permalink: /docs/search/
excerpt: "Basic Operations - Searching"
last_modified_at: 2021-07-04T01:33:52-00:00
---

## Safes

- Get information relating to Safes you have access to:

````powershell
Get-PASSafe -search _YZO

SafeName           ManagingCPM     NumberOfDaysRetention NumberOfVersionsRetention Description
--------           -----------     --------------------- ------------------------- -----------
1_TestSafe_096_YZO PasswordManager                       3                         TestSafe: 1_TestSafe_096_YZO
1_TestSafe_100_YZO PasswordManager                       3                         TestSafe: 1_TestSafe_100_YZO
3_TestSafe_058_YZO PasswordManager                       3                         TestSafe: 3_TestSafe_058_YZO
3_TestSafe_068_YZO PasswordManager                       3                         TestSafe: 3_TestSafe_068_YZO
3_TestSafe_069_YZO PasswordManager                       3                         TestSafe: 3_TestSafe_069_YZO
2_TestSafe_090_YZO PasswordManager                       3                         TestSafe: 2_TestSafe_090_YZO
1_TestSafe_067_YZO PasswordManager                       3                         TestSafe: 1_TestSafe_067_YZO
````

## Safe Members

- Find Safe Members:

````powershell
Get-PASSafeMember -SafeName 1_TestSafe_067_YZO -search Usr

UserName                     SafeName           Permissions
--------                     --------           -----------
ACC-G-1_TestSafe_067_YZO-Usr 1_TestSafe_067_YZO @{useAccounts=True; retrieveAccounts=True; listAccounts=True; addAccounts=False;.....
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

### Gen1 API

- The `keywords` & `safe` parameters of `Get-PASAccount` force use of the Gen1 API:

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
- Only details of the first found account will be returned.
- More results can be returned by specifying alternative parameters to avoid sending the request via the Gen1 API

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