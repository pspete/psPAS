---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Enable-PASCPMAutoManagement
schema: 2.0.0
title: Enable-PASCPMAutoManagement
---

# Enable-PASCPMAutoManagement

## SYNOPSIS
Enables an account for Automatic CPM Management.

## SYNTAX

```
Enable-PASCPMAutoManagement [-AccountID] <String> [<CommonParameters>]
```

## DESCRIPTION
Enables an account for CPM management by setting automaticManagementEnabled to $true,
and clearing any value set for manualManagementReason.

Attempting to set automaticManagementEnabled to $true without clearing manualManagementReason
at the same time results in an error.

This function requests the API to perform both operations with a single command.

## EXAMPLES

### EXAMPLE 1
```
Enable-PASCPMAutoManagement -AccountID 543_2
```

Sets automaticManagementEnabled to $true & clears any value set for manualManagementReason
on account with ID 543_2

## PARAMETERS

### -AccountID
The ID of the account to enable for automatic management by CPM.

```yaml
Type: String
Parameter Sets: (All)
Aliases: id

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
Applicable to and requires 10.4+

## RELATED LINKS

[https://pspas.pspete.dev/commands/Enable-PASCPMAutoManagement](https://pspas.pspete.dev/commands/Enable-PASCPMAutoManagement)

[https://pspas.pspete.dev/commands/Set-PASAccount](https://pspas.pspete.dev/commands/Set-PASAccount)
