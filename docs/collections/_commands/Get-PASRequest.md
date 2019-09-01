---
title: Get-PASRequest
---

## SYNOPSIS

Gets requests

## SYNTAX

    Get-PASRequest [-RequestType] <String> [-OnlyWaiting] <Boolean> [-Expired] <Boolean>
    [<CommonParameters>]

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

    -OnlyWaiting <Boolean>
        Only requests waiting for approval will be listed

        Required?                    true
        Position?                    2
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -Expired <Boolean>
        Expired requests will be included in the list

        Required?                    true
        Position?                    3
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>Get-PASRequest -RequestType IncomingRequests -OnlyWaiting $true

    Lists waiting incoming requests




    -------------------------- EXAMPLE 2 --------------------------

    PS C:\>Get-PASRequest -RequestType MyRequests -Expired $false

    Lists your none expired (outgoing) requests.
