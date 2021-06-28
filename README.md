[![psPAS][]][Docs]

[psPAS]:/docs/assets/images/header_photo.png
[Logo]:/docs/assets/images/shop_banner_symbol.png
[Docs]:https://pspas.pspete.dev

# **psPAS: PowerShell Module for the CyberArk API**

Use PowerShell to manage CyberArk via the PVWA REST API.

Contains all published methods of the API up to CyberArk v12.1.

Docs: [https://pspas.pspete.dev](https://pspas.pspete.dev)

----------

## Module Status

| Master Branch             | Latest Build             | CodeFactor                | Coverage                    |  PowerShell Gallery       |  License                   |
|---------------------------|--------------------------|---------------------------|-----------------------------|---------------------------|----------------------------|
|[![appveyor][]][av-site]   |[![tests][]][tests-site]  | [![codefactor][]][cf-site]| [![codecov][]][codecov-link]| [![psgallery][]][ps-site] |[![license][]][license-link]|
|[![release][]][github-site]|[![github][]][installlink]|                           | [![coveralls][]][cv-site]   | [![downloads][]][ps-site] |                            |

[appveyor]:https://ci.appveyor.com/api/projects/status/j45hbplm4dq4vfye/branch/master?svg=true
[av-site]:https://ci.appveyor.com/project/pspete/pspas/branch/master
[coveralls]:https://coveralls.io/repos/github/pspete/psPAS/badge.svg
[cv-site]:https://coveralls.io/github/pspete/psPAS
[psgallery]:https://img.shields.io/powershellgallery/v/psPAS.svg
[ps-site]:https://www.powershellgallery.com/packages/psPAS
[license]:https://img.shields.io/github/license/pspete/psPAS.svg
[license-link]:https://github.com/pspete/psPAS/blob/master/LICENSE.md
[tests]:https://img.shields.io/appveyor/tests/pspete/pspas.svg
[tests-site]:https://ci.appveyor.com/project/pspete/pspas
[downloads]:https://img.shields.io/powershellgallery/dt/pspas.svg?color=blue
[cf-site]:https://www.codefactor.io/repository/github/pspete/pspas
[codefactor]:https://www.codefactor.io/repository/github/pspete/pspas/badge
[codecov]:https://codecov.io/gh/pspete/psPAS/branch/master/graph/badge.svg
[codecov-link]:https://codecov.io/gh/pspete/psPAS
[github]:https://img.shields.io/github/downloads/pspete/psPAS/total?color=brightgreen
[github-site]:https://github.com/pspete/psPAS/releases/latest
[release]:https://img.shields.io/github/v/release/pspete/psPAS?color=brightgreen
[installlink]:https://github.com/pspete/psPAS#install-options

----------

- [Usage](#usage)
  - [Authenticate](#authenticate)
  - [Basic Operations](#basic-operations)
  - [Advanced Examples](#advanced-examples)
  - [Sample Scripts](#sample-scripts)
- [psPAS Functions](#pspas-functions)
- [Installation](#installation)
  - [Prerequisites](#prerequisites)
  - [Install Options](#install-options)
  - [Verification](#verification)
- [Sponsorship](#sponsorship)
- [Changelog](#changelog)
- [Author](#author)
- [License](#license)
- [Contributing](#contributing)
- [Acknowledgements](#acknowledgements)

## Usage

![Logo][Logo]

### Authenticate

_It all starts with a **Logon**_

`New-PASSession` is used to send a logon request to the CyberArk API.

On successful authentication `psPAS` uses the data which was provided for the request & also returned from the API for all subsequent operations.

#### CyberArk Authentication

- Use a PowerShell credential object containing a valid vault username and password.

````powershell
$cred = Get-Credential

PowerShell credential request
Enter your credentials.
User: safeadmin
Password for user safeadmin: **********


New-PASSession -Credential $cred -BaseURI https://pvwa.somedomain.com
````

#### LDAP Authentication

- Specify LDAP credentials allowed to authenticate to the vault.

````powershell
$cred = Get-Credential

PowerShell credential request
Enter your credentials.
User: xApprover_1
Password for user xApprover_1: **********


New-PASSession -Credential $cred -BaseURI https://pvwa.somedomain.com -type LDAP

Get-PASLoggedOnUser

UserName    Source UserTypeName AgentUser Expired Disabled Suspended
--------    ------ ------------ --------- ------- -------- ---------
xApprover_1 LDAP   EPVUser      False     False   False    False
````

#### RADIUS Authentication

##### Challenge Mode

````powershell
$cred = Get-Credential

PowerShell credential request
Enter your credentials.
User: DuoUser
Password for user DuoUser: **********


New-PASSession -Credential $cred -BaseURI https://pvwa.somedomain.com -type RADIUS -OTP 123456

Get-PASLoggedOnUser

UserName Source UserTypeName AgentUser Expired Disabled Suspended
-------- ------ ------------ --------- ------- -------- ---------
DuoUser  LDAP   EPVUser      False     False   False    False
````

##### Append Mode

- Some 2FA solutions allow a One Time Passcode to be sent with the password.

  - If an OTP is provided, it is sent to the API with the password, separated by a delimiter: "`$Password,$OTP`"

````powershell
$cred = Get-Credential

PowerShell credential request
Enter your credentials.
User: DuoUser
Password for user DuoUser: **********


New-PASSession -Credential $cred -BaseURI https://pvwa.somedomain.com -type RADIUS -OTP 738458 -OTPMode Append

Get-PASLoggedOnUser

UserName Source UserTypeName AgentUser Expired Disabled Suspended
-------- ------ ------------ --------- ------- -------- ---------
DuoUser  LDAP   EPVUser      False     False   False    False
````

#### Shared Authentication with Client Certificate

- If IIS is configured to require client certificates, `psPAS` will use any provided certificate details for the duration of the session.

````powershell
$Cert = "0E199489C57E666115666D6E9990C2ACABDB6EDB"
New-PASSession -UseSharedAuthentication -BaseURI https://pvwa.somedomain.com -CertificateThumbprint $Cert
````

### Basic Operations

![Logo][Logo]

#### Search

##### Safes

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

##### Users

- Query for Vault Users:

````powershell
Get-PASUser -Search xap

ID  UserName    Source UserType ComponentUser Location
--  --------    ------ -------- ------------- --------
657 xApprover_A LDAP   EPVUser  False         \psPETE\Users
658 xApprover_1 LDAP   EPVUser  False         \psPETE\Users
659 xApprover_B LDAP   EPVUser  False         \psPETE\Users
660 xApprover_2 LDAP   EPVUser  False         \psPETE\Users
661 xApprover_C LDAP   EPVUser  False         \psPETE\Users
662 xApprover_3 LDAP   EPVUser  False         \psPETE\Users
````

##### Accounts

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

###### 1st Gen API

- The `keywords` & `safe` parameters of `Get-PASAccount` force use of the 1st gen API:

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
- More results can be returned by specifying alternative parameters to avoid sending the request via the 1st gen API

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

![Logo][Logo]

#### Administration

##### Add An Account

- Add an account to manage:

````powershell
#Convert Password to SecureString
$Password = ConvertTo-SecureString -String "Secret1337$" -AsPlainText -Force

#Additional account details
$platformAccountProperties = @{
  "LOGONDOMAIN"="domain.com"
  "Notes"="Demo Account. Owner:psPete"
  "Classification"="1F"
}

#Add Account
Add-PASAccount -secretType Password -secret $Password -SafeName "YourSafe" -PlatformID "YourPlatform" `
-Address "domain" -Username SomeUsername -platformAccountProperties $platformAccountProperties
````

##### Create Safes

- Simple safe creation:

````powershell
Add-PASSafe -SafeName NewSafe -Description "New Safe" -ManagingCPM PasswordManager -NumberOfVersionsRetention 10

SafeName ManagingCPM     NumberOfDaysRetention NumberOfVersionsRetention Description
-------- -----------     --------------------- ------------------------- -----------
NewSafe  PasswordManager                       10                        New Safe
````

##### Add Safe Members

- Consistent safe membership:

````powershell
Add-PASSafeMember -SafeName NewSafe -MemberName NewMember -UseAccounts $false -ListAccounts $true `
	-RetrieveAccounts $false -ViewAuditLog $true -ViewSafeMembers $true

UserName  SafeName Permissions
--------  -------- -----------
NewMember NewSafe  @{useAccounts=False; retrieveAccounts=False; listAccounts=True; addAccounts=False;...
````

##### Update Accounts

- Update values for individual account properties:

````powershell
Set-PASAccount -AccountID 286_4 -op replace -path /address -value NEWDOMAIN.COM

AccountID                 : 286_4
Safe                      : 3_TestSafe_028_XYJ
address                   : NEWDOMAIN.COM
userName                  : sbwudlov
name                      : Operating System-Z_WINDOMAIN_OFF-SOMEDOMAIN.COM-sbwudlov
platformId                : Z_WINDOMAIN_OFF
secretType                : password
platformAccountProperties : @{LogonDomain=SOMEDOMAIN}
secretManagement          : @{automaticManagementEnabled=True; lastModifiedTime=1559864222}
createdTime               : 06/06/2019 23:37:02

Set-PASAccount -AccountID 286_4 -op replace -path /platformAccountProperties/LogonDomain -value NEWDOMAIN

AccountID                 : 286_4
Safe                      : 3_TestSafe_028_XYJ
address                   : NEWDOMAIN.COM
userName                  : sbwudlov
name                      : Operating System-Z_WINDOMAIN_OFF-SOMEDOMAIN.COM-sbwudlov
platformId                : Z_WINDOMAIN_OFF
secretType                : password
platformAccountProperties : @{LogonDomain=NEWDOMAIN}
secretManagement          : @{automaticManagementEnabled=True; lastModifiedTime=1559864222}
createdTime               : 06/06/2019 23:37:02
````

![Logo][Logo]

##### CPM Operations

###### Verify

- Verify passwords

```powershell
# immediate verification
Invoke-PASCPMOperation -AccountID $ID -VerifyTask
```

###### Change

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

###### Reconcile

- Reconcile passwords

```powershell
# immediate reconcile
Invoke-PASCPMOperation -AccountID $ID -ReconcileTask
```

##### Import a Connection Component

- Import Custom Connection Components:

````powershell
Import-PASConnectionComponent -ImportFile C:\Temp\ConnectionComponent.zip
````

##### Platforms

- Import & Export of CPM Platforms:

````powershell
#Import a Platform
Import-PASPlatform -ImportFile C:\Temp\Platform.zip

#Export a Platform
Export-PASPlatform -PlatformID "Some-SSH-Platform" -Path C:\Temp
````

![Logo][Logo]

#### Pipeline Operations

- Work with the PowerShell pipeline:

````powershell
#Find directory groups assigned to safes
Get-PASSafe -search YZO | Get-PASSafeMember -memberType group -includePredefinedUsers $false |
    Where-Object { Get-PASGroup -search $_.UserName -groupType Directory }

UserName                     SafeName           Permissions
--------                     --------           -----------
ACC-G-1_TestSafe_096_YZO-Usr 1_TestSafe_096_YZO @{useAccounts=True; retrieveAccounts=True; lis...
ACC-G-1_TestSafe_096_YZO-Adm 1_TestSafe_096_YZO @{useAccounts=True; retrieveAccounts=True; lis...
ACC-G-1_TestSafe_100_YZO-Usr 1_TestSafe_100_YZO @{useAccounts=True; retrieveAccounts=True; lis...
ACC-G-1_TestSafe_100_YZO-Adm 1_TestSafe_100_YZO @{useAccounts=True; retrieveAccounts=True; lis...
ACC-G-3_TestSafe_058_YZO-Usr 3_TestSafe_058_YZO @{useAccounts=True; retrieveAccounts=True; lis...
ACC-G-3_TestSafe_058_YZO-Adm 3_TestSafe_058_YZO @{useAccounts=True; retrieveAccounts=True; lis...
ACC-G-3_TestSafe_068_YZO-Usr 3_TestSafe_068_YZO @{useAccounts=True; retrieveAccounts=True; lis...
ACC-G-3_TestSafe_068_YZO-Adm 3_TestSafe_068_YZO @{useAccounts=True; retrieveAccounts=True; lis...
ACC-G-3_TestSafe_069_YZO-Usr 3_TestSafe_069_YZO @{useAccounts=True; retrieveAccounts=True; lis...
ACC-G-3_TestSafe_069_YZO-Adm 3_TestSafe_069_YZO @{useAccounts=True; retrieveAccounts=True; lis...
ACC-G-2_TestSafe_090_YZO-Usr 2_TestSafe_090_YZO @{useAccounts=True; retrieveAccounts=True; lis...
ACC-G-2_TestSafe_090_YZO-Adm 2_TestSafe_090_YZO @{useAccounts=True; retrieveAccounts=True; lis...
ACC-G-1_TestSafe_067_YZO-Usr 1_TestSafe_067_YZO @{useAccounts=True; retrieveAccounts=True; lis...
ACC-G-1_TestSafe_067_YZO-Adm 1_TestSafe_067_YZO @{useAccounts=True; retrieveAccounts=True; lis...

````

- Multiple `psPAS` commands can be used together, along with standard PowerShell CmdLets:

````powershell
#Add all "admin" users in the root location to the PVWAMonitor group
Get-PASUser -UserType EPVUser -Search Admin | Where-Object { $_.location -eq "\" } |
Add-PASGroupMember -GroupName PVWAMonitor

#Find an account, then find the members of the account's safe.
Get-PASAccount -id 283_3 | Get-PASSafeMember

UserName                     SafeName           Permissions
--------                     --------           -----------
SafeAdmin                    3_TestSafe_100_OWZ @{useAccounts=True; retrieveAccounts=True; lis...
PSMAppUsers                  3_TestSafe_100_OWZ @{useAccounts=False; retrieveAccounts=False; lis...
PasswordManager              3_TestSafe_100_OWZ @{useAccounts=True; retrieveAccounts=True; lis...
SafeAdmin3                   3_TestSafe_100_OWZ @{useAccounts=True; retrieveAccounts=True; lis...
ACC-G-3_TestSafe_100_OWZ-Usr 3_TestSafe_100_OWZ @{useAccounts=True; retrieveAccounts=True; lis...
ACC-G-3_TestSafe_100_OWZ-Adm 3_TestSafe_100_OWZ @{useAccounts=True; retrieveAccounts=True; lis...
Prov_ZZSRV01                 3_TestSafe_100_OWZ @{useAccounts=False; retrieveAccounts=True; lis...
psPAS                        3_TestSafe_100_OWZ @{useAccounts=False; retrieveAccounts=True; lis...
````

### Advanced Examples

![Logo][Logo]

#### Bulk Operations

The standard features of PowerShell which allow creation of and iterations through collections of objects, can be used to perform bulk operations:

##### Example 1 - On-board Multiple Accounts

````powershell
$Accounts = Import-Csv -Path C:\Temp\Accounts.csv

New-PASSession -Credential $creds -BaseURI https://your.pvwa.url

foreach($Account in $Accounts){

    $Password = ConvertTo-SecureString -String $Account.Password -AsPlainText -Force

    Add-PASAccount -secretType Password `
    -secret $Password `
    -platformAccountProperties @{"LOGONDOMAIN"=$Account.LogonDomain} `
    -SafeName $Account.SafeName `
    -PlatformID $Account.PlatformID `
    -Address $Account.Address `
    -Username $Account.Username

}

Close-PASSession
````

##### Example 2 - Delete Multiple Safes

````powershell
#Specify Vault Logon Credentials
$LogonCredential = Get-Credential

#Logon
New-PASSession -Credential $LogonCredential -BaseURI https://your.pvwa.url

$Safes = Get-PASSafe -search TestSafe

#Delete Safes
foreach ($Safe in $Safes){

  Remove-PASSafe -SafeName $Safe -WhatIf

}

#Logoff
Close-PASSession
````

##### Example 3 - Move a List of Users to a New Location

````powershell
#Vault Logon Credentials
$LogonCredential = Get-Credential

#Logon
New-PASSession -Credential $LogonCredential -BaseURI https://your.pvwa.url

#get list of users
$users = Get-Content .\userlist.txt

#move users
$users | foreach{

  Set-PASUser -UserName $_ -Location "\New\Location\Path" -WhatIf

}

#Logoff
Close-PASSession
````

![Logo][Logo]

#### Safe Permissions

- Define Safe Roles and assign to safe members:

````powershell
$Role1 = [PSCustomObject]@{
  UseAccounts                            = $true
  ListAccounts                           = $true
  ViewAuditLog                           = $false
  ViewSafeMembers                        = $false
}

$Role2 = [PSCustomObject]@{
  UseAccounts                            = $false
  ListAccounts                           = $true
  RetrieveAccounts                       = $false
  AddAccounts                            = $true
  UpdateAccountContent                   = $true
  UpdateAccountProperties                = $true
  InitiateCPMAccountManagementOperations = $true
  SpecifyNextAccountContent              = $false
  RenameAccounts                         = $true
  DeleteAccounts                         = $true
  UnlockAccounts                         = $true
  ManageSafe                             = $true
  ManageSafeMembers                      = $true
  BackupSafe                             = $false
  ViewAuditLog                           = $true
  ViewSafeMembers                        = $true
  RequestsAuthorizationLevel             = $false
  AccessWithoutConfirmation              = $true
  CreateFolders                          = $true
  DeleteFolders                          = $true
  MoveAccountsAndFolders                 = $true
}

$Role1 | Add-PASSafeMember -SafeName NewSafe -MemberName a032485 -SearchIn Vault

UserName SafeName Permissions
-------- -------- -----------
a032485  NewSafe  @{useAccounts=True; retrieveAccounts=False; listAccounts=True;...

$Role2 | Add-PASSafeMember -SafeName NewSafe -MemberName SafeAdmin1 -SearchIn Vault

UserName   SafeName Permissions
--------   -------- -----------
SafeAdmin1 NewSafe  @{useAccounts=False; retrieveAccounts=False; listAccounts=Tr...
````

![Logo][Logo]

#### PSM Sessions

##### Terminate all Active PSM Sessions on a PSM Server

````powershell
#Find Active Sessions for a PSM Server IP
#Terminate the Sessions
Get-PASPSMSession | Where-Object{
  ($_.RawProperties.ProviderID -eq $(Get-PASComponentDetail -ComponentID SessionManagement |
    Where-Object{$_.ComponentIP -eq "192.168.60.20"} |
    Select -ExpandProperty ComponentUserName))
  -and ($_.IsLive) -and ($_.CanTerminate)} | Stop-PASPSMSession
````

![Logo][Logo]

#### Updating Multiple Properties of an Account

- Multiple updates can be performed in a single request:

````powershell
[array]$operations += @{"op"="remove";"path"="/platformAccountProperties/LogonDomain"}
[array]$operations += @{"op"="replace";"path"="/name";"value"="SomeNewName"}
[array]$operations += @{"op"="replace";"path"="/address";"value"="domain.co.uk"}

Set-PASAccount -AccountID 286_4 -operations $operations

AccountID        : 286_4
Safe             : 3_TestSafe_028_XYJ
address          : domain.co.uk
userName         : sbwudlov
name             : SomeNewName
platformId       : Z_WINDOMAIN_OFF
secretType       : password
secretManagement : @{automaticManagementEnabled=True; lastModifiedTime=1559864222}
createdTime      : 06/06/2019 23:37:02
````

![Logo][Logo]

#### Using Methods

Methods present on objects returned from psPAS functions can be leveraged to get the data you need with ease.

- The `psPAS.CyberArk.Vault.Safe` object returned by `Get-PASSafe` has a ScriptMethod (`SafeMembers()`), which will run a query for the members of the safe:

```powershell
#List all safes where AppUser is not a member
Get-PASSafe | Where-Object{ ($_.safemembers() | Select-Object -ExpandProperty UserName) -notcontains "AppUser"}
```

- Retrieved credentials can be immediately converted into Secure Strings or into a PsCredential object:

```powershell
#Returns a Secure String 
(Get-PASAccount -id 330_5 | Get-PASAccountPassword).ToSecureString()

#Returns a PsCredential Object 
(Get-PASAccount -id 330_5 | Get-PASAccountPassword).ToPsCredential()

#Returns a PsCredential Object with a custom username (to include a domain for example)
(Get-PASAccount -id 330_5 | Get-PASAccountPassword).ToPsCredential("MyDomain\MyAccount")
```


![Logo][Logo]

#### API Sessions

- If actions are required to be performed under the context of different user accounts, it is possible to work with different authenticated sessions:

````powershell
#Start first session
$VaultAdmin = Get-Credential

PowerShell credential request
Enter your credentials.
User: VaultAdmin
Password for user VaultAdmin: **********


New-PASSession -Credential $VaultAdmin -BaseURI https://pvwa.somedomain.com

Get-PASLoggedOnUser

UserName   Source   UserTypeName AgentUser Expired Disabled Suspended
--------   ------   ------------ --------- ------- -------- ---------
VaultAdmin Internal EPVUser      False     False   False    False

#Save first session data
$FirstSession = Get-PASSession

#Start second session
$SafeAdmin = Get-Credential

PowerShell credential request
Enter your credentials.
User: SafeAdmin
Password for user SafeAdmin: **********


New-PASSession -Credential $SafeAdmin -BaseURI https://pvwa.somedomain.com

Get-PASLoggedOnUser

UserName  Source   UserTypeName AgentUser Expired Disabled Suspended
--------  ------   ------------ --------- ------- -------- ---------
SafeAdmin Internal EPVUser      False     False   False    False

#Save second session data
$SecondSession = Get-PASSession

#Switch back to first session
Use-PASSession -Session $FirstSession

Get-PASLoggedOnUser

UserName   Source   UserTypeName AgentUser Expired Disabled Suspended
--------   ------   ------------ --------- ------- -------- ---------
VaultAdmin Internal EPVUser      False     False   False    False

#End first session
Close-PASSession

#Switch to second session
Use-PASSession -Session $SecondSession

Get-PASLoggedOnUser

UserName  Source   UserTypeName AgentUser Expired Disabled Suspended
--------  ------   ------------ --------- ------- -------- ---------
SafeAdmin Internal EPVUser      False     False   False    False

#End second session
Close-PASSession
````

### Sample Scripts

A selection of psPAS sample scripts can be found in the [psPAS-Examples](https://github.com/pspete/psPAS-Examples) repository.

![Logo][Logo]

## psPAS Functions

Your version of CyberArk determines which functions of psPAS will be supported.

Check the below table to determine what is available for you to use.

The CyberArk Version listed is the minimum required to use the function.

The module will attempt to confirm that your version of CyberArk meets the minimum

version requirement (if you are using version 9.7+, and the function being invoked

requires version 9.8+).

Check the output of `Get-Help` for the `psPAS` functions for further details of available parameters and version requirements.

Click the below dropdown to view the current list of psPAS functions and their minimum version requirements:
<details>
  <Summary> List of Functions </summary>

**Function Name**                                                                        |**CyberArk Version**|**Description**
-----------------------------------------------------------------------------------------|--------------------|:----------------
[`New-PASSession`][New-PASSession]                                                       |**9.0**             |Authenticates a user to CyberArk Vault
[`Close-PASSession`][Close-PASSession]                                                   |**9.0**             |Logoff from CyberArk Vault.
[`Get-PASSession`][Get-PASSession]                                                       |**---**             |Get `psPAS` Session Data.
[`Use-PASSession`][Use-PASSession]                                                       |**---**             |Set `psPAS` Session Data.
[`Add-PASPublicSSHKey`][Add-PASPublicSSHKey]                                             |**9.6**             |Adds an authorised public SSH key for a user.
[`Get-PASPublicSSHKey`][Get-PASPublicSSHKey]                                             |**9.6**             |Retrieves a user's SSH Keys.
[`Remove-PASPublicSSHKey`][Remove-PASPublicSSHKey]                                       |**9.6**             |Deletes a Public SSH Key from a user
[`Add-PASAccountACL`][Add-PASAccountACL]                                                 |**9.0**             |Adds a new privileged command rule to an account.
[`Get-PASAccountACL`][Get-PASAccountACL]                                                 |**9.0**             |Lists privileged commands rule for an account
[`Remove-PASAccountACL`][Remove-PASAccountACL]                                           |**9.0**             |Deletes privileged commands rule from an account
[`Add-PASAccountGroupMember`][Add-PASAccountGroupMember]                                 |**9.95**            |Adds an account as a member of an account group.
[`Get-PASAccountGroup`][Get-PASAccountGroup]                                             |**9.10**            |Returns account groups in a Safe.
[`Get-PASAccountGroupMember`][Get-PASAccountGroupMember]                                 |**9.10**            |Returns  members of an account group.
[`New-PASAccountGroup`][New-PASAccountGroup]                                             |**9.95**            |Adds a new account group
[`Remove-PASAccountGroupMember`][Remove-PASAccountGroupMember]                           |**9.10**            |Deletes a member of an account group
[`Add-PASAccount`][Add-PASAccount]                                                       |**9.0**             |Adds a new account.
[`Add-PASPendingAccount`][Add-PASPendingAccount]                                         |**9.7**             |Adds discovered account or SSH key as a pending account.
[`Get-PASAccount`][Get-PASAccount]                                                       |**9.3**             |Returns information about accounts.
[`Get-PASAccountActivity`][Get-PASAccountActivity]                                       |**9.7**             |Returns activities for an account.
[`Get-PASAccountPassword`][Get-PASAccountPassword]                                       |**9.7**             |Returns password for an account.
[`Remove-PASAccount`][Remove-PASAccount]                                                 |**9.3**             |Deletes an account
[`Set-PASAccount`][Set-PASAccount]                                                       |**9.5**             |Updates details of an account.
[`Invoke-PASCPMOperation`][Invoke-PASCPMOperation]                                       |**9.7**             |Invoke CPM verify, change & reconcile tasks.
[`Unlock-PASAccount`][Unlock-PASAccount]                                                 |**9.10**            |Checks in an exclusive-use account.
[`Add-PASApplication`][Add-PASApplication]                                               |**9.1**             |Adds a new application
[`Add-PASApplicationAuthenticationMethod`][Add-PASApplicationAuthenticationMethod]       |**9.1**             |Add authentication method to an application
[`Get-PASApplication`][Get-PASApplication]                                               |**9.1**             |Returns details of applications
[`Get-PASApplicationAuthenticationMethod`][Get-PASApplicationAuthenticationMethod]       |**9.1**             |Returns application authentication methods
[`Remove-PASApplication`][Remove-PASApplication]                                         |**9.1**             |Deletes an application
[`Remove-PASApplicationAuthenticationMethod`][Remove-PASApplicationAuthenticationMethod] |**9.1**             |Delete auth method from an application
[`Import-PASConnectionComponent`][Import-PASConnectionComponent]                         |**10.3**            |Imports a Connection Component
[`New-PASPSMSession`][New-PASPSMSession]                                                 |**9.10**            |Get required parameters to connect through PSM
[`Get-PASPSMRecording`][Get-PASPSMRecording]                                             |**9.10**            |Get details of PSM Recording
[`Get-PASPSMSession`][Get-PASPSMSession]                                                 |**9.10**            |Get details of PSM Sessions
[`Resume-PASPSMSession`][Resume-PASPSMSession]                                           |**10.2**            |Resumes a Suspended PSM Session.
[`Stop-PASPSMSession`][Stop-PASPSMSession]                                               |**10.1**            |Terminates a PSM Session.
[`Suspend-PASPSMSession`][Suspend-PASPSMSession]                                         |**10.2**            |Suspends a PSM Session.
[`Get-PASOnboardingRule`][Get-PASOnboardingRule]                                         |**9.7**             |Gets automatic on-boarding rules
[`New-PASOnboardingRule`][New-PASOnboardingRule]                                         |**9.7**             |Adds a new on-boarding rule
[`Remove-PASOnboardingRule`][Remove-PASOnboardingRule]                                   |**9.7**             |Deletes an automatic on-boarding rule
[`Get-PASPlatform`][Get-PASPlatform]                                                     |**9.10**            |Retrieves details of a specified platform.
[`Import-PASPlatform`][Import-PASPlatform]                                               |**10.2**            |Import a new platform
[`Export-PASPlatform`][Export-PASPlatform]                                               |**10.4**            |Export a  platform
[`Add-PASPolicyACL`][Add-PASPolicyACL]                                                   |**9.0**             |Adds a new privileged command rule
[`Get-PASPolicyACL`][Get-PASPolicyACL]                                                   |**9.0**             |Lists OPM Rules for a policy
[`Remove-PASPolicyACL`][Remove-PASPolicyACL]                                             |**9.0**             |Delete privileged commands from policy
[`Approve-PASRequest`][Approve-PASRequest]                                               |**9.10**            |Confirm a single request
[`Deny-PASRequest`][Deny-PASRequest]                                                     |**9.10**            |Reject a single request
[`Get-PASRequest`][Get-PASRequest]                                                       |**9.10**            |List requests
[`Get-PASRequestDetail`][Get-PASRequestDetail]                                           |**9.10**            |Get request details
[`New-PASRequest`][New-PASRequest]                                                       |**9.10**            |Creates an access request for an account
[`Remove-PASRequest`][Remove-PASRequest]                                                 |**9.10**            |Deletes a request
[`Add-PASSafeMember`][Add-PASSafeMember]                                                 |**9.3**             |Adds a Safe Member to a safe
[`Get-PASSafeMember`][Get-PASSafeMember]                                                 |**9.7**             |Lists the members of a Safe
[`Remove-PASSafeMember`][Remove-PASSafeMember]                                           |**9.3**             |Removes a member from a safe
[`Set-PASSafeMember`][Set-PASSafeMember]                                                 |**9.3**             |Updates a Safe Member's Permissions
[`Add-PASSafe`][Add-PASSafe]                                                             |**9.2**             |Adds a new safe
[`Get-PASSafe`][Get-PASSafe]                                                             |**9.7**             |Returns safe details
[`Remove-PASSafe`][Remove-PASSafe]                                                       |**9.3**             |Deletes a safe
[`Set-PASSafe`][Set-PASSafe]                                                             |**9.3**             |Updates a safe
[`Get-PASSafeShareLogo`][Get-PASSafeShareLogo]                                           |**9.7**             |Returns details of SafeShare Logo
[`Get-PASServer`][Get-PASServer]                                                         |**9.7**             |Returns details of the Web Service Server
[`Get-PASServerWebService`][Get-PASServerWebService]                                     |**9.7**             |Returns details of the Web Service
[`Get-PASComponentDetail`][Get-PASComponentDetail]                                       |**10.1**            |Returns details about component instances.
[`Get-PASComponentSummary`][Get-PASComponentSummary]                                     |**10.1**            |Returns consolidated information about components.
[`Add-PASGroupMember`][Add-PASGroupMember]                                               |**9.7**             |Adds a user as a group member
[`Get-PASLoggedOnUser`][Get-PASLoggedOnUser]                                             |**9.7**             |Returns details of the logged on user
[`Get-PASUserLoginInfo`][Get-PASUserLoginInfo]                                           |**10.4**            |Returns login details of the current user
[`Get-PASUser`][Get-PASUser]                                                             |**9.7**             |Returns details of a user
[`New-PASUser`][New-PASUser]                                                             |**9.7**             |Creates a new user
[`Remove-PASUser`][Remove-PASUser]                                                       |**9.7**             |Deletes a user
[`Set-PASUser`][Set-PASUser]                                                             |**9.7**             |Updates a user
[`Unblock-PASUser`][Unblock-PASUser]                                                     |**9.7**             |Activates a suspended user
[`Get-PASDirectory`][Get-PASDirectory]                                                   |**10.4**            |Get configured LDAP directories
[`Add-PASDirectory`][Add-PASDirectory]                                                   |**10.4**            |Add a new LDAP directory
[`New-PASDirectoryMapping`][New-PASDirectoryMapping]                                     |**10.4**            |Create a new LDAP directory mapping
[`Add-PASPTARule`][Add-PASPTARule]                                                       |**10.4**            |Add a new Risky Commandrule to PTA
[`Get-PASPTAEvent`][Get-PASPTAEvent]                                                     |**10.3**            |Get security events from PTA
[`Set-PASPTAEvent`][Set-PASPTAEvent]                                                     |**11.3**            |Set PTA security event status
[`Get-PASPTARemediation`][Get-PASPTARemediation]                                         |**10.4**            |Get automatic response config from PTA
[`Get-PASPTARule`][Get-PASPTARule]                                                       |**10.4**            |List Risky Command rules from PTA
[`Set-PASPTARemediation`][Set-PASPTARemediation]                                         |**10.4**            |Update automaticresponse config in PTA
[`Set-PASPTARule`][Set-PASPTARule]                                                       |**10.4**            |Update a Risky Commandrule in PTA
[`Get-PASGroup`][Get-PASGroup]                                                           |**10.5**            |Return group information
[`Remove-PASGroupMember`][Remove-PASGroupMember]                                         |**10.5**            |Remove group members
[`Set-PASOnboardingRule`][Set-PASOnboardingRule]                                         |**10.5**            |Update Onboarding Rules
[`Add-PASDiscoveredAccount`][Add-PASDiscoveredAccount]                                   |**10.5**            |Add discovered accounts to the Accounts Feed
[`Connect-PASPSMSession`][Connect-PASPSMSession]                                         |**10.5**            |Get required parameters to connect to a PSM Session
[`Get-PASPSMSessionActivity`][Get-PASPSMSessionActivity]                                 |**10.6**            |Get activity details from an active PSM Session.
[`Get-PASPSMSessionProperty`][Get-PASPSMSessionProperty]                                 |**10.6**            |Get property details from an active PSM Session.
[`Get-PASPSMRecordingActivity`][Get-PASPSMRecordingActivity]                             |**10.6**            |Get activity details from a PSM Recording.
[`Get-PASPSMRecordingProperty`][Get-PASPSMRecordingProperty]                             |**10.6**            |Get property details from a PSM Recording.
[`Export-PASPSMRecording`][Export-PASPSMRecording]                                       |**10.6**            |Save PSM Session Recording to a file.
[`Request-PASAdHocAccess`][Request-PASAdHocAccess]                                       |**10.6**            |Request temporary access to a server.
[`Get-PASDirectoryMapping`][Get-PASDirectoryMapping]                                     |**10.7**            |Get details of configured directory mappings.
[`Set-PASDirectoryMapping`][Set-PASDirectoryMapping]                                     |**10.7**            |Update a configured directory mapping.
[`Remove-PASDirectory`][Remove-PASDirectory]                                             |**10.7**            |Delete a directory configuration.
[`Find-PASSafe`][Find-PASSafe]                                                           |**10.1** - **11.7** |List or Search Safes by name.
[`Set-PASDirectoryMappingOrder`][Set-PASDirectoryMappingOrder]                           |**10.10**           |Reorder Directory Mappings
[`Set-PASUserPassword`][Set-PASUserPassword]                                             |**10.10**           |Reset a User's Password
[`New-PASGroup`][New-PASGroup]                                                           |**11.1**            |Create a new CyberArk group
[`Get-PASPlatformSafe`][Get-PASPlatformSafe]                                             |**11.1**            |List details for all platforms
[`Remove-PASDirectoryMapping`][Remove-PASDirectoryMapping]                               |**11.1**            |Deletes a Directory Mapping
[`Enable-PASCPMAutoManagement`][Enable-PASCPMAutoManagement]                             |**10.4**            |Enables Automatic CPM Management for an account
[`Disable-PASCPMAutoManagement`][Disable-PASCPMAutoManagement]                           |**10.4**            |Disables Automatic CPM Management for an account
[`Test-PASPSMRecording`][Test-PASPSMRecording]                                           |**11.2**            |Determine validity of PSM Session Recording
[`Copy-PASPlatform`][Copy-PASPlatform]                                                   |**11.4**            |Duplicate a platform
[`Enable-PASPlatform`][Enable-PASPlatform]                                               |**11.4**            |Enable a platform
[`Disable-PASPlatform`][Disable-PASPlatform]                                             |**11.4**            |Disable a platform
[`Remove-PASPlatform`][Remove-PASPlatform]                                               |**11.4**            |Delete a platform
[`Remove-PASGroup`][Remove-PASGroup]                                                     |**11.5**            |Delete a user group
[`Get-PASAllowedReferrer`][Get-PASAllowedReferrer]                                       |**11.5**            |List PVWA Allowed Referrer
[`Add-PASAllowedReferrer`][Add-PASAllowedReferrer]                                       |**11.5**            |Add PVWA Allowed Referrer
[`Get-PASAccountSSHKey`][Get-PASAccountSSHKey]                                           |**11.5**            |Get Private SSH Key value of Account
[`Get-PASAuthenticationMethod`][Get-PASAuthenticationMethod]                             |**11.5**            |List authentication methods
[`Add-PASAuthenticationMethod`][Add-PASAuthenticationMethod]                             |**11.5**            |Add authentication method
[`Set-PASAuthenticationMethod`][Set-PASAuthenticationMethod]                             |**11.5**            |Update authentication method
[`Get-PASConnectionComponent`][Get-PASConnectionComponent]                               |**11.5**            |List configured connection components
[`Get-PASPSMServer`][Get-PASPSMServer]                                                   |**11.5**            |List configured PSM Servers
[`Get-PASPlatformPSMConfig`][Get-PASPlatformPSMConfig]                                   |**11.5**            |List Platform PSM configuration
[`Set-PASPlatformPSMConfig`][Set-PASPlatformPSMConfig]                                   |**11.5**            |Update Platform PSM configuration
[`Start-PASAccountImportJob`][Start-PASAccountImportJob]                                 |**11.6**            |Add multiple accounts to existing Safes.
[`Get-PASAccountImportJob`][Get-PASAccountImportJob]                                     |**11.6**            |Get status of account import
[`New-PASAccountObject`][New-PASAccountObject]                                           |**---**             |Format an object to include in an import list
[`Get-PASDiscoveredAccount`][Get-PASDiscoveredAccount]                                   |**11.6**            |List discovered accounts
[`Add-PASOpenIDConnectProvider`][Add-PASOpenIDConnectProvider]                           |**11.7**            |Adds an OIDC Authentication Provider
[`Get-PASOpenIDConnectProvider`][Get-PASOpenIDConnectProvider]                           |**11.7**            |Gets details of configured OIDC Authentication Providers
[`Remove-PASOpenIDConnectProvider`][Remove-PASOpenIDConnectProvider]                     |**11.7**            |Deletes an OIDC Authentication Provider
[`Set-PASOpenIDConnectProvider`][Set-PASOpenIDConnectProvider]                           |**11.7**            |Updates an OIDC Authentication Provider
[`Remove-PASAuthenticationMethod`][Remove-PASAuthenticationMethod]                       |**11.7**            |Delete an authentication method
[`Clear-PASDiscoveredAccountList`][Clear-PASDiscoveredAccountList]                       |**12.1**            |Clear all discovered accounts from the pending account list
[`Get-PASAccountPasswordVersion`][Get-PASAccountPasswordVersion]                         |**12.1**            |Get details of previous password versions
[`New-PASAccountPassword`][New-PASAccountPassword]                                       |**12.0**            |Generate new password values based on platform policy
[`Set-PASLinkedAccount`][Set-PASLinkedAccount]                                           |**12.1**            |Associate logon and reconcile accounts
[`Clear-PASPrivateSSHKey`][Clear-PASPrivateSSHKey]                                       |**12.1**            |Remove all MFA caching SSH Keys
[`New-PASPrivateSSHKey`][New-PASPrivateSSHKey]                                           |**12.1**            |Generate MFA caching SSH Keys
[`Remove-PASPrivateSSHKey`][Remove-PASPrivateSSHKey]                                     |**12.1**            |Delete MFA caching SSH Keys
[`Set-PASGroup`][Set-PASGroup]                                                           |**12.0**            |Update CyberArk groups

[Add-PASOpenIDConnectProvider]:/psPAS/Functions/Authentication/Add-PASOpenIDConnectProvider
[Get-PASOpenIDConnectProvider]:/psPAS/Functions/Authentication/Get-PASOpenIDConnectProvider
[Remove-PASOpenIDConnectProvider]:/psPAS/Functions/Authentication/Remove-PASOpenIDConnectProvider
[Set-PASOpenIDConnectProvider]:/psPAS/Functions/Authentication/Set-PASOpenIDConnectProvider
[Remove-PASAuthenticationMethod]:/psPAS/Functions/Authentication/Remove-PASAuthenticationMethod
[Get-PASDiscoveredAccount]:/psPAS/Functions/Accounts/Get-PASDiscoveredAccount.ps1
[Start-PASAccountImportJob]:/psPAS/Functions/Accounts/Start-PASAccountImportJob.ps1
[Get-PASAccountImportJob]:/psPAS/Functions/Accounts/Get-PASAccountImportJob.ps1
[New-PASAccountObject]:/psPAS/Functions/Accounts/New-PASAccountObject.ps1
[Get-PASAllowedReferrer]:/psPAS/Functions/General/Get-PASAllowedReferrer.ps1
[Add-PASAllowedReferrer]:/psPAS/Functions/General/Add-PASAllowedReferrer.ps1
[Get-PASAccountSSHKey]:/psPAS/Functions/Accounts/Get-PASAccountSSHKey.ps1
[Get-PASAuthenticationMethod]:/psPAS/Functions/Authentication/Get-PASAuthenticationMethod.ps1
[Add-PASAuthenticationMethod]:/psPAS/Functions/Authentication/Add-PASAuthenticationMethod.ps1
[Set-PASAuthenticationMethod]:/psPAS/Functions/Authentication/Set-PASAuthenticationMethod.ps1
[Get-PASConnectionComponent]:/psPAS/Functions/Connections/Get-PASConnectionComponent.ps1
[Get-PASPSMServer]:/psPAS/Functions/Connections/Get-PASPSMServer.ps1
[Get-PASPlatformPSMConfig]:/psPAS/Functions/Platforms/Get-PASPlatformPSMConfig.ps1
[Set-PASPlatformPSMConfig]:/psPAS/Functions/Platforms/Set-PASPlatformPSMConfig.ps1
[New-PASSession]:/psPAS/Functions/Authentication/New-PASSession.ps1
[Close-PASSession]:/psPAS/Functions/Authentication/Close-PASSession.ps1
[Get-PASSession]:/psPAS/Functions/Authentication/Get-PASSession.ps1
[Use-PASSession]:/psPAS/Functions/Authentication/Use-PASSession.ps1
[Add-PASPublicSSHKey]:/psPAS/Functions/Authentication/Add-PASPublicSSHKey.ps1
[Get-PASPublicSSHKey]:/psPAS/Functions/Authentication/Get-PASPublicSSHKey.ps1
[Remove-PASPublicSSHKey]:/psPAS/Functions/Authentication/Remove-PASPublicSSHKey.ps1
[Add-PASAccountACL]:/psPAS/Functions/AccountACL/Add-PASAccountACL.ps1
[Get-PASAccountACL]:/psPAS/Functions/AccountACL/Get-PASAccountACL.ps1
[Remove-PASAccountACL]:/psPAS/Functions/AccountACL/Remove-PASAccountACL.ps1
[Add-PASAccountGroupMember]:/psPAS/Functions/AccountGroups/Add-PASAccountGroupMember.ps1
[Get-PASAccountGroup]:/psPAS/Functions/AccountGroups/Get-PASAccountGroup.ps1
[Get-PASAccountGroupMember]:/psPAS/Functions/AccountGroups/Get-PASAccountGroupMember.ps1
[New-PASAccountGroup]:/psPAS/Functions/AccountGroups/New-PASAccountGroup.ps1
[Remove-PASAccountGroupMember]:/psPAS/Functions/AccountGroups/Remove-PASAccountGroupMember.ps1
[Add-PASAccount]:/psPAS/Functions/Accounts/Add-PASAccount.ps1
[Add-PASPendingAccount]:/psPAS/Functions/Accounts/Add-PASPendingAccount.ps1
[Get-PASAccount]:/psPAS/Functions/Accounts/Get-PASAccount.ps1
[Get-PASAccountActivity]:/psPAS/Functions/Accounts/Get-PASAccountActivity.ps1
[Get-PASAccountPassword]:/psPAS/Functions/Accounts/Get-PASAccountPassword.ps1
[Remove-PASAccount]:/psPAS/Functions/Accounts/Remove-PASAccount.ps1
[Set-PASAccount]:/psPAS/Functions/Accounts/Set-PASAccount.ps1
[Unlock-PASAccount]:/psPAS/Functions/Accounts/Unlock-PASAccount.ps1
[Add-PASApplication]:/psPAS/Functions/Applications/Add-PASApplication.ps1
[Add-PASApplicationAuthenticationMethod]:/psPAS/Functions/Applications/Add-PASApplicationAuthenticationMethod.ps1
[Get-PASApplication]:/psPAS/Functions/Applications/Get-PASApplication.ps1
[Get-PASApplicationAuthenticationMethod]:/psPAS/Functions/Applications/Get-PASApplicationAuthenticationMethod.ps1
[Remove-PASApplication]:/psPAS/Functions/Applications/Remove-PASApplication.ps1
[Remove-PASApplicationAuthenticationMethod]:/psPAS/Functions/Applications/Remove-PASApplicationAuthenticationMethod.ps1
[Import-PASConnectionComponent]:/psPAS/Functions/Connections/Import-PASConnectionComponent.ps1
[New-PASPSMSession]:/psPAS/Functions/Connections/New-PASPSMSession.ps1
[Get-PASPSMRecording]:/psPAS/Functions/Monitoring/Get-PASPSMRecording.ps1
[Get-PASPSMSession]:/psPAS/Functions/Monitoring/Get-PASPSMSession.ps1
[Resume-PASPSMSession]:/psPAS/Functions/Monitoring/Resume-PASPSMSession.ps1
[Stop-PASPSMSession]:/psPAS/Functions/Monitoring/Stop-PASPSMSession.ps1
[Suspend-PASPSMSession]:/psPAS/Functions/Monitoring/Suspend-PASPSMSession.ps1
[Get-PASOnboardingRule]:/psPAS/Functions/OnboardingRules/Get-PASOnboardingRule.ps1
[New-PASOnboardingRule]:/psPAS/Functions/OnboardingRules/New-PASOnboardingRule.ps1
[Remove-PASOnboardingRule]:/psPAS/Functions/OnboardingRules/Remove-PASOnboardingRule.ps1
[Get-PASPlatform]:/psPAS/Functions/Platforms/Get-PASPlatform.ps1
[Import-PASPlatform]:/psPAS/Functions/Platforms/Import-PASPlatform.ps1
[Export-PASPlatform]:/psPAS/Functions/Platforms/Export-PASPlatform.ps1
[Add-PASPolicyACL]:/psPAS/Functions/PolicyACL/Add-PASPolicyACL.ps1
[Get-PASPolicyACL]:/psPAS/Functions/PolicyACL/Get-PASPolicyACL.ps1
[Remove-PASPolicyACL]:/psPAS/Functions/PolicyACL/Remove-PASPolicyACL.ps1
[Approve-PASRequest]:/psPAS/Functions/Requests/Approve-PASRequest.ps1
[Deny-PASRequest]:/psPAS/Functions/Requests/Deny-PASRequest.ps1
[Get-PASRequest]:/psPAS/Functions/Requests/Get-PASRequest.ps1
[Get-PASRequestDetail]:/psPAS/Functions/Requests/Get-PASRequestDetail.ps1
[New-PASRequest]:/psPAS/Functions/Requests/New-PASRequest.ps1
[Remove-PASRequest]:/psPAS/Functions/Requests/Remove-PASRequest.ps1
[Add-PASSafeMember]:/psPAS/Functions/SafeMembers/Add-PASSafeMember.ps1
[Get-PASSafeMember]:/psPAS/Functions/SafeMembers/Get-PASSafeMember.ps1
[Remove-PASSafeMember]:/psPAS/Functions/SafeMembers/Remove-PASSafeMember.ps1
[Set-PASSafeMember]:/psPAS/Functions/SafeMembers/Set-PASSafeMember.ps1
[Add-PASSafe]:/psPAS/Functions/Safes/Add-PASSafe.ps1
[Get-PASSafe]:/psPAS/Functions/Safes/Get-PASSafe.ps1
[Remove-PASSafe]:/psPAS/Functions/Safes/Remove-PASSafe.ps1
[Set-PASSafe]:/psPAS/Functions/Safes/Set-PASSafe.ps1
[Get-PASSafeShareLogo]:/psPAS/Functions/ServerWebServices/Get-PASSafeShareLogo.ps1
[Get-PASServer]:/psPAS/Functions/ServerWebServices/Get-PASServer.ps1
[Get-PASServerWebService]:/psPAS/Functions/ServerWebServices/Get-PASServerWebService.ps1
[Get-PASComponentDetail]:/psPAS/Functions/SystemHealth/Get-PASComponentDetail.ps1
[Get-PASComponentSummary]:/psPAS/Functions/SystemHealth/Get-PASComponentSummary.ps1
[Add-PASGroupMember]:/psPAS/Functions/User/Add-PASGroupMember.ps1
[Get-PASLoggedOnUser]:/psPAS/Functions/User/Get-PASLoggedOnUser.ps1
[Get-PASUserLoginInfo]:/psPAS/Functions/User/Get-PASUserLoginInfo.ps1
[Get-PASUser]:/psPAS/Functions/User/Get-PASUser.ps1
[New-PASUser]:/psPAS/Functions/User/New-PASUser.ps1
[Remove-PASUser]:/psPAS/Functions/User/Remove-PASUser.ps1
[Set-PASUser]:/psPAS/Functions/User/Set-PASUser.ps1
[Unblock-PASUser]:/psPAS/Functions/User/Unblock-PASUser.ps1
[Get-PASDirectory]:/psPAS/Functions/LDAPDirectories/Get-PASDirectory.ps1
[Add-PASDirectory]:/psPAS/Functions/LDAPDirectories/Add-PASDirectory.ps1
[New-PASDirectoryMapping]:/psPAS/Functions/LDAPDirectories/New-PASDirectoryMapping.ps1
[Add-PASPTARule]:/psPAS/Functions/EventSecurity/Add-PASPTARule.ps1
[Get-PASPTAEvent]:/psPAS/Functions/EventSecurity/Get-PASPTAEvent.ps1
[Set-PASPTAEvent]:/psPAS/Functions/EventSecurity/Set-PASPTAEvent.ps1
[Get-PASPTARemediation]:/psPAS/Functions/EventSecurity/Get-PASPTARemediation.ps1
[Get-PASPTARule]:/psPAS/Functions/EventSecurity/Get-PASPTARule.ps1
[Set-PASPTARemediation]:/psPAS/Functions/EventSecurity/Set-PASPTARemediation.ps1
[Set-PASPTARule]:/psPAS/Functions/EventSecurity/Set-PASPTARule.ps1
[Get-PASGroup]:/psPAS/Functions/User/Get-PASGroup.ps1
[Remove-PASGroupMember]:/psPAS/Functions/User/Remove-PASGroupMember.ps1
[Set-PASOnboardingRule]:/psPAS/Functions/OnboardingRules/Set-PASOnboardingRule.ps1
[Add-PASDiscoveredAccount]:/psPAS/Functions/Accounts/Add-PASDiscoveredAccount.ps1
[Connect-PASPSMSession]:/psPAS/Functions/Monitoring/Connect-PASPSMSession.ps1
[Get-PASPSMSessionActivity]:/psPAS/Functions/Monitoring/Get-PASPSMSessionActivity.ps1
[Get-PASPSMSessionProperty]:/psPAS/Functions/Monitoring/Get-PASPSMSessionProperty.ps1
[Get-PASPSMRecordingActivity]:/psPAS/Functions/Monitoring/Get-PASPSMRecordingActivity.ps1
[Get-PASPSMRecordingProperty]:/psPAS/Functions/Monitoring/Get-PASPSMRecordingProperty.ps1
[Export-PASPSMRecording]:/psPAS/Functions/Monitoring/Export-PASPSMRecording.ps1
[Request-PASAdHocAccess]:/psPAS/Functions/Accounts/Request-PASAdHocAccess.ps1
[Get-PASDirectoryMapping]:/psPAS/Functions/LDAPDirectories/Get-PASDirectoryMapping.ps1
[Set-PASDirectoryMapping]:/psPAS/Functions/LDAPDirectories/Set-PASDirectoryMapping.ps1
[Remove-PASDirectory]:/psPAS/Functions/LDAPDirectories/Remove-PASDirectory.ps1
[Find-PASSafe]:/psPAS/Functions/Safes/Find-PASSafe.ps1
[Invoke-PASCPMOperation]:/psPAS/Functions/Accounts/Invoke-PASCPMOperation.ps1
[Set-PASDirectoryMappingOrder]:/psPAS/Functions/LDAPDirectories/Set-PASDirectoryMappingOrder.ps1
[Set-PASUserPassword]:/psPAS/Functions/User/Set-PASUserPassword.ps1
[Disable-PASCPMAutoManagement]:/psPAS/Functions/Accounts/Disable-PASCPMAutoManagement.ps1
[Enable-PASCPMAutoManagement]:/psPAS/Functions/Accounts/Enable-PASCPMAutoManagement.ps1
[Remove-PASDirectoryMapping]:/psPAS/Functions/LDAPDirectories/Remove-PASDirectoryMapping.ps1
[Get-PASPlatformSafe]:/psPAS/Functions/Platforms/Get-PASPlatformSafe.ps1
[New-PASGroup]:/psPAS/Functions/User/New-PASGroup.ps1
[Test-PASPSMRecording]:/psPAS/Functions/Monitoring/Test-PASPSMRecording.ps1
[Copy-PASPlatform]:psPAS/Functions/Platforms/Copy-PASPlatform.ps1
[Disable-PASPlatform]:psPAS/Functions/Platforms/Disable-PASPlatform.ps1
[Enable-PASPlatform]:psPAS/Functions/Platforms/Enable-PASPlatform.ps1
[Remove-PASPlatform]:psPAS/Functions/Platforms/Remove-PASPlatform.ps1
[Remove-PASGroup]:psPAS/Functions/User/Remove-PASGroup.ps1
[Clear-PASDiscoveredAccountList]:/psPAS/Functions/Accounts/Clear-PASDiscoveredAccountList
[Get-PASAccountPasswordVersion]:/psPAS/Functions/Accounts/Get-PASAccountPasswordVersion
[New-PASAccountPassword]:/psPAS/Functions/Accounts/New-PASAccountPassword
[Set-PASLinkedAccount]:/psPAS/Functions/Accounts/Set-PASLinkedAccount
[Clear-PASPrivateSSHKey]:/psPAS/Functions/Authentication/Clear-PASPrivateSSHKey
[New-PASPrivateSSHKey]:/psPAS/Functions/Authentication/New-PASPrivateSSHKey
[Remove-PASPrivateSSHKey]:/psPAS/Functions/Authentication/Remove-PASPrivateSSHKey
[Set-PASGroup]:/psPAS/Functions/User/Set-PASGroup
</details>

## Installation

![Logo][Logo]

### Prerequisites

- Powershell v5 (minimum), or PowerShell Core
- CyberArk PAS REST API/Web Service
- A user with which to authenticate, with appropriate Vault/Safe permissions.

### Install Options

Use one of the following methods:

#### Option 1: Install from PowerShell Gallery

**PowerShell 5.0 or above must be used**

This is the simplest & preferred method for installation of the module.

To install the module from the [PowerShell Gallery](https://www.powershellgallery.com/packages/psPAS/), </br>
from a PowerShell prompt, run:

`Install-Module -Name psPAS -Scope CurrentUser`

#### Option 2: Manual Install

You can manually copy the module files to one of your powershell module folders.

Find your PowerShell Module Paths with the following command:

`$env:PSModulePath.split(';')`

The module files should be placed in a folder named `psPAS` in one of the listed locations.

More: [about_PSModulePath](https://docs.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_psmodulepath)

There are multiple options for downloading the module files:

##### PowerShell Gallery

- Download from the module [PowerShell Gallery](https://www.powershellgallery.com/packages/psPAS/):
  - Run the PowerShell command `Save-Module -Name psPAS -Path C:\temp`
  - Copy the `C:\temp\psPAS` folder to your "Powershell Modules" directory of choice.

##### psPAS Release

- [Download the latest release](https://github.com/pspete/psPAS/releases/latest)
  - Unblock & Extract the archive
  - Rename the extracted `psPAS-v#.#.#` folder to `psPAS`
  - Copy the `psPAS` folder to your "Powershell Modules" directory of choice.

##### psPAS Branch

- [Download the ```master branch```](https://github.com/pspete/psPAS/archive/master.zip)
  - Unblock & Extract the archive
  - Copy the `psPAS` (`\<Archive Root>\psPAS-master\psPAS`) folder to your "Powershell Modules" directory of choice.

#### Verification

Validate Install:

```powershell

Get-Module -ListAvailable psPAS

```

Import the module:

```powershell

Import-Module psPAS

```

List Module Commands:

```powershell

Get-Command -Module psPAS

```

Get detailed information on specific commands:

```powershell

Get-Help New-PASUser -Full

```

![Logo][Logo]

## Sponsorship

Please support continued psPAS development; consider sponsoring <a href="https://github.com/sponsors/pspete"> @pspete on GitHub Sponsors</a>

## Changelog

All notable changes to this project will be documented in the [Changelog](CHANGELOG.md)

## Author

- **Pete Maan** - [pspete](https://github.com/pspete)

## License

This project is [licensed under the MIT License](LICENSE.md).

## Contributing

Any and all contributions to this project are appreciated.

See the [CONTRIBUTING.md](CONTRIBUTING.md) for a few more details.

## Acknowledgements

Hat Tips:

**Assaf Miron**
([AssafMiron](https://github.com/AssafMiron))
For the JSON formatting assistance.

**Warren Frame**
([RamblingCookieMonster](https://github.com/RamblingCookieMonster)) for [Add-ObjectDetail.ps1](https://github.com/RamblingCookieMonster/PowerShell/blob/master/Add-ObjectDetail.ps1).

**Joe Garcia** ([infamousjoeg](https://github.com/infamousjoeg))
for the unofficial API documentation.

Chapeau!

![Logo][Logo]
