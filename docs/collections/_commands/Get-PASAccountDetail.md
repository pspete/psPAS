---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASAccountActivity
schema: 2.0.0
title: Get-PASAccountDetail
---

# Get-PASAccountDetail

## SYNOPSIS

Gets extended overview of account details

## SYNTAX

```
Get-PASAccountDetail -id <String> [<CommonParameters>]
```

## DESCRIPTION
Gets extended details of an account, including data on compliance, activities, dependencies, recordings & platform configuration settings.

## EXAMPLES

### EXAMPLE 1
```powershell
PS C:\> Get-PASAccountDetail -id 123_45
```

Displays extended details of account with id 123_45

## PARAMETERS

### -id
The Account ID of the account to get extended details for.

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
This is not an officially documented API method and is subject to change.

It is assumed to require minimum version of 10.4.

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASAccountActivity](https://pspas.pspete.dev/commands/Get-PASAccountActivity)

[https://documenter.getpostman.com/view/998920/RzZ9Gz1U#d20c01c2-f7fc-4717-bf10-d8c51cb11411](https://documenter.getpostman.com/view/998920/RzZ9Gz1U#d20c01c2-f7fc-4717-bf10-d8c51cb11411)