---
title: New-PASRequest
---

## SYNOPSIS

Creates an access request for a specific account

## SYNTAX

    New-PASRequest [-AccountId] <String> [[-Reason] <String>] [[-TicketingSystemName] <String>]
    [[-TicketID] <String>] [[-MultipleAccessRequired] <Boolean>] [[-FromDate] <DateTime>]
    [[-ToDate] <DateTime>] [[-AdditionalInfo] <Hashtable>] [[-UseConnect] <Boolean>]
    [[-ConnectionComponent] <String>] [[-ConnectionParams] <Hashtable>] [-WhatIf] [-Confirm]
    [<CommonParameters>]

## DESCRIPTION

Creates an access request for a specific account.

This account may be either a password account or an SSH Key account.

Officially supported from version 9.10. Reports received that function works in 9.9 also.

## PARAMETERS

    -AccountId <String>
        The ID of the account to access

        Required?                    true
        Position?                    1
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -Reason <String>
        The reason why the account will be accessed

        Required?                    false
        Position?                    2
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -TicketingSystemName <String>
        The name of the Ticketing system specified in the request

        Required?                    false
        Position?                    3
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -TicketID <String>
        The Ticket ID given by the ticketing system.

        Required?                    false
        Position?                    4
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -MultipleAccessRequired <Boolean>
        Whether the request is for multiple accesses

        Required?                    false
        Position?                    5
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -FromDate <DateTime>
        If the request is for a timeframe, the time from when the user wants to access the account.

        Required?                    false
        Position?                    6
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -ToDate <DateTime>
        If the request is for a timeframe, the time until the user wants to access the account.

        Required?                    false
        Position?                    7
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -AdditionalInfo <Hashtable>
        Additional information included in the request

        Required?                    false
        Position?                    8
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -UseConnect <Boolean>
        Whether or not the request is for connection through the PSM.

        Required?                    false
        Position?                    9
        Default value                False
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -ConnectionComponent <String>
        If the connection is through PSM, the name of the connection component to connect with,
        as defined in the configuration.

        Required?                    false
        Position?                    10
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -ConnectionParams <Hashtable>
        A list of parameters required to perform the connection, as defined in each connection
        component configuration

        Required?                    false
        Position?                    11
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

    PS C:\>New-PASRequest -AccountId $ID -Reason "Task ABC" -MultipleAccess $true
    -ConnectionComponent PSM-RDP

    Creates a new request for access to account with ID in $ID
