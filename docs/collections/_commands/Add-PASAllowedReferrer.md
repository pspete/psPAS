---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Add-PASAllowedReferrer
schema: 2.0.0
title: Add-PASAllowedReferrer
---

# Add-PASAllowedReferrer

## SYNOPSIS
Adds an entry to the allowed referrer list.

## SYNTAX

```
Add-PASAllowedReferrer [-referrerURL] <String> [[-regularExpression] <Boolean>] [<CommonParameters>]
```

## DESCRIPTION
Adds a new web application URL to the allowed referrer list.

Vault admins group membership required.

## EXAMPLES

### EXAMPLE 1
```
Add-PASAllowedReferrer -referrerURL "https://CompanyA/portal/"
```

Adds portal URL which permits access from any page or sub-directory

### EXAMPLE 2
```
Add-PASAllowedReferrer -referrerURL "https://CompanyB/management/dashboard"
```

Adds URL that only allows access from a specific page

## PARAMETERS

### -referrerURL
A URL from where access to PVWA will be allowed:

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

### -regularExpression
Whether or not the URL is a regular expression.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Add-PASAllowedReferrer](https://pspas.pspete.dev/commands/Add-PASAllowedReferrer)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Add_Allowed_Referrer.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Add_Allowed_Referrer.htm)
