---
title: Get-PASGroup
---

## SYNOPSIS

List groups from the vault

## SYNTAX

    Get-PASGroup [[-filter] <String>] [[-search] <String>] [<CommonParameters>]

## DESCRIPTION

Returns a list of all existing user groups.

The user performing this task:

- Must have Audit users permissions in the Vault.
- Can see groups either only on the same level, or lower in the Vault hierarchy.

## PARAMETERS

    -filter <String>
        Filter according to REST standard.

        Required?                    false
        Position?                    1
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -search <String>
        Search will match when ALL search terms appear in the group name.

        Required?                    false
        Position?                    2
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

    PS C:\>Get-PASGroup

    Returns all existing groups




    -------------------------- EXAMPLE 2 --------------------------

    PS C:\>Get-PASGroup -filter 'groupType eq Directory'

    Returns all existing Directory groups




    -------------------------- EXAMPLE 3 --------------------------

    PS C:\>Get-PASGroup -filter 'groupType eq Vault'

    Returns all existing Vault groups




    -------------------------- EXAMPLE 4 --------------------------

    PS C:\>Get-PASGroup -search "Vault Admins"

    Returns all groups matching all search terms




    -------------------------- EXAMPLE 5 --------------------------

    PS C:\>Get-PASGroup -search "Vault Admins" -filter 'groupType eq Directory'

    Returns all existing Directory groups matching all search terms
