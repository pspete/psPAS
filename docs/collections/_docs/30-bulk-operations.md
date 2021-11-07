---
title: "Bulk Operations"
permalink: /docs/bulk-operations/
excerpt: "psPAS Bulk Operations"
last_modified_at: 2021-04-10T01:33:52-00:00
---

The standard features of PowerShell which allow creation of and iterations through collections of objects, can be used to perform bulk operations:

## On-board Multiple Accounts

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

## Delete Multiple Safes

````powershell
#Specify Vault Logon Credentials
$LogonCredential = Get-Credential

#Logon
New-PASSession -Credential $LogonCredential -BaseURI https://your.pvwa.url

$Safes = Get-PASSafe -search TestSafe

#Delete Safes
foreach ($Safe in $Safes){

  Remove-PASSafe -SafeName $Safe.SafeName -WhatIf

}

#Logoff
Close-PASSession
````

## Move a List of Users to a New Location

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