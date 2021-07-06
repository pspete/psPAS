---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Enable-PASPlatform
schema: 2.0.0
title: Enable-PASPlatform
---

# Enable-PASPlatform

## SYNOPSIS
Activates a platform.

## SYNTAX

### targets
```
Enable-PASPlatform [-TargetPlatform] -ID <Int32> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### groups
```
Enable-PASPlatform [-GroupPlatform] -ID <Int32> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### rotationalGroups
```
Enable-PASPlatform [-RotationalGroup] -ID <Int32> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Enables, target, group or rotational group platform.

## EXAMPLES

### EXAMPLE 1
```
Enable-PASPlatform -TargetPlatform -ID 53
```

Enables Target Platform with ID of 53

### EXAMPLE 2
```
Enable-PASPlatform -GroupPlatform -id 64
```

Enables Group Platform with ID of 64

### EXAMPLE 3
```
Enable-PASPlatform -RotationalGroup -id 65
```

Enables Rotational Group Platform with ID of 65

## PARAMETERS

### -TargetPlatform
Specify if ID relates to Target platform

```yaml
Type: SwitchParameter
Parameter Sets: targets
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -GroupPlatform
Specify if ID relates to Group platform

```yaml
Type: SwitchParameter
Parameter Sets: groups
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -RotationalGroup
Specify if ID relates to Rotational Group platform

```yaml
Type: SwitchParameter
Parameter Sets: rotationalGroups
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ID
The unique ID number of the platform to enable.

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
PAS 11.4 minimum

## RELATED LINKS

[https://pspas.pspete.dev/commands/Enable-PASPlatform](https://pspas.pspete.dev/commands/Enable-PASPlatform)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-activate-target-platform.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-activate-target-platform.htm)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-activate-group-platform.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-activate-group-platform.htm)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-activate-rotational-group-platform.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-activate-rotational-group-platform.htm)
