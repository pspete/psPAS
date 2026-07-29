---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Export-PASPlatform
schema: 2.0.0
title: Export-PASPlatform
---

# Export-PASPlatform

## SYNOPSIS
Export a platform

## SYNTAX

### PlatformID
```
Export-PASPlatform [-PlatformID] <String> [-path] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### RotationalGroupID
```
Export-PASPlatform [-RotationalGroupID <String>] [-path] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### DependentID
```
Export-PASPlatform [-DependentID <Int32>] [-path] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### GroupPlatformID
```
Export-PASPlatform [-GroupPlatformID <String>] [-path] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Export a platform to a zip file in order to import it to a different Vault environment.

Vault Admin group membership required.

## EXAMPLES

### EXAMPLE 1
```
Export-PASPlatform -PlatformID YourPlatform -Path C:\Platform.zip
```

Exports UnixSSH to Platform.zip platform package.

### EXAMPLE 2
```
Export-PASPlatform -RotationalGroupID RotGroup1 -path C:\Platforms\RotGroup1.zip
```

Exports the rotational group platform with ID "RotGroup1" to RotGroup1.zip.

### EXAMPLE 3
```
Export-PASPlatform -DependentID 15 -path C:\Platforms\DependentPlatform15.zip
```

Exports the dependent platform with ID 15 to DependentPlatform15.zip.

### EXAMPLE 4
```
Export-PASPlatform -GroupPlatformID GroupPlatform1 -path C:\Platforms
```

Exports the group platform "GroupPlatform1" to the C:\Platforms folder, using the platform's own file name.

## PARAMETERS

### -PlatformID
The name of the platform.

```yaml
Type: String
Parameter Sets: PlatformID
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -path
The path to export the platform configuration to.
If the path includes a file name and extension, the platform is saved to that exact file; otherwise the path is treated as a destination folder.

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

### -DependentID
Exports a Dependent platform

```yaml
Type: Int32
Parameter Sets: DependentID
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -GroupPlatformID
Exports a Group platform

```yaml
Type: String
Parameter Sets: GroupPlatformID
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -RotationalGroupID
Exports a Rotational Group platform

```yaml
Type: String
Parameter Sets: RotationalGroupID
Aliases:

Required: False
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
Minimum CyberArk version 10.4

## RELATED LINKS

[https://pspas.pspete.dev/commands/Export-PASPlatform](https://pspas.pspete.dev/commands/Export-PASPlatform)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/ExportPlatform.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/ExportPlatform.htm)
