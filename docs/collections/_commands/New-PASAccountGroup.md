---
title: New-PASAccountGroup
---

## SYNOPSIS

Adds a new account group to the Vault

## SYNTAX

    New-PASAccountGroup [-GroupName] <String> [-GroupPlatformID] <String> [-Safe] <String>
    [-WhatIf] [-Confirm] [<CommonParameters>]

## DESCRIPTION

Defines a new account group in the vault.

The following permissions are required on the safe where the account group will be created:

- Add Accounts
- Update Account Content
- Update Account Properties
- Create Folders

## PARAMETERS

    -GroupName <String>
        The name of the group to create

        Required?                    true
        Position?                    1
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -GroupPlatformID <String>
        The name of the platform for the group.
        The associated platform must be set to "PolicyType=Group"

        Required?                    true
        Position?                    2
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -Safe <String>
        The Safe where the group will be created

        Required?                    true
        Position?                    3
        Default value
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

    PS C:\>New-PASAccountGroup -GroupName UATGroup -GroupPlatform UnixGroup-NonProd -Safe UAT-Team

    Creates new account group named UATGroup and assigns to platform in the UAT-Team Safe.
