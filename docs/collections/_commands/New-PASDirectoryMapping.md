---
title: New-PASDirectoryMapping
---

## SYNOPSIS

Adds a new Directory Mapping for an existing directory

## SYNTAX

    New-PASDirectoryMapping -DirectoryName <String> -MappingName <String> -LDAPBranch <String>
    -DomainGroups <String[]> [-VaultGroups <String[]>] [-Location <String>] [-LDAPQuery <String>]
    [-AddUpdateUsers] [-AddSafes] [-AddNetworkAreas] [-ManageServerFileCategories] [-AuditUsers]
    [-BackupAllSafes] [-RestoreAllSafes] [-ResetUsersPasswords] [-ActivateUsers]
    [-UserActivityLogPeriod <Int32>]

    New-PASDirectoryMapping -DirectoryName <String> -MappingName <String> -LDAPBranch <String>
    -DomainGroups <String[]> [-VaultGroups <String[]>] [-Location <String>] [-LDAPQuery <String>]
    [-MappingAuthorizations <Int32[]>] [-UserActivityLogPeriod <Int32>]

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
        Users who belong to these LDAP groups will be automatically assigned to the relevant roles
        in the PAS system.

        Required?                    true
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
        The integer flag representation of the security attributes and authorizations that will be
        applied when an LDAP User Account is created in the Vault.
        To apply specific authorizations to a mapping, the user must have the same authorizations.
        Possible authorizations: AddSafes, AuditUsers, AddUpdateUsers, ResetUsersPasswords,
        ActivateUsers, AddNetworkAreas, ManageServerFileCategories, BackupAllSafes, RestoreAllSafes.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
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
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).## EXAMPLES

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>New-PASDirectoryMapping -DirectoryName "domain.com" -LDAPBranch "DC=DOMAIN,DC=COM"
    -DomainGroups ADGroup -MappingName Map3 -RestoreAllSafes -BackupAllSafes

    Creates a new  LDAP directory mapping in the Vault with the following authorizations:
    BackupAllSafes, RestoreAllSafes




    -------------------------- EXAMPLE 2 --------------------------

    PS C:\>New-PASDirectoryMapping -DirectoryName "domain.com" -LDAPBranch "DC=DOMAIN,DC=COM"
    -DomainGroups ADGroup -MappingName Map2 -MappingAuthorizations 1536

    Creates a new  LDAP directory mapping in the Vault with the following authorizations:
    BackupAllSafes, RestoreAllSafes




    -------------------------- EXAMPLE 3 --------------------------

    PS C:\>New-PASDirectoryMapping -DirectoryName "domain.com" -LDAPBranch "DC=DOMAIN,DC=COM"
    -DomainGroups ADGroup -MappingName Map1 -MappingAuthorizations 1,3,512

    Creates a new  LDAP directory mapping in the Vault with the following authorizations:
    AddUpdateUsers, AddSafes, BackupAllSafes
