---
title: Get-PASPSMRecording
---

## SYNOPSIS

Get details of PSM Recording

## SYNTAX

    Get-PASPSMRecording [-Limit <Int32>] [-Sort <String>] [-Offset <Int32>] [-Search <String>]
    [-Safe <String>] [-FromTime <Int32>] [-ToTime <Int32>] [-Activities <String>]
    [<CommonParameters>]

    Get-PASPSMRecording [-RecordingID <String>] [<CommonParameters>]

## DESCRIPTION

Returns the details of recordings of PSM, PSMP or OPM sessions.

## PARAMETERS

    -RecordingID <String>
        Unique ID of the recorded PSM session
        Requires CyberArk version 10.6+

        Required?                    false
        Position?                    named
        Default value
        Accept pipeline input?       true (ByPropertyName)
        Accept wildcard characters?  false

    -Limit <Int32>
        The number of recordings that are returned in the list.

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
        Determines which recording results will be returned, according to a specific place in the
        returned list. This value defines the recording's place in the list and how many results
        will be skipped.

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

    PS C:\>Get-PASPSMRecording -Limit 10 -Safe PSMRecordings -Sort -FileName

    Lists the first 10 recordings from the PSMRecordings safe, sorted by decending filename.
