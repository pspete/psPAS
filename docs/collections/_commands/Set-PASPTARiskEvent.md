---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Set-PASPTARiskEvent
schema: 2.0.0
---

# Set-PASPTARiskEvent

## SYNOPSIS
Update PTA Risk Events

## SYNTAX

### 13.2 (Default)
```
Set-PASPTARiskEvent -ID <String> [-status] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### 14.0
```
Set-PASPTARiskEvent -ID <String> [-status] <String> [-closeReason <String>] [-reasonText <String>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Update the status of a risk event to open or closed.

Requires minimum version of 13.2

## EXAMPLES

### EXAMPLE 1
```powershell
Set-PASPTARiskEvent -EventID 123 -Status CLOSED
```

Close PTA Risk Event with id 1234

## PARAMETERS

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

### -closeReason
The close reason for the risk event
Valid Values:
- HANDLED
- NOTREAL
- OTHER
- NONE

Requires version 14.0

```yaml
Type: String
Parameter Sets: 14.0
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ID
The ID of the PTA Risk Event

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -reasonText
Free text close reason

Requires version 14.0

```yaml
Type: String
Parameter Sets: 14.0
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -status
The status to update on the risk event

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

## RELATED LINKS

[https://pspas.pspete.dev/commands/Set-PASPTARiskEvent](https://pspas.pspete.dev/commands/Set-PASPTARiskEvent)

[https://docs.cyberark.com/PAS/Latest/en/Content/WebServices/CloseOpenRiskEvent.htm](https://docs.cyberark.com/PAS/Latest/en/Content/WebServices/CloseOpenRiskEvent.htm)
