---
title: Get-PASPlatform
---

## SYNOPSIS

Retrieves details of a specified platform from the Vault.

## SYNTAX

    Get-PASPlatform [-Name] <String> [<CommonParameters>]

## DESCRIPTION

Retrieves details of a specified platform from the Vault.

## PARAMETERS

    -Name <String>
        The unique ID/Name of the platform.

        Required?                    true
        Position?                    1
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

    PS C:\>Get-PASPlatform -Name "CyberArk"
