---
title: Get-PASServerWebService
---

## SYNOPSIS

Returns details of the Web Service

## SYNTAX

    Get-PASServerWebService [[-WebSession] <WebRequestSession>] [-BaseURI] <String>
    [[-PVWAAppName] <String>] [<CommonParameters>]

## DESCRIPTION

Returns information on Server web service.

Returns the name of the Vault configured in the ServerDisplayName configuration parameter

## PARAMETERS

    -WebSession <WebRequestSession>
        WebRequestSession object returned from New-PASSession

        Required?                    false
        Position?                    1
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -BaseURI <String>
        PVWA Web Address
        Do not include "/PasswordVault/"

        Required?                    true
        Position?                    2
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -PVWAAppName <String>
        The name of the CyberArk PVWA Virtual Directory.
        Defaults to PasswordVault

        Required?                    false
        Position?                    3
        Default value                PasswordVault
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>Get-PASServerWebService

    Displays CyberArk Web Service Information
