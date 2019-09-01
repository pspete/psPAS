---
title: Approve-PASRequest
---

## SYNOPSIS

Confirm a single request

## SYNTAX

    Approve-PASRequest [-RequestId] <String> [[-Reason] <String>]

## DESCRIPTION

Enables a request confirmer to confirm a single request, identified by its requestID.

Officially supported from version 9.10. Reports received that function works in 9.9 also.

## PARAMETERS

    -RequestId <String>
        The ID of the request to confirm

        Required?                    true
        Position?                    1
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -Reason <String>
        The reason why the request is approved

        Required?                    false
        Position?                    2
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

    Approve-PASRequest -RequestID <ID>- Reason "<Reason>"

    Confirms request <ID>
