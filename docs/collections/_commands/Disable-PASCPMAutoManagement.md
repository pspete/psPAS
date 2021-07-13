---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Disable-PASCPMAutoManagement
schema: 2.0.0
title: Disable-PASCPMAutoManagement
---

# Disable-PASCPMAutoManagement

## SYNOPSIS
Disables an account for Automatic CPM Management.

## SYNTAX

```
Disable-PASCPMAutoManagement -AccountID <String> [-Reason <String>] [<CommonParameters>]
```

## DESCRIPTION
Disables an account for CPM management by setting automaticManagementEnabled to $false,
and optionally sets a value for manualManagementReason.

## EXAMPLES

### EXAMPLE 1
```
Disables-PASCPMAutoManagement -AccountID 543_2
```

Sets automaticManagementEnabled to $false on account with ID 543_2

### EXAMPLE 2
```
Disables-PASCPMAutoManagement -AccountID 543_2 -Reason "Some Reason"
```

Sets automaticManagementEnabled to $false & sets manualManagementReason on account with ID 543_2

## PARAMETERS

### -AccountID
The ID of the account to disable automatic CPM management.

```yaml
Type: String
Parameter Sets: (All)
Aliases: id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Reason
The value to set for manualManagementReason

```yaml
Type: String
Parameter Sets: (All)
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
Applicable to and requires 10.4+

## RELATED LINKS

[https://pspas.pspete.dev/commands/Disable-PASCPMAutoManagement](https://pspas.pspete.dev/commands/Disable-PASCPMAutoManagement)

[https://pspas.pspete.dev/commands/Set-PASAccount](https://pspas.pspete.dev/commands/Set-PASAccount)
