---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Suspend-PASPSMSession
schema: 2.0.0
title: Suspend-PASPSMSession
---

# Suspend-PASPSMSession

## SYNOPSIS
Suspends a Live PSM Session.

## SYNTAX

```
Suspend-PASPSMSession [-LiveSessionId] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Suspends a Live PSM session, identified by the unique ID of the PSM Session,
preventing further interaction in the session until it is resumed by Resume-PASPSMSession.

## EXAMPLES

### EXAMPLE 1
```
Suspend-PASPSMSession -LiveSessionId $SessionUUID
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
Minimum CyberArk Version 10.2

## RELATED LINKS

[https://pspas.pspete.dev/commands/Suspend-PASPSMSession](https://pspas.pspete.dev/commands/Suspend-PASPSMSession)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Suspend-ResumeSession.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Suspend-ResumeSession.htm)
