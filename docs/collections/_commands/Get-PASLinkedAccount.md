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

### EXAMPLE 1
```powershell
Get-PASLinkedAccount -id 66_6
```

Gets linked account details associated with account with ID 66_6

### EXAMPLE 2
```powershell
Get-PASAccount -id 66_6 | Get-PASLinkedAccount
```

Gets the account and returns its linked account details, using the account ID supplied via the pipeline.

### EXAMPLE 3
```powershell
Get-PASAccount -search "Bob" | Get-PASLinkedAccount
```

Gets linked account details for every account matching the search, using each account ID from the pipeline.

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
