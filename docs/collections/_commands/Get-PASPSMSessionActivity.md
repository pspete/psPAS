---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASPSMSessionActivity
schema: 2.0.0
title: Get-PASPSMSessionActivity
---

# Get-PASPSMSessionActivity

## SYNOPSIS
Get activity details of Live PSM Sessions

## SYNTAX

```
Get-PASPSMSessionActivity [-liveSessionId] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns activity details of active PSM sessions.

## EXAMPLES

### EXAMPLE 1
```
Get-PASPSMSessionActivity -liveSessionId 123_45
```

Returns details of activities in active PSM Session with Id 123_45

## PARAMETERS

### -liveSessionId
The ID of an active session to get activities from.

```yaml
Type: String
Parameter Sets: (All)
Aliases: SessionID

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Minimum CyberArk Version 10.6

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASPSMSessionActivity](https://pspas.pspete.dev/commands/Get-PASPSMSessionActivity)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetActiveSessionProperties.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetActiveSessionProperties.htm)
