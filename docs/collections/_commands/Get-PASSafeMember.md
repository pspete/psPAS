---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASSafeMember
schema: 2.0.0
title: Get-PASSafeMember
---

# Get-PASSafeMember

## SYNOPSIS
Lists the members of a Safe

## SYNTAX

### SafePermissions (Default)
```
Get-PASSafeMember -SafeName <String> [<CommonParameters>]
```

### MemberPermissions
```
Get-PASSafeMember -SafeName <String> -MemberName <String> [<CommonParameters>]
```

## DESCRIPTION
Lists the members of a Safe.

View Safe Members permission is required.

When querying all members of a safe, the permissions are reported as per the following table:
Permission                                 |Property Name|
|:-----------------------------------------|:------------|
List accounts							   |  ListContent
Retrieve accounts						   |  Retrieve
Add accounts (includes update properties)  |  Add
Update account content					   |  Update
Update account properties				   |  UpdateMetadata
Rename accounts							   |  Rename
Delete accounts							   |  Delete
View Audit log							   |  ViewAudit
View Safe Members					       |  ViewMembers
Use accounts							   |  RestrictedRetrieve
Initiate CPM account management operations |  \<NOT RETURNED\>
Specify next account content			   |  \<NOT RETURNED\>
Create folders							   |  AddRenameFolder
Delete folders							   |  DeleteFolder
Unlock accounts							   |  Unlock
Move accounts/folders					   |  MoveFilesAndFolders
Manage Safe								   |  ManageSafe
Manage Safe Members						   |  ManageSafeMembers
Validate Safe Content					   |  ValidateSafeContent
Backup Safe								   |  BackupSafe
Access Safe without confirmation		   |  \<NOT RETURNED\>
Authorize account requests (level1, level2)|  \<NOT RETURNED\>

If a Safe Member Name is provided, the full permissions of the member on the Safe will be returned:

Permission                                  |Property Name|
|:------------------------------------------|:------------|
List accounts							    |ListAccounts
Retrieve accounts							|RetrieveAccounts
Add accounts (includes update properties)	|AddAccounts
Update account content						|UpdateAccountContent
Update account properties					|UpdateAccountProperties
Rename accounts							    |RenameAccounts
Delete accounts							    |DeleteAccounts
View Audit log							    |ViewAuditLog
View Safe Members							|ViewSafeMembers
Use accounts							    |UseAccounts
Initiate CPM account management operations	|InitiateCPMAccountManagementOperations
Specify next account content				|SpecifyNextAccountContent
Create folders							    |CreateFolders
Delete folders							    |DeleteFolder
Unlock accounts							    |UnlockAccounts
Move accounts/folders						|MoveAccountsAndFolders
Manage Safe								    |ManageSafe
Manage Safe Members							|ManageSafeMembers
Validate Safe Content						|\<NOT RETURNED\>
Backup Safe								    |BackupSafe
Access Safe without confirmation			|AccessWithoutConfirmation
Authorize account requests (level1, level2)	|RequestsAuthorizationLevel

## EXAMPLES

### EXAMPLE 1
```
Get-PASSafeMember -SafeName Target_Safe
```

Lists all members with permissions on Target_Safe

### EXAMPLE 2
```
Get-PASSafeMember -SafeName Target_Safe -MemberName SomeUser
```

Lists all permissions for member SomeUser on Target_Safe

## PARAMETERS

### -SafeName
The name of the safe to get the members of

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -MemberName
Specify the name of a safe member to return their safe permissions in full.

An empty PUT request (update) is sent to retrieve full safe permissions for a user, as such:
- You cannot report on the permissions of the user authenticated to the API.
- Reporting on the permissions of the Quota Owner is expected to fail.

```yaml
Type: String
Parameter Sets: MemberPermissions
Aliases: UserName

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASSafeMember](https://pspas.pspete.dev/commands/Get-PASSafeMember)

