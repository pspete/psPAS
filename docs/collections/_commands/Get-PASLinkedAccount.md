---
external help file: psPAS-help.xml
Module Name: psPAS
online version:
schema: 2.0.0
title: Get-PASLinkedAccount
---

# Get-PASLinkedAccount

## SYNOPSIS
Gets linked account details

## SYNTAX

```
Get-PASLinkedAccount -id <String> [<CommonParameters>]
```

## DESCRIPTION
Gets details of associated linked accounts for a given accountID

Requires CyberArk Version 12.2 or higher.

## EXAMPLES

### Example 1
```powershell
Get-PASLinkedAccount -id 66_6
```

Gets linked account details associated with account with ID 66_6

## PARAMETERS

### -id
The account id

```yaml
Type: String
Parameter Sets: (All)
Aliases: AccountID

Required: True
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

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASLinkedAccount](https://pspas.pspete.dev/commands/Get-PASLinkedAccount)
