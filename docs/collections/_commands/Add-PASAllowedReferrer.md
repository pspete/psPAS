---
title: Add-PASAllowedReferrer
---

## SYNOPSIS

    Adds an entry to the allowed referrer list.

## SYNTAX

    Add-PASAllowedReferrer [-referrerURL] <String> [[-regularExpression] <Boolean>] [<CommonParameters>]

## DESCRIPTION

    Adds a new web application URL to the allowed referrer list.
    Vault admins group membership required.

## PARAMETERS

    -referrerURL <String>
        A URL from where access to PVWA will be allowed:

    -regularExpression <Boolean>
        Whether or not the URL is a regular expression.

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>Add-PASAllowedReferrer -referrerURL "https://CompanyA/portal/"

    Adds portal URL which permits access from any page or sub-directory




    -------------------------- EXAMPLE 2 --------------------------

    PS C:\>Add-PASAllowedReferrer -referrerURL "https://CompanyB/management/dashboard"

    Adds URL that only allows access from a specific page
