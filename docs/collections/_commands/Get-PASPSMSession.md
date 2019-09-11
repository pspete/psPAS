---
title: Get-PASPSMSession
---

## SYNOPSIS

Get details of Live PSM Sessions

## SYNTAX

    Get-PASPSMSession [-Limit <Int32>] [-Sort <String>] [-Offset <Int32>] [-Search <String>]
    [-Safe <String>] [-FromTime <Int32>] [-ToTime <Int32>] [-Activities <String>]
    [<CommonParameters>]

    Get-PASPSMSession [-liveSessionId <String>] [<CommonParameters>]

## DESCRIPTION

Returns the details of active PSM sessions.

## PARAMETERS

    -liveSessionId <String>
        The ID of an active session to get details of.
        Requires CyberArk version 10.6+

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -Limit <Int32>
        The number of sessions that are returned in the list.

        Required?                    false
        Position?                    named
        Default value                0
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -Sort <String>
        The sort can be done by each property on the recording file:
         - RiskScore
         - FileName
         - SafeName
         - FolderName
         - PSMVaultUserName
         - FromIP
         - RemoteMachine
         - Client
         - Protocol
         - AccountUserName
         - AccountAddress
         - AccountPlatformID
         - PSMStartTime
         - TicketID
        The sort can be in ascending or descending order.
        To sort in descending order, specify "-" before the recording property by which to sort.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -Offset <Int32>
        Determines which recording results will be returned, according to a specific place in
        the returned list.
        This value defines the recording's place in the list and how many results will be skipped.

        Required?                    false
        Position?                    named
        Default value                0
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -Search <String>
        Returns recordings that are filtered by properties that contain the specified search text.

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -Safe <String>
        Returns recordings from a specific safe

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -FromTime <Int32>
        Returns recordings from a specific date

        Required?                    false
        Position?                    named
        Default value                0
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -ToTime <Int32>
        Returns recordings from a specific date

        Required?                    false
        Position?                    named
        Default value                0
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -Activities <String>
        Returns recordings with specific activities.

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

    PS C:\>Get-PASPSMSession

    Lists all Live PSM Sessions.




    -------------------------- EXAMPLE 2 --------------------------

    PS C:\>Get-PASPSMSession -liveSessionId 123_45

    Returns details of active PSM Session with Id 123_45
