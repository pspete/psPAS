---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Set-PASTheme
schema: 2.0.0
---

# Set-PASTheme

## SYNOPSIS
Updates a custom theme

## SYNTAX

```
Set-PASTheme [-ThemeName] <String> [[-name] <String>] [[-isDraft] <Boolean>] [[-mainBackgroundImage] <String>]
 [[-mainLogoDark] <String>] [[-advancedSmallLogo] <String>] [[-advancedSymbolLogo] <String>]
 [[-colorsStyle] <String>] [[-backgroundMain_Dark] <String>] [[-borderMain_Dark] <String>]
 [[-textMain_Dark] <String>] [[-disableMain_Dark] <String>] [[-disableTextPrimary_Dark] <String>]
 [[-disableBackgroundPrimary_Dark] <String>] [[-successPrimary_Dark] <String>]
 [[-successSecondary_Dark] <String>] [[-warningPrimary_Dark] <String>] [[-warningSecondary_Dark] <String>]
 [[-infoPrimary_Dark] <String>] [[-infoSecondary_Dark] <String>] [[-errorPrimary_Dark] <String>]
 [[-errorSecondary_Dark] <String>] [[-backgroundMain_Bright] <String>] [[-borderMain_Bright] <String>]
 [[-textMain_Bright] <String>] [[-disableMain_Bright] <String>] [[-disableTextPrimary_Bright] <String>]
 [[-disableBackgroundPrimary_Bright] <String>] [[-successPrimary_Bright] <String>]
 [[-successSecondary_Bright] <String>] [[-warningPrimary_Bright] <String>]
 [[-warningSecondary_Bright] <String>] [[-infoPrimary_Bright] <String>] [[-infoSecondary_Bright] <String>]
 [[-errorPrimary_Bright] <String>] [[-errorSecondary_Bright] <String>] [[-mainColor] <String>]
 [[-selectedMain] <String>] [[-hoverMain] <String>] [[-defaultButtonTextPrimary] <String>]
 [[-menuLogoBackground] <String>] [[-menuBackground] <String>] [[-menuHoverBackground] <String>]
 [[-menuActiveBackgroundPrimary] <String>] [[-menuActiveBackgroundSecondary] <String>] [[-menuText] <String>]
 [[-menuTextActive] <String>] [[-menuIcon] <String>] [[-backgroundMain] <String>] [[-borderMain] <String>]
 [[-textMain] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates an existing custom theme.

Requires membership of Vault Admins group

## EXAMPLES

### Example 1
```powershell
PS C:\> New-PASTheme -ThemeName "Barbie Pink" -name "Pink Pony Club"
```

Updates the theme name from "Barbie Pink" to "Pink Pony Club"

## PARAMETERS

### -ThemeName
The name of the existing theme to update

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

### -name
The theme name to set on the existing theme

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -isDraft
Whether the theme is marked as draft

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -mainBackgroundImage
the main background image

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -mainLogoDark
the main logo in darker colors

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -advancedSmallLogo
the advanced small logo

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -advancedSymbolLogo
the advanced symbol logo

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -colorsStyle
Type of the theme (dark or bright)

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -backgroundMain_Dark
Dark mode main background color

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -borderMain_Dark
Dark mode main border color

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -textMain_Dark
Dark mode main text color

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -disableMain_Dark
Dark mode main disable color

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -disableTextPrimary_Dark
Dark mode primary disable text color

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -disableBackgroundPrimary_Dark
Dark mode primary disable background color

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -successPrimary_Dark
Dark mode primary success color

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 15
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -successSecondary_Dark
Dark mode secondary success color

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 16
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -warningPrimary_Dark
Dark mode primary warning color

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 17
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -warningSecondary_Dark
Dark mode secondary warning color

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 18
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -infoPrimary_Dark
Dark mode primary info color

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 19
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -infoSecondary_Dark
Dark mode secondary info color

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 20
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -errorPrimary_Dark
Dark mode primary error color

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 21
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -errorSecondary_Dark
Dark mode secondary error color

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 22
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -backgroundMain_Bright
Light mode main background color

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 23
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -borderMain_Bright
Light mode main border color

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 24
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -textMain_Bright
Light mode main text color

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 25
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -disableMain_Bright
Light mode main disable color

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 26
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -disableTextPrimary_Bright
Light mode primary disable text color

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 27
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -disableBackgroundPrimary_Bright
Light mode primary disable background color

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 28
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -successPrimary_Bright
Light mode primary success color

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 29
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -successSecondary_Bright
Light mode secondary success color

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 30
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -warningPrimary_Bright
Light mode primary warning color

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 31
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -warningSecondary_Bright
Light mode secondary warning color

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 32
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -infoPrimary_Bright
Light mode primary info color

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 33
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -infoSecondary_Bright
Light mode secondary info color

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 34
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -errorPrimary_Bright
Light mode primary error color

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 35
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -errorSecondary_Bright
Light mode secondary error color

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 36
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -mainColor
The primary color of the theme

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 37
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -selectedMain
The color used for elements in their selected state

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 38
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -hoverMain
The color used for elements in their hover state

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 39
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -defaultButtonTextPrimary
The default text color used on buttons

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 40
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -menuLogoBackground
The background color of the menu logo

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 41
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -menuBackground
The background color of the menu

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 42
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -menuHoverBackground
The background color of the menu items on hover

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 43
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -menuActiveBackgroundPrimary
The primary background color of the menu items when active

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 44
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -menuActiveBackgroundSecondary
The secondary background color of the menu items when active

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 45
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -menuText
The text color of the menu items

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 46
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -menuTextActive
The text color of the menu items when active

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 47
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -menuIcon
The color of the menu icons

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 48
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -backgroundMain
The main background color

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 49
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -borderMain
The main border color

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 50
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -textMain
The main text color

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 51
Default value: None
Accept pipeline input: False
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

[https://pspas.pspete.dev/commands/Set-PASTheme](https://pspas.pspete.dev/commands/Set-PASTheme)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/sdk/rest-api-cust-ui-themes-update.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/sdk/rest-api-cust-ui-themes-update.htm)
