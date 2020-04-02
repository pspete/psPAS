---
title: Get-PASSafeMember
---

## SYNOPSIS

Lists the members of a Safe

## SYNTAX

    Get-PASSafeMember -SafeName <String> [-MemberName <String>] [<CommonParameters>]

## DESCRIPTION

Lists the members of a Safe.
View Safe Members permission is required.

When querying all members of a safe, the permissions are reported as per the following table:

| Permission                                  | API Data            |
|---------------------------------------------|---------------------|
| List accounts                               | ListContent         |
| Retrieve accounts                           | Retrieve            |
| Add accounts (includes update properties)   | Add                 |
| Update account content                      | Update              |
| Update account properties                   | UpdateMetadata      |
| Rename accounts                             | Rename              |
| Delete accounts                             | Delete              |
| View Audit log                              | ViewAudit           |
| View Safe Members                           | ViewMembers         |
| Use accounts                                | RestrictedRetrieve  |
| Initiate CPM account management operations  | *Not Returned*      |
| Specify next account content                | *Not Returned*      |
| Create folders                              | AddRenameFolder     |
| Delete folders                              | DeleteFolder        |
| Unlock accounts                             | Unlock              |
| Move accounts/folders                       | MoveFilesAndFolders |
| Manage Safe                                 | ManageSafe          |
| Manage Safe Members                         | ManageSafeMembers   |
| Validate Safe Content                       | ValidateSafeContent |
| Backup Safe                                 | BackupSafe          |
| Access Safe without confirmation            | *Not Returned*      |
| Authorize account requests (level1, level2) | *Not Returned*      |

If a Safe Member Name is provided, the full permissions of the member on the Safe will be returned:

| Permission                                  | API Data                               |
|---------------------------------------------|----------------------------------------|
| List accounts                               | ListAccounts                           |
| Retrieve accounts                           | RetrieveAccounts                       |
| Add accounts (includes update properties)   | AddAccounts                            |
| Update account content                      | UpdateAccountContent                   |
| Update account properties                   | UpdateAccountProperties                |
| Rename accounts                             | RenameAccounts                         |
| Delete accounts                             | DeleteAccounts                         |
| View Audit log                              | ViewAuditLog                           |
| View Safe Members                           | ViewSafeMembers                        |
| Use accounts                                | UseAccounts                            |
| Initiate CPM account management operations  | InitiateCPMAccountManagementOperations |
| Specify next account content                | SpecifyNextAccountContent              |
| Create folders                              | CreateFolders                          |
| Delete folders                              | DeleteFolder                           |
| Unlock accounts                             | UnlockAccounts                         |
| Move accounts/folders                       | MoveAccountsAndFolders                 |
| Manage Safe                                 | ManageSafe                             |
| Manage Safe Members                         | ManageSafeMembers                      |
| Validate Safe Content                       | *Not Returned*                         |
| Backup Safe                                 | BackupSafe                             |
| Access Safe without confirmation            | AccessWithoutConfirmation              |
| Authorize account requests (level1, level2) | RequestsAuthorizationLevel             |

## PARAMETERS

    -SafeName <String>
        The name of the safe to get the members of

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -MemberName <String>
        Specify the name of a safe member to return their safe permissions in full.
        An empty PUT request (update) is sent to retrieve full safe permissions for a user, as such:
        - You cannot report on the permissions of the user authenticated to the API.
        - Reporting on the permissions of the Quota Owner is expected to fail.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>Get-PASSafeMember -SafeName Target_Safe

    Lists all members with permissions on Target_Safe




    -------------------------- EXAMPLE 2 --------------------------

    PS C:\>Get-PASSafeMember -SafeName Target_Safe -MemberName SomeUser

    Lists all permissions for member SomeUser on Target_Safe
