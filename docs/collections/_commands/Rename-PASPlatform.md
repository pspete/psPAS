---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Rename-PASPlatform
schema: 2.0.0
title: Rename-PASPlatform
---

# Rename-PASPlatform

## SYNOPSIS
Renames a target platform.

## SYNTAX

```
Rename-PASPlatform -ID <Int32> -Name <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Renames an existing target platform.

The user must be a member of the Vault Admins group.

This command is only applicable to Self-Hosted implementations.

## EXAMPLES

### EXAMPLE 1
```
Rename-PASPlatform -ID 42 -Name "NewPlatformName"
```

Renames the target platform with ID 42 to "NewPlatformName"

### EXAMPLE 2
```
Get-PASPlatform -PlatformType Target | Where-Object {$_.Name -eq "OldName"} | Rename-PASPlatform -Name "NewName"
```

Finds a target platform by name and renames it

## PARAMETERS

### -ID
The unique ID of the platform to rename.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Name
The new name for the platform.

Platform names must be unique across the system.

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
Minimum version 15.0

Self-Hosted implementations only

## RELATED LINKS

[https://pspas.pspete.dev/commands/Rename-PASPlatform](https://pspas.pspete.dev/commands/Rename-PASPlatform)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/sdk/rest-api-update-target-platform.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/sdk/rest-api-update-target-platform.htm)
