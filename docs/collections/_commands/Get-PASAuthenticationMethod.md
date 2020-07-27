---
title: Get-PASAuthenticationMethod
---

## SYNOPSIS

    List authentication methods

## SYNTAX

    Get-PASAuthenticationMethod [[-ID] <String>] [<CommonParameters>]

## DESCRIPTION

    Returns a list of all existing authentication methods.
    Membership of Vault admins group required

## PARAMETERS

    -ID <String>
        The ID of a specific authentication method to return details of

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>Get-PASAuthenticationMethod

    Returns list of all authentication methods.
