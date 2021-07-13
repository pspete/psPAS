---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASPlatformPSMConfigSession%20Mngmnt%20-%20Get_Session_Management_Policy_Platform.htm
schema: 2.0.0
title: Get-PASPlatformPSMConfig
---

# Get-PASPlatformPSMConfig

## SYNOPSIS
Lists PSM Policy Section of a target platform.

## SYNTAX

```
Get-PASPlatformPSMConfig [-ID] <Int32> [<CommonParameters>]
```

## DESCRIPTION
Allows Vault admins to retrieve the PSM Policy Section of a target platform.

## EXAMPLES

### EXAMPLE 1
```
Get-PASPlatformPSMConfig -ID 42
```

Lists PSM Policy Section of target platform with ID of 42.

## PARAMETERS

### -ID
The numeric ID of the target platform to list PSM Policy of.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASPlatformPSMConfig](https://pspas.pspete.dev/commands/Get-PASPlatformPSMConfig)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Session%20Mngmnt%20-%20Get_Session_Management_Policy_Platform.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Session%20Mngmnt%20-%20Get_Session_Management_Policy_Platform.htm)

