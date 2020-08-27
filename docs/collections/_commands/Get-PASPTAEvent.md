---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASPTAEvent
schema: 2.0.0
title: Get-PASPTAEvent
---

# Get-PASPTAEvent

## SYNOPSIS
Returns PTA security events

## SYNTAX

### 11.3 (Default)
```
Get-PASPTAEvent [-fromUpdateDate <DateTime>] [-status <String>] [<CommonParameters>]
```

### 11.4
```
Get-PASPTAEvent [-fromUpdateDate <DateTime>] [-status <String>] [-accountID <String>] [<CommonParameters>]
```

### 10.3
```
Get-PASPTAEvent [-lastUpdatedEventDate <DateTime>] [<CommonParameters>]
```

## DESCRIPTION
Returns PTA security events

## EXAMPLES

### EXAMPLE 1
```
Get-PASPTAEvent
```

Returns all PTA security events

### EXAMPLE 2
```
Get-PASPTAEvent -fromUpdateDate $date
```

Returns all PTA security events since $date

### EXAMPLE 3
```
Get-PASPTAEvent -status OPEN
```

Returns all PTA security events with an Open status.

### EXAMPLE 4
```
Get-PASPTAEvent -lastUpdatedEventDate $date
```

Returns all PTA security events since $date

## PARAMETERS

### -fromUpdateDate
Starting date from which to get security events.

Requires 11.3

```yaml
Type: DateTime
Parameter Sets: 11.3, 11.4
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -status
The status of the security event (open or closed).

Requires 11.3

```yaml
Type: String
Parameter Sets: 11.3, 11.4
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -accountID
The unique account identifier of the account relating to the Security Event.

Requires 11.4

```yaml
Type: String
Parameter Sets: 11.4
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -lastUpdatedEventDate
Starting date from which to get security events.

```yaml
Type: DateTime
Parameter Sets: 10.3
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
Minimum Version CyberArk 10.3

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASPTAEvent](https://pspas.pspete.dev/commands/Get-PASPTAEvent)

