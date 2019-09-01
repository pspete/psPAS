---
title: Import-PASConnectionComponent
---

## SYNOPSIS

Import a new connection component.

## SYNTAX

    Import-PASConnectionComponent [-ImportFile] <String>

## DESCRIPTION

Allows administrators to import a new connection component, such as those available to download from the CyberArk Marketplace.

## PARAMETERS

    -ImportFile <String>
        The zip file that contains the connection component.

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

    PS C:\>Import-PASConnectionComponent -ImportFile ConnectionComponent.zip

    Imports ConnectionComponent.zip Connection Component
