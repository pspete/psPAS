---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Publish-PASTheme
schema: 2.0.0
title: Publish-PASTheme
---

# Publish-PASTheme

## SYNOPSIS
Updates draft state a custom theme

## SYNTAX

```
Publish-PASTheme [-ThemeName] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates the draft state of a specific custom theme from $true to $false

## EXAMPLES

### Example 1
```powershell
PS C:\> Publish-PASTheme -ThemeName SomeTheme
```

Update the draft state of SomeTheme

## PARAMETERS

### -ThemeName
The name of the custom theme to update its draft state.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
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

[https://pspas.pspete.dev/commands/Publish-PASTheme](https://pspas.pspete.dev/commands/Publish-PASTheme)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/sdk/rest-api-cust-ui-themes-update-draft.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/sdk/rest-api-cust-ui-themes-update-draft.htm)
