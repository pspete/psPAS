---
title: Get-PASComponentSummary
---

## SYNOPSIS

Returns consolidated information about CyberArk Components.

## SYNTAX

    Get-PASComponentSummary [<CommonParameters>]

## DESCRIPTION

Returns consolidated information about the Vault, PVWA, CPM, PSM/PSMP and AIM.

Includes all clients that are relevant to each specific component.

## PARAMETERS

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>Get-PASComponentSummary

    Displays CyberArk Component information
