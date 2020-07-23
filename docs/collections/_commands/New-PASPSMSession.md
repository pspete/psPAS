---
title: New-PASPSMSession
---

## SYNOPSIS

    Get required parameters to connect through PSM

## SYNTAX

    New-PASPSMSession -AccountID <String> [-reason <String>] [-TicketingSystemName <String>] [-TicketId <String>] -ConnectionComponent <String> [-AllowMappingLocalDrives
    <String>] [-AllowConnectToConsole <String>] [-RedirectSmartCards <String>] [-PSMRemoteMachine <String>] [-LogonDomain <String>] [-AllowSelectHTML5 <String>]
    [-ConnectionMethod <String>] [-Path <String>] [<CommonParameters>]

    New-PASPSMSession -userName <String> -secret <SecureString> -address <String> -platformID <String> [-extraFields <String>] [-reason <String>] [-TicketingSystemName
    <String>] [-TicketId <String>] -ConnectionComponent <String> [-AllowMappingLocalDrives <String>] [-AllowConnectToConsole <String>] [-RedirectSmartCards <String>]
    [-PSMRemoteMachine <String>] [-LogonDomain <String>] [-AllowSelectHTML5 <String>] [-ConnectionMethod <String>] [-Path <String>] [<CommonParameters>]

## DESCRIPTION

    This method enables you to connect to an account through PSM (PSMConnect).
    The function returns either an RDP file or URL for PSM connections.
    It requires the PVWA and PSM to be configured for either transparent connections through PSM with RDP files
    or the HTML5 Gateway.

## PARAMETERS

    -AccountID <String>
        The unique ID of the account to retrieve and use to connect to the target via PSM

    -userName <String>
        For Ad-Hoc connections: the username of the account to connect with.

    -secret <SecureString>
        For Ad-Hoc connections: The target account password.

    -address <String>
        For Ad-Hoc connections: The target account address.

    -platformID <String>
        For Ad-Hoc connections: A configured secure connect platform.

    -extraFields <String>
        For Ad-Hoc connections: Additional needed parameters for the various connection components.

    -reason <String>
        The reason that is required to request access to this account.

    -TicketingSystemName <String>
        The name of the Ticketing System used in the request.

    -TicketId <String>
        The TicketId to use with the Ticketing System

    -ConnectionComponent <String>
        The name of the connection component to connect with as defined in the configuration

    -AllowMappingLocalDrives <String>
        Whether or not to redirect their local hard drives to the remote server.

    -AllowConnectToConsole <String>
        Whether or not to connect to the administrative console of the remote machine.

    -RedirectSmartCards <String>
        Whether or not to redirect Smart Card so that the certificate stored on the card can be accessed on the target

    -PSMRemoteMachine <String>
        Address of the remote machine to connect to.

    -LogonDomain <String>
        The netbios domain name of the account being used.

    -AllowSelectHTML5 <String>
        Specify which connection method, HTML5-based or RDP-file, to use when connecting to the remote server

    -ConnectionMethod <String>
        The expected parameters to be returned, either RDP or PSMGW.

        PSMGW is only available from version 10.2 onwards

    -Path <String>
        The folder to save the output file in.

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>New-PASPSMSession -AccountID $ID -ConnectionComponent PSM-SSH -reason "Fix XYZ"

    Outputs RDP file for Direct Connection via PSM using account with ID in $ID

    -------------------------- EXAMPLE 2 --------------------------

    PS C:\>New-PASPSMSession -AccountID $id -ConnectionComponent PSM-RDP -AllowMappingLocalDrives No -PSMRemoteMachine ServerName

    Provide connection parameters for the new PSM connection
