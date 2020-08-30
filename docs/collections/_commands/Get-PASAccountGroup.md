---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASAccountGroup
schema: 2.0.0
title: Get-PASAccountGroup
---

# Get-PASAccountGroup

## SYNOPSIS
Returns all the account groups in a specific Safe.

## SYNTAX

### 10.5 (Default)
```
Get-PASAccountGroup -Safe <String> [<CommonParameters>]
```

### 9.10
```
Get-PASAccountGroup -Safe <String> [-UseGen1API] [<CommonParameters>]
```

## DESCRIPTION
Returns all the account groups in a specific Safe.

The following permissions are required on the safe where the account group will be created:
 - Add Accounts
 - Update Account Content
 - Update Account Properties
  -Create Folders

## EXAMPLES

### EXAMPLE 1
```
Get-PASAccountGroup -Safe SafeName
```

List all account groups in SafeName

## PARAMETERS

### -Safe
The Safe where the account groups are.

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

### -UseGen1API
Specify to force usage the Gen1 API endpoint.

Relevant for CyberArk versions earlier than 10.5

```yaml
Type: SwitchParameter
Parameter Sets: 9.10
Aliases: UseClassicAPI

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
Minimum CyberArk version 9.10

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASAccountGroup](https://pspas.pspete.dev/commands/Get-PASAccountGroup)

