---
title: New-PASRequest
---

## SYNOPSIS

    Creates an access request for a specific account

## SYNTAX

    New-PASRequest -AccountId <String> [-Reason <String>] [-TicketingSystemName <String>] [-TicketID <String>]
    [-MultipleAccessRequired <Boolean>] [-FromDate <DateTime>] [-ToDate <DateTime>] [-AdditionalInfo <Hashtable>]
    [-UseConnect <Boolean>] [-ConnectionComponent <String>] [-AllowMappingLocalDrives <Boolean>]
    [-AllowConnectToConsole <Boolean>] [-RedirectSmartCards <Boolean>] [-PSMRemoteMachine <String>] [-LogonDomain
    <String>] [-AllowSelectHTML5 <Boolean>] [-WhatIf] [-Confirm] [<CommonParameters>]

    New-PASRequest -AccountId <String> [-Reason <String>] [-TicketingSystemName <String>] [-TicketID <String>]
    [-MultipleAccessRequired <Boolean>] [-FromDate <DateTime>] [-ToDate <DateTime>] [-AdditionalInfo <Hashtable>]
    [-UseConnect <Boolean>] [-ConnectionComponent <String>] [-ConnectionParams <Hashtable>] [-WhatIf] [-Confirm]
    [<CommonParameters>]

## DESCRIPTION

    Creates an access request for a specific account.
    This account may be either a password account or an SSH Key account.
    Officially supported from version 9.10. Reports received that function works in 9.9 also.

## PARAMETERS

    -AccountId <String>
        The ID of the account to access

    -Reason <String>
        The reason why the account will be accessed

    -TicketingSystemName <String>
        The name of the Ticketing system specified in the request

    -TicketID <String>
        The Ticket ID given by the ticketing system.

    -MultipleAccessRequired <Boolean>
        Whether the request is for multiple accesses

    -FromDate <DateTime>
        If the request is for a timeframe, the time from when the user wants to access the account.

    -ToDate <DateTime>
        If the request is for a timeframe, the time until the user wants to access the account.

    -AdditionalInfo <Hashtable>
        Additional information included in the request

    -UseConnect <Boolean>
        Whether or not the request is for connection through the PSM.

    -ConnectionComponent <String>
        If the connection is through PSM, the name of the connection component to connect with,
        as defined in the configuration.

    -AllowMappingLocalDrives <Boolean>
        Whether or not to redirect their local hard drives to the remote server.

    -AllowConnectToConsole <Boolean>
        Whether or not to connect to the administrative console of the remote machine.

    -RedirectSmartCards <Boolean>
        Whether or not to redirect Smart Card so that the certificate stored on the card can be accessed on the target

    -PSMRemoteMachine <String>
        Address of the remote machine to connect to.

    -LogonDomain <String>
        The netbios domain name of the account being used.

    -AllowSelectHTML5 <Boolean>
        Specify which connection method, HTML5-based or RDP-file, to use when connecting to the remote server

    -ConnectionParams <Hashtable>
        A list of parameters required to perform the connection, as defined in each connection component configuration

    -WhatIf [<SwitchParameter>]

    -Confirm [<SwitchParameter>]

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>New-PASRequest -AccountId $ID -Reason "Task ABC" -MultipleAccessRequired $true -ConnectionComponent PSM-RDP

    Creates a new request for access to account with ID in $ID
