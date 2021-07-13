---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASPlatformSafe
schema: 2.0.0
title: Get-PASPlatformSafe
---

# Get-PASPlatformSafe

## SYNOPSIS
Get safes by platform id

## SYNTAX

```
Get-PASPlatformSafe [-PlatformID] <String> [<CommonParameters>]
```

## DESCRIPTION
Returns all safes for a given platform ID

## EXAMPLES

### EXAMPLE 1
```
Get-PASPlatformSafe -PlatformID WINDOMAIN
```

## PARAMETERS

### -PlatformID
The unique ID/Name of the platform.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Minimum CyberArk version 11.1

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASPlatformSafe](https://pspas.pspete.dev/commands/Get-PASPlatformSafe)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-get-safe-by-platform.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-get-safe-by-platform.htm)
