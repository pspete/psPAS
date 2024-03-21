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

### Gen2 (Default)
```
Get-PASAccountActivity [-AccountID] <String> [<CommonParameters>]
```

### Gen1
```
Get-PASAccountActivity [-AccountID] <String> [-UseGen1API] [<CommonParameters>]
```

## DESCRIPTION
Returns activities for a specific account identified by its AccountID.

## EXAMPLES

### EXAMPLE 1
```
Get-PASAccount -Keywords root -Safe UNIXSafe | Get-PASAccountActivity
```

Will return the account activity for the account output by Get-PASAccount

### EXAMPLE 2
```
Get-PASAccountActivity -id 123_4 -useGen1API
```

Will return the account activity for the account using the Gen1 API

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

### -UseGen1API
Specify to force use of the Gen1 API

Gen1 API is Deprecated from version 13.2

```yaml
Type: SwitchParameter
Parameter Sets: Gen1
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

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASAccountActivity](https://pspas.pspete.dev/commands/Get-PASAccountActivity)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Files%20-%20Get%20File%20Activity%20by%20ID.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Files%20-%20Get%20File%20Activity%20by%20ID.htm)
