---
title: Get-PASDirectory
---

## SYNOPSIS

Get LDAP directories configured in the Vault

## SYNTAX

    Get-PASDirectory [-id <String>] [<CommonParameters>]

## DESCRIPTION

Returns a list of existing directories in the Vault.

Each directory will be returned with its own data.

Membership of the Vault Admins group required.

## PARAMETERS

    -id <String>
        The ID or Name of the directory to return information on.
        Requires CyberArk version 10.5+

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

    PS C:\>Get-PASDirectory

    Returns LDAP directories configured in the Vault
