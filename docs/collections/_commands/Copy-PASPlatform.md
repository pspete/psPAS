---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Copy-PASPlatform
schema: 2.0.0
title: Copy-PASPlatform
---

# Copy-PASPlatform

## SYNOPSIS
Duplicates a platform

## SYNTAX

### targets
```
Copy-PASPlatform [-TargetPlatform] -ID <Int32> -name <String> [-description <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### dependents
```
Copy-PASPlatform [-DependentPlatform] -ID <Int32> -name <String> [-description <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### groups
```
Copy-PASPlatform [-GroupPlatform] -ID <Int32> -name <String> [-description <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### rotationalGroups
```
Copy-PASPlatform [-RotationalGroup] -ID <Int32> -name <String> [-description <String>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Duplicates target, dependent, group or rotational group platform to a new platform.

## EXAMPLES

### EXAMPLE 1
```
Copy-PASPlatform -TargetPlatform -ID 9 -name SomeNewPlatform -description "Some Description"
```

Duplicates Target Platform with ID of 9 to SomeNewPlatform

### EXAMPLE 2
```
Copy-PASPlatform -DependentPlatform -ID 9 -name SomeNewPlatform -description "Some Description"
```

Duplicates Dependent Platform with ID of 9 to SomeNewPlatform

### EXAMPLE 3
```
Copy-PASPlatform -GroupPlatform -ID 39 -name SomeNewPlatform -description "Some Description"
```

Duplicates Group Platform with ID of 39 to SomeNewPlatform

### EXAMPLE 4
```
Copy-PASPlatform -RotationalGroup -ID 59 -name SomeNewPlatform -description "Some Description"
```

Duplicates Rotational Group Platform with ID of 59 to SomeNewPlatform

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
The unique ID number of the platform to duplicate

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

### -name
The name for the duplicate platform

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

### -description
A description for the duplicate platform

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
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
Minimum version 11.4

## RELATED LINKS

[https://pspas.pspete.dev/commands/Copy-PASPlatform](https://pspas.pspete.dev/commands/Copy-PASPlatform)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-duplicate-target-platforms.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-duplicate-target-platforms.htm)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-duplicate-dependent-platforms.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-duplicate-dependent-platforms.htm)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-duplicate-group-platforms.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-duplicate-group-platforms.htm)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-duplicate-rotational-group-platforms.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/rest-api-duplicate-rotational-group-platforms.htm)
