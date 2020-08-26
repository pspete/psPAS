---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASAccountActivity
schema: 2.0.0
title: Get-PASAccountActivity
---

# Get-PASAccountActivity

## SYNOPSIS
Returns activities for an account.

## SYNTAX

```
Get-PASAccountActivity [-AccountID] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns activities for a specific account identified by its AccountID.

## EXAMPLES

### EXAMPLE 1
```
Get-PASAccount -Keywords root -Safe UNIXSafe | Get-PASAccountActivity
```

Will return the account activity for the account output by Get-PASAccount:

Time                Activity                  UserName      AccountName
----                --------                  --------      -----------
08/07/2017 13:05:46 Delete Privileged Command Administrator root
08/07/2017 13:02:54 Delete Privileged Command Administrator root
07/30/2017 10:49:32 Add Privileged Command    Administrator root
...
...
...

## PARAMETERS

### -AccountID
The ID of the account whose activities will be retrieved.

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

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASAccountActivity](https://pspas.pspete.dev/commands/Get-PASAccountActivity)

