---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Add-PASApplication
schema: 2.0.0
title: Add-PASApplication
---

# Add-PASApplication

## SYNOPSIS
Adds a new application to the Vault

## SYNTAX

```
Add-PASApplication [-AppID] <String> [[-Description] <String>] [-Location] <String>
 [[-AccessPermittedFrom] <Int32>] [[-AccessPermittedTo] <Int32>] [[-ExpirationDate] <DateTime>]
 [[-Disabled] <Boolean>] [[-BusinessOwnerFName] <String>] [[-BusinessOwnerLName] <String>]
 [[-BusinessOwnerEmail] <String>] [[-BusinessOwnerPhone] <String>] [<CommonParameters>]
```

## DESCRIPTION
Adds a new application to the Vault.

Manage Users permission is required.

## EXAMPLES

### EXAMPLE 1
```
Add-PASApplication -AppID NewApp -Description "A new application" -Location "\" `
```

-AccessPermittedFrom 9 -AccessPermittedTo 17 -BusinessOwnerEmail 'appowner@company.com'

Will add a new application called "NewApp", in the root location, accessible from 9am to 5pm

## PARAMETERS

### -AppID
The application name.

Must be fewer than 128 characters.

Cannot include ampersand ("&") character.

Can include "@" character, but any searches for applications cannot include this character.

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

### -Description
Description of the application, no longer than 99 characters.

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

### -Location
The location of the application in the vault hierarchy.

Note: to insert a backslash in the location path, use a double backslash.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AccessPermittedFrom
The start hour that access is permitted to the application.

Valid values are 0-23.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AccessPermittedTo
The end hour that access to the application is permitted.

Valid values are 0-23.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ExpirationDate
The date when the application expires.

```yaml
Type: DateTime
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Disabled
Boolean value, denoting if the application is disabled or not.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -BusinessOwnerFName
The first name of the business owner.

Specify up to 29 characters.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -BusinessOwnerLName
The last name of the business owner.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -BusinessOwnerEmail
The email address of the business owner

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -BusinessOwnerPhone
The phone number of the business owner.

Specify up to 24 characters.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
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

[https://pspas.pspete.dev/commands/Add-PASApplication](https://pspas.pspete.dev/commands/Add-PASApplication)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Add%20Application.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Add%20Application.htm)
