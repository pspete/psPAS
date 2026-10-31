---
external help file: psPAS-help.xml
Module Name: psPAS
online version:
schema: 2.0.0
title: Get-PASAccountApprover
---

# Get-PASAccountApprover

## SYNOPSIS
Gets the approvers for an account

## SYNTAX

```
Get-PASAccountApprover -id <String> [<CommonParameters>]
```

## DESCRIPTION
Gets the users and groups who can confirm access requests for an account which is subject to dual control.

Requires CyberArk Version 15.2 or higher.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-PASAccountApprover -id 12_34
```

Gets the approvers for account 12_34

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

[https://pspas.pspete.dev/commands/Get-PASAccountApprover](https://pspas.pspete.dev/commands/Get-PASAccountApprover)
