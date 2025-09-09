---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Enable-PASTheme
schema: 2.0.0
title: Enable-PASTheme
---

# Enable-PASTheme

## SYNOPSIS
Activate Theme

## SYNTAX

```
Enable-PASTheme -ThemesNames <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Sets a specific theme. It can be the default one or custom themes

## EXAMPLES

### EXAMPLE 1
```
Enable-PASTheme -ThemesNames "Default Dark"
```

Sets the theme to the default dark theme

## PARAMETERS

### -ThemesNames
The Name of the theme to activate

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -WhatIf
Shows what would happen if the cmdlet runs.
The cmdlet is not run.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: wi

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -Confirm
Prompts you for confirmation before running the cmdlet.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: cf

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

[https://pspas.pspete.dev/commands/Enable-PASTheme](https://pspas.pspete.dev/commands/Enable-PASTheme)

[https://docs.cyberark.com/pam-self-hosted/14.4/en/content/sdk/rest-api-cust-ui-themes-activate.htm](https://docs.cyberark.com/pam-self-hosted/14.4/en/content/sdk/rest-api-cust-ui-themes-activate.htm)
