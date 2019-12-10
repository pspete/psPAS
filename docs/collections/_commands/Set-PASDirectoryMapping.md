---
title: Set-PASDirectoryMapping
---

## SYNOPSIS

    Adds a new Directory Mapping for an existing directory

## SYNTAX

    Set-PASDirectoryMapping -DirectoryName <String> -MappingID <String> -MappingName <String> -LDAPBranch <String> [-DomainGroups <String[]>] [-VaultGroups
    <String[]>] [-Location <String>] [-LDAPQuery <String>] [-MappingAuthorizations <Int32[]>] [-UserActivityLogPeriod <Int32>] [-WhatIf] [-Confirm]
    [<CommonParameters>]

    Set-PASDirectoryMapping -DirectoryName <String> -MappingID <String> -MappingName <String> -LDAPBranch <String> [-DomainGroups <String[]>] [-VaultGroups
    <String[]>] [-Location <String>] [-LDAPQuery <String>] [-AddUpdateUsers] [-AddSafes] [-AddNetworkAreas] [-ManageServerFileCategories] [-AuditUsers]
    [-BackupAllSafes] [-RestoreAllSafes] [-ResetUsersPasswords] [-ActivateUsers] [-UserActivityLogPeriod <Int32>] [-WhatIf] [-Confirm] [<CommonParameters>]

## DESCRIPTION

    Adds an LDAP directory to the Vault.
    Membership of the Vault Admins group required.

## PARAMETERS

    -DirectoryName <String>
        The name of the directory the mapping is for.

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -MappingID <String>
        The ID of the Directory Mapping to Update

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -MappingName <String>
        The name of the PAS role that will be created.

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -LDAPBranch <String>
        The LDAP branch that will be used for external directory queries

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -DomainGroups <String[]>
        Users who belong to these LDAP groups will be automatically assigned to the relevant roles in the PAS system.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -VaultGroups <String[]>
        A list of Vault groups that a mapped user will be added to.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -Location <String>
        The path of the Vault location that mapped users are added under.
        This value cannot be updated.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -LDAPQuery <String>
        Match LDAP query results to mapping

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -MappingAuthorizations <Int32[]>
        The integer flag representation of the security attributes and authorizations that will be applied when an
        LDAP User Account is created in the Vault.
        To apply specific authorizations to a mapping, the user must have the same authorizations.
        Possible authorizations: AddSafes, AuditUsers, AddUpdateUsers, ResetUsersPasswords, ActivateUsers, AddNetworkAreas,
        ManageServerFileCategories, BackupAllSafes, RestoreAllSafes.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       false
        Accept wildcard characters?  false

    -AddUpdateUsers [<SwitchParameter>]
        Specify switch to add the AddUpdateUsers authorization to the directory mapping

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -AddSafes [<SwitchParameter>]
        Specify switch to add the AddSafes authorization to the directory mapping

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -AddNetworkAreas [<SwitchParameter>]
        Specify switch to add the AddNetworkAreas authorization to the directory mapping

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -ManageServerFileCategories [<SwitchParameter>]
        Specify switch to add the ManageServerFileCategories authorization to the directory mapping

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -AuditUsers [<SwitchParameter>]
        Specify switch to add the AuditUsers authorization to the directory mapping

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -BackupAllSafes [<SwitchParameter>]
        Specify switch to add the BackupAllSafes authorization to the directory mapping

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -RestoreAllSafes [<SwitchParameter>]
        Specify switch to add the RestoreAllSafes authorization to the directory mapping

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -ResetUsersPasswords [<SwitchParameter>]
        Specify switch to add the ResetUsersPasswords authorization to the directory mapping

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -ActivateUsers [<SwitchParameter>]
        Specify switch to add the ActivateUsers authorization to the directory mapping

        Required?                    false
        Position?                    named
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -UserActivityLogPeriod <Int32>
        Retention period in days for user activity logs
        Requires CyberArk version 10.10+

        Required?                    false
        Position?                    named
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

    Set-PASDirectoryMapping -DirectoryName $Directory -AddUpdateUsers -AuditUsers

    Configures the AddUpdateUsers & AuditUsers authorisations on the mapping.


    -------------------------- EXAMPLE 2 --------------------------

    PS C:\>Set-PASDirectoryMapping -DirectoryName $DirectoryName -MappingID $MappingID -MappingName $MappingName -LDAPBranch $LDAPBranch -AddUpdateUsers -ActivateUsers -ResetUsersPasswords

    Sets AddUpdateUsers, ActivateUsers & ResetUsersPasswords authorisations on the directory mapping


    -------------------------- EXAMPLE 3 --------------------------

    PS C:\>Set-PASDirectoryMapping -DirectoryName $DirectoryName -MappingID $MappingID -MappingName $MappingName -LDAPBranch $LDAPBranch -UserActivityLogPeriod 365

    Sets UserActivityLogPeriod for the mapping to 365
