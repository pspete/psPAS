---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Stop-PASPSMSession
schema: 2.0.0
title: Stop-PASPSMSession
---

# Stop-PASPSMSession

## SYNOPSIS
Terminates a Live PSM Session.

## SYNTAX

```
Stop-PASPSMSession [-LiveSessionId] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Terminates a Live PSM Session identified by the unique ID of the PSM Session.

## EXAMPLES

### EXAMPLE 1
```
Stop-PASPSMSession -LiveSessionId $SessionUUID
```

Terminates Live PSM Session identified by the session UUID.

## PARAMETERS

### -LiveSessionId
The unique ID/SessionGuid of a Live PSM Session.

```yaml
Type: String
Parameter Sets: (All)
Aliases: SessionGuid

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Minimum CyberArk Version 10.1

## RELATED LINKS

[https://pspas.pspete.dev/commands/Stop-PASPSMSession](https://pspas.pspete.dev/commands/Stop-PASPSMSession)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/PTA-PSM-TerminateSession.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/PTA-PSM-TerminateSession.htm)
