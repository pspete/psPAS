---
external help file: psPAS-help.xml
Module Name: psPAS
online version:
schema: 2.0.0
title: Get-PASLinkedGroup
---

# Get-PASLinkedGroup

## SYNOPSIS
Gets linked group details

## SYNTAX

```
Get-PASLinkedGroup [-id] <String> [<CommonParameters>]
```

## DESCRIPTION
Gets details of associated linked groups for a given accountID

Requires CyberArk Version 12.2 or higher.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-PASLinkedGroup -id 66_6
```

Gets linked group details associated with account with ID 66_6

### EXAMPLE 2
```powershell
Get-PASAccount -safeName TargetSafe | Get-PASLinkedGroup
```

Gets linked group details for every account in the TargetSafe safe.

### EXAMPLE 3
```powershell
'19_1', '36_3' | ForEach-Object { Get-PASLinkedGroup -id $_ }
```

Gets linked group details for each of the specified account IDs.

## PARAMETERS

### -id
The account id

```yaml
Type: String
Parameter Sets: (All)
Aliases: AccountID

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

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASLinkedGroup](https://pspas.pspete.dev/commands/Get-PASLinkedGroup)
