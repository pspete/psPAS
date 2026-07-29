---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Export-PASThemeImage
schema: 2.0.0
title: Export-PASThemeImage
---

# Export-PASThemeImage

## SYNOPSIS
Retrieves a specific image.

## SYNTAX

```
Export-PASThemeImage [-imageName] <String> [-Path] <String> [<CommonParameters>]
```

## DESCRIPTION
Retrieves a specific image.

Requires Vault Admin Privileges

## EXAMPLES

### Example 1
```powershell
PS C:\> Export-PASThemeImage -imageName SomeImage -Path C:\SomeFolder
```

Retrieves the theme image to the specified location

### Example 2
```powershell
PS C:\> Export-PASThemeImage -imageName CompanyLogo -Path C:\Images\CompanyLogo.png
```

Retrieves the "CompanyLogo" image and saves it to the exact file specified, rather than a destination folder

### Example 3
```powershell
PS C:\> "MainLogo", "LoginBackground", "FooterIcon" | ForEach-Object { Export-PASThemeImage -imageName $_ -Path C:\Images }
```

Retrieves each of the named theme images and saves them to the C:\Images folder

### Example 4
```powershell
PS C:\> [PSCustomObject]@{imageName = 'CompanyLogo'; Path = 'C:\Images\CompanyLogo.png'} | Export-PASThemeImage
```

Retrieves the "CompanyLogo" image, with the imageName and Path values supplied via the pipeline

## PARAMETERS

### -imageName
The name of the image to retrieve

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

### -Path
The folder to export the image to.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Export-PASThemeImage](https://pspas.pspete.dev/commands/Export-PASThemeImage)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/sdk/rest-api-cust-ui-images-ret-image.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/sdk/rest-api-cust-ui-images-ret-image.htm)
