---
external help file: psPAS-help.xml
Module Name: psPAS
online version:
schema: 2.0.0
title: Get-PASAccountPrerequisite
---

# Get-PASAccountPrerequisite

## SYNOPSIS
Gets the access prerequisites for an account

## SYNTAX

```
Get-PASAccountPrerequisite -id <String> [<CommonParameters>]
```

## DESCRIPTION
Gets the reason, dual control, ticketing and connection requirements which apply when accessing an account.

Requires CyberArk Version 15.2 or higher.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-PASAccountPrerequisite -id 12_34
```

Gets the access prerequisites for account 12_34

## PARAMETERS

### -id
The ID of the account

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

[https://pspas.pspete.dev/commands/Get-PASAccountPrerequisite](https://pspas.pspete.dev/commands/Get-PASAccountPrerequisite)
