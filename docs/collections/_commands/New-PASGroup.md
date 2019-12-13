---
title: New-PASGroup
---

## SYNOPSIS

Creates a vault group.

## SYNTAX

    New-PASGroup [-groupName] <String> [[-description] <String>] [[-location] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]

## DESCRIPTION

Adds a new Vault group.

Requires the following permissions:

- Add Users
- Update Users

## PARAMETERS

    -groupName <String>
        The name of the group to create

        Required?                    true
        Position?                    1
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -description <String>
        A description for the group

        Required?                    false
        Position?                    2
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -location <String>
        The vault location to create the group in.
        Preceeded by "\"

        Required?                    false
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

## NOTES

        Minimum Version 11.1

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>New-PASGroup -groupName SomeNewGroup -description "Some Description" -location \PSP\CyberArk\Groups

    Creates SomeNewGroup in the \PSP\CyberArk\Groups vault location




    -------------------------- EXAMPLE 2 --------------------------

    PS C:\>New-PASGroup -groupName VaultGroup -description "Some Description" -location \

    Creates VaultGroup in the root vault location
