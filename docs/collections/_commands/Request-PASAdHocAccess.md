---
title: Request-PASAdHocAccess
---

## SYNOPSIS

Requests access to a target Windows machine

## SYNTAX

    Request-PASAdHocAccess [-AccountID] <String> [<CommonParameters>]

## DESCRIPTION

Requests and receives access, with administrative rights, to a target Windows machine.

The domain user who requests access will be added to the local Administrators group of the target machine.

## PARAMETERS

    -AccountID <String>
        The ID of the local account that will be used to add the logged on user to the Administrators
        group on the target machine.

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

    PS C:\>Request-PASAdHocAccess -AccountID 36_3

    Requests "ad hoc" access on the server for which the account with id 36_3 is a local account with
    local admin membership.
