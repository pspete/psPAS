---
title: Get-PASPlatformPSMConfig
---

## SYNOPSIS

    Lists PSM Policy Section of a target platform.

## SYNTAX

    Get-PASPlatformPSMConfig [-ID] <Int32> [<CommonParameters>]

## DESCRIPTION

    Allows Vault admins to retrieve the PSM Policy Section of a target platform.

## PARAMETERS

    -ID <Int32>
        The numeric ID of the target platform to list PSM Policy of.

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>Get-PASPlatformPSMConfig -ID 42

    Lists PSM Policy Section of target platform with ID of 42.
