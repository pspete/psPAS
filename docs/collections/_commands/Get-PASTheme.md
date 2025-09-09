---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASTheme
schema: 2.0.0
title: Get-PASTheme
---

# Get-PASTheme

## SYNOPSIS
Return Custom Theme Details

## SYNTAX

### byAll (Default)
```
Get-PASTheme [-FindAll] [<CommonParameters>]
```

### ByName
```
Get-PASTheme -ThemeName <String> [<CommonParameters>]
```

### ByActive
```
Get-PASTheme [-Active] [<CommonParameters>]
```

## DESCRIPTION
Returns a list of all available custom themes, a specific theme, or the current active theme.

Requires Membership of the Vault Admin group.

## EXAMPLES

### Example 1
```powershell
PS C:\> Get-PASTheme
```

Return all available custom themes

### Example 2
```powershell
PS C:\> Get-PASTheme -ThemeName SomeTheme
```

Return details of the specified theme

### Example 3
```powershell
PS C:\> Get-PASTheme -Active
```

Return details fo the active theme

## PARAMETERS

### -ThemeName
The name of the theme to return details of

```yaml
Type: String
Parameter Sets: ByName
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Active
Specify to return the details of the currently active theme

```yaml
Type: SwitchParameter
Parameter Sets: ByActive
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -FindAll
Specify to return the details of all available themes

```yaml
Type: SwitchParameter
Parameter Sets: byAll
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASTheme](https://pspas.pspete.dev/commands/Get-PASTheme)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/sdk/rest-api-cust-ui-themes-ret-list.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/sdk/rest-api-cust-ui-themes-ret-list.htm)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/sdk/rest-api-cust-ui-themes-ret-theme.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/sdk/rest-api-cust-ui-themes-ret-theme.htm)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/sdk/rest-api-cust-ui-themes-ret-current.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/sdk/rest-api-cust-ui-themes-ret-current.htm)
