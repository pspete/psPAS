---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Import-PASThemeImage
schema: 2.0.0
title: Import-PASThemeImage
---

# Import-PASThemeImage

## SYNOPSIS
Adds an image used by a theme

## SYNTAX

```
Import-PASThemeImage [-Name] <String> [-ImageFile] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Adds an image used by a theme to the system.

Requires Vault Admin Privileges

## EXAMPLES

### Example 1
```powershell
PS C:\> Import-PASThemeImage -Name SomeImage -ImageFile SomeImageFile.png
```

Adds SomeImageFile.png to the system for use in a theme

## PARAMETERS

### -Name
The name of the image

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

### -ImageFile
The image file to add

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
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

[https://pspas.pspete.dev/commands/Import-PASThemeImage](https://pspas.pspete.dev/commands/Import-PASThemeImage)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/sdk/rest-api-cust-ui-images-add-image.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/sdk/rest-api-cust-ui-images-add-image.htm)
