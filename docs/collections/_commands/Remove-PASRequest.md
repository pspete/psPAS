---
title: Remove-PASRequest
---

## SYNOPSIS

Deletes a request from the Vault

## SYNTAX

    Remove-PASRequest [-RequestID] <String>

## DESCRIPTION

Deletes a request from the Vault.

The "Manage" Safe vault permission is required.

Officially supported from version 9.10. Reports received that function works in 9.9 also.

## PARAMETERS

    -RequestID <String>
        The ID (composed of the Safe Name and internal RequestID.) of the request to delete.

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

    Remove-PASRequest -RequestID "<ID>"

    Deletes Request <ID>
