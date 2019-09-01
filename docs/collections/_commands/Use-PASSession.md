---
title: Use-PASSession
---

## SYNOPSIS

Sets module scope variables allowing saved session information to be used for future requests.

## SYNTAX

    Use-PASSession [-Session] <Object> [<CommonParameters>]

## DESCRIPTION

Use session data (BaseURI, ExternalVersion, WebSession (containing Authorization Header)) for future requests.

psPAS uses variables in the Module scope to provide required values to all module functions, use this function to
set the required values in the module scope, using session information returned from `Get-PASSession`.

## PARAMETERS

    -Session <Object>
        An object containing psPAS session data, as returned from Get-PASSession

        Required?                    true
        Position?                    1
        Default value
        Accept pipeline input?       true (ByValue)
        Accept wildcard characters?  false

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\> Use-PASSession -Session $Session

    Use Saved Session Data for future requests


    -------------------------- EXAMPLE 2 --------------------------

    PS C:\> $CurrentSession = Get-PASSession

    PS C:\> Use-PASSession -Session $OtherSession
    ...
    PS C:\> Use-PASSession -Session $CurrentSession

    Save current session, switch to using different session details, switch back to original session.
