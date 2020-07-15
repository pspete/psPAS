---
title: New-PASPSMSession
---

## SYNOPSIS

Get required parameters to connect through PSM

## SYNTAX

    New-PASPSMSession -AccountID <String> [-reason <String>] [-TicketingSystemName <String>]
    [-TicketId <String>] -ConnectionComponent <String> [-ConnectionParams <Hashtable>]
    [-ConnectionMethod <String>] [-Path <String>] [<CommonParameters>]

    New-PASPSMSession -userName <String> -secret <SecureString> -address <String>
    -platformID <String> [-extraFields <String>] [-reason <String>] [-TicketingSystemName <String>]
    [-TicketId <String>] -ConnectionComponent <String> [-ConnectionParams <Hashtable>]
    [-ConnectionMethod <String>] [-Path <String>] [<CommonParameters>]

## DESCRIPTION

This method enables you to connect to an account through PSM (PSMConnect).

The function returns either an RDP file or URL for PSM connections.

It requires the PVWA and PSM to be configured for either transparent connections through PSM with
RDP files or the HTML5 Gateway.

## PARAMETERS

    -AccountID <String>
        The unique ID of the account to retrieve and use to connect to the target via PSM

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -userName <String>
        For Ad-Hoc connections: the username of the account to connect with.

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -secret <SecureString>
        For Ad-Hoc connections: The target account password.

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -address <String>
        For Ad-Hoc connections: The target account address.

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -platformID <String>
        For Ad-Hoc connections: A configured secure connect platform.

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -extraFields <String>
        For Ad-Hoc connections: Additional needed parameters for the various connection components.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -reason <String>
        The reason that is required to request access to this account.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -TicketingSystemName <String>
        The name of the Ticketing System used in the request.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -TicketId <String>
        The TicketId to use with the Ticketing System

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -ConnectionComponent <String>
        The name of the connection component to connect with as defined in the configuration

        Required?                    true
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -ConnectionParams <Hashtable>
        List of params

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -ConnectionMethod <String>
        The expected parameters to be returned, either RDP or PSMGW.

        PSMGW is only available from version 10.2 onwards

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -Path <String>
        The folder to save the output file in.

        Required?                    false
        Position?                    named
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

    PS C:\>New-PASPSMSession -AccountID $ID -ConnectionComponent PSM-SSH
    -reason "Fix XYZ"

    Outputs RDP file for Direct Connection via PSM using account with ID in $ID
