---
title: Get-PASServer
---

## SYNOPSIS

Returns details of the Web Service Server

## SYNTAX

    Get-PASServer [<CommonParameters>]

## DESCRIPTION

Returns information on Server.

Returns the name of the Vault configured in the ServerDisplayName configuration parameter.

Appears to need Vault administrator rights

## PARAMETERS

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>Get-PASServer

    Displays CyberArk Server information
