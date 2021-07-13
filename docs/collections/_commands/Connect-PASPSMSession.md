---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Connect-PASPSMSession
schema: 2.0.0
title: Connect-PASPSMSession
---

# Connect-PASPSMSession

## SYNOPSIS
Connect to Live PSM Sessions

## SYNTAX

```
Connect-PASPSMSession [-SessionId] <String> [-ConnectionMethod] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns connection data necessary to monitor an active PSM session.

## EXAMPLES

### EXAMPLE 1
```
Connect-PASPSMSession -LiveSessionId $SessionUUID -ConnectionMethod RDP
```

Returns parameters to connect to Live PSM Session via RDP.

### EXAMPLE 2
```
Connect-PASPSMSession -LiveSessionId $SessionUUID -ConnectionMethod PSMGW
```

Returns parameters to connect to Live PSM Session via HTML5 GW.

## PARAMETERS

### -SessionId
The unique ID of the PSM Live Session.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ConnectionMethod
The expected parameters to be returned, either RDP or PSMGW.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Minimum CyberArk Version 10.5

## RELATED LINKS

[https://pspas.pspete.dev/commands/Connect-PASPSMSession](https://pspas.pspete.dev/commands/Connect-PASPSMSession)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/PSM%20-%20Monitor%20Sessions.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/PSM%20-%20Monitor%20Sessions.htm)
