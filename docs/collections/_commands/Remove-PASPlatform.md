---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Remove-PASPlatform
schema: 2.0.0
title: Remove-PASPlatform
---

# Remove-PASPlatform

## SYNOPSIS
Deletes a platform.

## SYNTAX

### targets
```
Remove-PASPlatform [-TargetPlatform] -ID <Int32> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### dependents
```
Remove-PASPlatform [-DependentPlatform] -ID <Int32> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### groups
```
Remove-PASPlatform [-GroupPlatform] -ID <Int32> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### rotationalGroups
```
Remove-PASPlatform [-RotationalGroup] -ID <Int32> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deletes, target, dependent, group or rotational group platform.

## EXAMPLES

### EXAMPLE 1
```
Remove-PASPlatform -TargetPlatform -ID 9
```

Deletes Target Platform with ID of 9

### EXAMPLE 2
```
Remove-PASPlatform -DependentPlatform -ID 9
```

Deletes Dependent Platform with ID of 9

### EXAMPLE 3
```
Remove-PASPlatform -GroupPlatform -ID 39
```

Deletes Group Platform with ID of 39

### EXAMPLE 4
```
Remove-PASPlatform -RotationalGroup -ID 59
```

Deletes Rotational Group Platform with ID of 59

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

### -DependentPlatform
Specify if ID relates to Dependent platform

```yaml
Type: SwitchParameter
Parameter Sets: dependents
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
The unique ID number of the platform to delete.

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

[https://pspas.pspete.dev/commands/Remove-PASPlatform](https://pspas.pspete.dev/commands/Remove-PASPlatform)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-delete-target-platform.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-delete-target-platform.htm)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-delete-dependent-platform.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-delete-dependent-platform.htm)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-delete-goup-platform.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-delete-goup-platform.htm)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-delete-rotational-group-platform.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-delete-rotational-group-platform.htm)
