---
title: "Update Accounts"
permalink: /docs/update-accounts/
excerpt: "psPAS Update Accounts"
last_modified_at: 2019-09-01T01:33:52-00:00
---

## Updating Multiple Properties of an Account

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
