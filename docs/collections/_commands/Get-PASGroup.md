---
title: Get-PASGroup
---

## SYNOPSIS

    List groups from the vault

## SYNTAX

    Get-PASGroup [-groupType <String>] [-search <String>] [<CommonParameters>]

    Get-PASGroup [-filter <String>] [-search <String>] [<CommonParameters>]

## DESCRIPTION

    Returns a list of all existing user groups.

    The user performing this task:
    - Must have Audit users permissions in the Vault.
    - Can see groups either only on the same level, or lower in the Vault hierarchy.

## PARAMETERS

    -groupType <String>
        Search for groups which are from a configured Directory or from the Vault.

    -filter <String>
        Filter according to REST standard.
        *depreciated parameter in psPAS - filter value will automatically be set with if groupType specified.

    -search <String>
        Search will match when ALL search terms appear in the group name.

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>Get-PASGroup

    Returns all existing groups




    -------------------------- EXAMPLE 2 --------------------------

    PS C:\>Get-PASGroup -groupType Directory

    Returns all existing Directory groups




    -------------------------- EXAMPLE 3 --------------------------

    PS C:\>Get-PASGroup -groupType Vault

    Returns all existing Vault groups




    -------------------------- EXAMPLE 4 --------------------------

    PS C:\>Get-PASGroup -filter 'groupType eq Directory'

    Returns all existing Directory groups




    -------------------------- EXAMPLE 5 --------------------------

    PS C:\>Get-PASGroup -search "Vault Admins"

    Returns all groups matching all search terms




    -------------------------- EXAMPLE 6 --------------------------

    PS C:\>Get-PASGroup -search "Vault Admins" -groupType Directory

    Returns all existing Directory groups matching all search terms
