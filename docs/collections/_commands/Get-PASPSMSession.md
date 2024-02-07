---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASPSMSession
schema: 2.0.0
title: Get-PASPSMSession
---

# Get-PASPSMSession

## SYNOPSIS
Get details of Live PSM Sessions

## SYNTAX

### byQuery (Default)
```
Get-PASPSMSession [-Limit <Int32>] [-Sort <String>] [-Search <String>] [-Safe <String>] [-FromTime <DateTime>]
 [-ToTime <DateTime>] [-Activities <String>] [<CommonParameters>]
```

### bySessionID
```
Get-PASPSMSession [-liveSessionId <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns the details of active PSM sessions.

## EXAMPLES

### EXAMPLE 1
```
Get-PASPSMSession
```

Lists all Live PSM Sessions.

### EXAMPLE 2
```
Get-PASPSMSession -liveSessionId 123_45
```

Returns details of active PSM Session with Id 123_45

Minimum required version 10.6

## PARAMETERS

### -liveSessionId
The ID of an active session to get details of.

Minimum required version 10.6

```yaml
Type: String
Parameter Sets: bySessionID
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Limit
The number of sessions that are returned in the list.

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

For querying sessions by ID, Required CyberArk Version is 10.6

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASPSMSession](https://pspas.pspete.dev/commands/Get-PASPSMSession)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetLiveSessions.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetLiveSessions.htm)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetActiveSession.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetActiveSession.htm)
