---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASPSMRecording
schema: 2.0.0
title: Get-PASPSMRecording
---

# Get-PASPSMRecording

## SYNOPSIS
Get details of PSM Recording

## SYNTAX

### byQuery (Default)
```
Get-PASPSMRecording [-Limit <Int32>] [-Sort <String>] [-Search <String>] [-Safe <String>]
 [-FromTime <DateTime>] [-ToTime <DateTime>] [-Activities <String>] [<CommonParameters>]
```

### byRecordingID
```
Get-PASPSMRecording [-RecordingID <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns the details of recordings of PSM, PSMP or OPM sessions.

By default, recordings from the last 48 hours are returned.
- When specifying `ToTime` without `FromTime`, recordings from the 48 hours before `ToTime` are returned.

## EXAMPLES

### EXAMPLE 1
```
Get-PASPSMRecording -Sort -FileName
```

Lists PSM recordings from the last 24 hours, sorted by descending filename.

### EXAMPLE 2
```
Get-PASPSMRecording -RecordingID $Id
```

Gets details of specified PSM recording

Minimum required version 10.6

### EXAMPLE 3
```
Get-PASPSMRecording -FromTime (Get-Date).AddDays(-7)
```

Lists all PSM recordings from the last week.

## PARAMETERS

### -RecordingID
Unique ID of the recorded PSM session

Minimum required version 10.6

```yaml
Type: String
Parameter Sets: byRecordingID
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Limit
The number of recordings that are returned in the list.

```yaml
Type: Int32
Parameter Sets: byQuery
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Sort
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

```yaml
Type: String
Parameter Sets: byQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Search
Returns recordings that are filtered by properties that contain the specified search text.

```yaml
Type: String
Parameter Sets: byQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Safe
Returns recordings from a specific safe

```yaml
Type: String
Parameter Sets: byQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -FromTime
Returns recordings from a specific date

```yaml
Type: DateTime
Parameter Sets: byQuery
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ToTime
Returns recordings from a specific date
- When specifying `ToTime` without `FromTime`, recordings from the 48 hours prior to `ToTime` are returned.

```yaml
Type: DateTime
Parameter Sets: byQuery
Aliases:

Required: False
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Activities
Returns recordings with specific activities.

```yaml
Type: String
Parameter Sets: byQuery
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Minimum CyberArk Version 9.10

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASPSMRecording](https://pspas.pspete.dev/commands/Get-PASPSMRecording)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetRecordings.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetRecordings.htm)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetRecording.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetRecording.htm)
