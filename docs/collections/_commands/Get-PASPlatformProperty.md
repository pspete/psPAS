---
external help file: psPAS-help.xml
Module Name: psPAS
online version:
schema: 2.0.0
title: Get-PASPlatformProperty
---

# Get-PASPlatformProperty

## SYNOPSIS
Gets the account properties of a platform

## SYNTAX

```
Get-PASPlatformProperty -PlatformID <String> [<CommonParameters>]
```

## DESCRIPTION
Gets the required and optional account properties defined by a platform.

Requires CyberArk Version 15.2 or higher.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-PASPlatformProperty -PlatformID UnixSSH
```

Gets the required and optional account properties of the UnixSSH platform

### EXAMPLE 2
```powershell
Get-PASPlatform | Get-PASPlatformProperty
```

Gets the required and optional account properties of every target platform

## PARAMETERS

### -PlatformID
The ID of the platform

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
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

[https://pspas.pspete.dev/commands/Get-PASPlatformProperty](https://pspas.pspete.dev/commands/Get-PASPlatformProperty)
