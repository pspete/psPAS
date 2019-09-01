---
title: "Safe Permissions"
permalink: /docs/safe-permissions/
excerpt: "psPAS Safe Permissions"
last_modified_at: 2019-09-01T01:33:52-00:00
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
  RequestsAuthorizationLevel             = $false
  AccessWithoutConfirmation              = $true
  CreateFolders                          = $true
  DeleteFolders                          = $true
  MoveAccountsAndFolders                 = $true
}

$Role1 | Add-PASSafeMember -SafeName NewSafe -MemberName User23 -SearchIn Vault

MemberName SearchIn SafeName Permissions
---------- -------- -------- -----------
User23     Vault    NewSafe  {UseAccounts, RetrieveAccounts, ListAccounts}

$Role2 | Add-PASSafeMember -SafeName NewSafe -MemberName SafeAdmin1 -SearchIn Vault

MemberName SearchIn SafeName Permissions
---------- -------- -------- -----------
SafeAdmin1 Vault    NewSafe  {ListAccounts, AddAccounts, UpdateAccountContent, UpdateAccountProperties…}
````
