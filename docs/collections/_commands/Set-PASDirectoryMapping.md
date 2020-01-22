---
title: Set-PASDirectoryMapping
---

## SYNOPSIS

    Updates an existing Directory Mapping for a directory

## SYNTAX

    Set-PASDirectoryMapping [-DirectoryName] <String> [-MappingID] <String> [-MappingName] <String> [-LDAPBranch] <String> [[-DomainGroups] <String[]>] [[-VaultGroups] <String[]>] [[-Location] <String>]
    [[-LDAPQuery] <String>] [[-MappingAuthorizations] {AddUpdateUsers | AddSafes | AddNetworkAreas | ManageServerFileCategories | AuditUsers | BackupAllSafes | RestoreAllSafes | ResetUsersPasswords |
    ActivateUsers}] [[-UserActivityLogPeriod] <Int32>] [-WhatIf] [-Confirm] [<CommonParameters>]

## DESCRIPTION

    Updates a  directory mapping.
    Membership of the Vault Admins group required.

## PARAMETERS

    -DirectoryName <String>
        The name of the directory the mapping is for.

        Required?                    true
        Position?                    1
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -MappingID <String>
        The ID of the Directory Mapping to Update

        Required?                    true
        Position?                    2
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -MappingName <String>
        The name of the PAS role that will be created.

        Required?                    true
        Position?                    3
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -LDAPBranch <String>
        The LDAP branch that will be used for external directory queries

        Required?                    true
        Position?                    4
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -DomainGroups <String[]>
        Users who belong to these LDAP groups will be automatically assigned to the relevant roles in the PAS system.

        Required?                    false
        Position?                    5
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -VaultGroups <String[]>
        A list of Vault groups that a mapped user will be added to.

        Required?                    false
        Position?                    6
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -Location <String>
        The path of the Vault location that mapped users are added under.
        This value cannot be updated.

        Required?                    false
        Position?                    7
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -LDAPQuery <String>
        Match LDAP query results to mapping

        Required?                    false
        Position?                    8
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -MappingAuthorizations
        Specify authorizations that will be applied when an LDAP User Account is created in the Vault.
        To apply specific authorizations to a mapping, the user must have the same authorizations.
        Possible authorizations: AddSafes, AuditUsers, AddUpdateUsers, ResetUsersPasswords, ActivateUsers,
        AddNetworkAreas, ManageServerFileCategories, BackupAllSafes, RestoreAllSafes.

        Required?                    false
        Position?                    9
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -UserActivityLogPeriod <Int32>
        Retention period in days for user activity logs
        Requires CyberArk version 10.10+

        Required?                    false
        Position?                    10
        Default value                0
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -WhatIf [<SwitchParameter>]

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -Confirm [<SwitchParameter>]

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>Get-PASDirectoryMapping -DirectoryName $Directory -MappingID $ID |

    Set-PASDirectoryMapping -DirectoryName $Directory -MappingAuthorizations AddUpdateUsers, AuditUsers

    Configures the AddUpdateUsers & AuditUsers authorisations on the mapping.


    -------------------------- EXAMPLE 2 --------------------------

    PS C:\>Set-PASDirectoryMapping -DirectoryName $DirectoryName -MappingID $MappingID -MappingName $MappingName -LDAPBranch $LDAPBranch `

    -MappingAuthorizations AddUpdateUsers, ActivateUsers & ResetUsersPasswords

    Sets AddUpdateUsers, ActivateUsers & ResetUsersPasswords authorisations on the directory mapping


    -------------------------- EXAMPLE 3 --------------------------

    PS C:\>Set-PASDirectoryMapping -DirectoryName $DirectoryName -MappingID $MappingID -MappingName $MappingName -LDAPBranch $LDAPBranch `

    -UserActivityLogPeriod 365

    Sets UserActivityLogPeriod for the mapping to 365
