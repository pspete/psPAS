---
title: "Administration"
permalink: /docs/administration/
excerpt: "psPAS Administration"
last_modified_at: 2021-04-10T01:33:52-00:00
---

## Add An Account

- Add an account to manage:

````powershell
#Convert Password to SecureString
$Password = ConvertTo-SecureString -String "Secret1337$" -AsPlainText -Force

#Additional account details
$platformAccountProperties = @{
	"LOGONDOMAIN"    = "domain.com"
	"Notes"          = "Demo Account. Owner:psPete"
	"Classification" = "1F"
}

#Add Account
Add-PASAccount -secretType Password -secret $Password -SafeName "YourSafe" -PlatformID "YourPlatform" `
	-Address "domain" -Username SomeUsername -platformAccountProperties $platformAccountProperties
````

## Create Safes

- Simple safe creation:

````powershell
Add-PASSafe -SafeName NewSafe -Description "New Safe" -ManagingCPM PasswordManager -NumberOfVersionsRetention 10

SafeName ManagingCPM     NumberOfDaysRetention NumberOfVersionsRetention Description
-------- ---------- - -------------------- - ------------------------ - ---------- -
NewSafe  PasswordManager                       10                        New Safe
````

## Add Safe Members

- Consistent safe membership:

````powershell
Add-PASSafeMember -SafeName NewSafe -MemberName NewMember -UseAccounts $false -ListAccounts $true `
	-RetrieveAccounts $false -ViewAuditLog $true -ViewSafeMembers $true

UserName  SafeName Permissions
--------  -------- -----------
NewMember NewSafe  @{useAccounts=False; retrieveAccounts=False; listAccounts=True; addAccounts=False;...
````

## Update Accounts

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
platformAccountProperties : @{LogonDomain = SOMEDOMAIN }
secretManagement          : @{automaticManagementEnabled = True; lastModifiedTime = 1559864222 }
createdTime               : 06/06/2019 23:37:02

Set-PASAccount -AccountID 286_4 -op replace -path /platformAccountProperties/LogonDomain -value NEWDOMAIN

AccountID                 : 286_4
Safe                      : 3_TestSafe_028_XYJ
address                   : NEWDOMAIN.COM
userName                  : sbwudlov
name                      : Operating System-Z_WINDOMAIN_OFF-SOMEDOMAIN.COM-sbwudlov
platformId                : Z_WINDOMAIN_OFF
secretType                : password
platformAccountProperties : @{LogonDomain = NEWDOMAIN }
secretManagement          : @{automaticManagementEnabled = True; lastModifiedTime = 1559864222 }
createdTime               : 06/06/2019 23:37:02
````

## Import a Connection Component

- Import Custom Connection Components:

````powershell
Import-PASConnectionComponent -ImportFile C:\Temp\ConnectionComponent.zip
````

## Import & Export Platforms

- Import & Export of CPM Platforms:

````powershell
#Import a Platform
Import-PASPlatform -ImportFile C:\Temp\Platform.zip

#Export a Platform
Export-PASPlatform -PlatformID "Some-SSH-Platform" -Path C:\Temp
````
