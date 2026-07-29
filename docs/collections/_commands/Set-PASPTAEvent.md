---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Set-PASPTAEvent
schema: 2.0.0
title: Set-PASPTAEvent
---

# Set-PASPTAEvent

## SYNOPSIS
Updates the status of a security event

## SYNTAX

### 11.3 (Default)
```
Set-PASPTAEvent [-EventID] <String> [[-mStatus] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### 14.0
```
Set-PASPTAEvent [-EventID] <String> [[-mStatus] <String>] [-closeReason <String>] [-reasonText <String>]
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates the status of a security event to open or closed

## EXAMPLES

### EXAMPLE 1
```
Set-PASPTAEvent -EventID $id
```

### EXAMPLE 2
```
Set-PASPTAEvent -EventID $id -mStatus CLOSED
```

Closes the security event matching the specified EventID.

### EXAMPLE 3
```
Set-PASPTAEvent -EventID $id -mStatus CLOSED -closeReason HANDLED -reasonText 'Confirmed as expected administrative activity'
```

Closes the security event and records a close reason and explanatory text. Requires minimum version 14.0.

### EXAMPLE 4
```
Set-PASPTAEvent -EventID $id -mStatus CLOSED -WhatIf
```

Shows what would happen if the security event was closed, without making the change.

## PARAMETERS

### -EventID
The event ID.

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

### -mStatus
The status to update (open or closed).

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
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

### -closeReason
The close reason for the security event after you have investigated and handled the event successfully or determined to close it for other reasons

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

### -reasonText
Free text for the user to elaborate on the close reason. Limited to 100 characters

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Minimum Version CyberArk 11.3

## RELATED LINKS

[https://pspas.pspete.dev/commands/Set-PASPTAEvent](https://pspas.pspete.dev/commands/Set-PASPTAEvent)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/CloseOpenSecurityEvent.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/CloseOpenSecurityEvent.htm)
