---
title: Remove-PASDirectory
---

## SYNOPSIS

Removes an LDAP directory configured in the Vault

## SYNTAX

    Remove-PASDirectory [-id] <String>

## DESCRIPTION

Removes an LDAP directory configuration from the vault.

Membership of the Vault Admins group required.

## PARAMETERS

    -id <String>
        The ID or Name of the directory to return information on.

        Required?                    true
        Position?                    1
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

    PS C:\>Remove-PASDirectory -id LDAPDirectory

    Removes LDAP directory configured in the Vault
