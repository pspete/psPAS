---
title: Get-PASRequestDetail
---

## SYNOPSIS

Gets requests

## SYNTAX

    Get-PASRequestDetail [-RequestType] <String> [-RequestID] <String> [<CommonParameters>]

## DESCRIPTION

Gets Requests

Officially supported from version 9.10. Reports received that function works in 9.9 also.

## PARAMETERS

    -RequestType <String>
        Specify whether outgoing or incoming requests will be searched for

        Required?                    true
        Position?                    1
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -RequestID <String>
        The request's uniqueID, composed of the Safe Name and internal RequestID.

        Required?                    true
        Position?                    2
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

    PS C:\>Get-PASRequestDetail -RequestType IncomingRequests -RequestID $ID

    Gets details of request with ID held in $ID
