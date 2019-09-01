---
title: Remove-PASSafe
---

## SYNOPSIS

Deletes a safe from the Vault

## SYNTAX

    Remove-PASSafe [-SafeName] <String>

## DESCRIPTION

Deletes a safe from the Vault.

The "Manage" Safe vault permission is required.

## PARAMETERS

    -SafeName <String>
        The name of the safe to delete.

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

    PS C:\>Remove-PASSafe -SafeName OLD_Safe

    Deletes "OLD_Safe"
