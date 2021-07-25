---
title: "Safe Permissions"
permalink: /docs/safe-permissions/
excerpt: "psPAS Safe Permissions"
last_modified_at: 2021-07-25T01:33:52-00:00
---

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
  requestsAuthorizationLevel1            = $false
  requestsAuthorizationLevel2            = $false
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
