---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Set-PASPlatform
schema: 2.0.0
title: Set-PASPlatform
---

# Set-PASPlatform

## SYNOPSIS
Update target platform settings.

## SYNTAX

```
Set-PASPlatform [-id] <Int32> [[-op] <String>] [[-path] <String>] [[-value] <String>]
 [[-operations] <Hashtable[]>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Allows Vault admins to update settings on a target platform.

## EXAMPLES

### EXAMPLE 1
```powershell
Set-PASPlatform -id 42 -op replace -path 'General/name' -value 'SomeName'
```

Updates the name of platform with id 42 to SomeName

### EXAMPLE 2
```powershell
$Operations = @(
    [hashtable]@{op = 'replace'; path = 'General/name'; value = 'SomeName'},
    [hashtable]@{op = 'remove'; path = 'General/description'}
)
Set-PASPlatform -id 42 -operations $Operations
```

Performs multiple update operations on platform with id 42

### EXAMPLE 3
```powershell
Set-PASPlatform -id 42 -op replace -path 'Policy/General/interval' -value '3600' -WhatIf
```

Shows what would happen if the interval setting on platform with id 42 was updated, without actually updating it.

### EXAMPLE 4
```powershell
Set-PASPlatform -id 42 -op remove -path 'Policy/additionalPolicySettings/debug'
```

Removes the debug additional policy setting from platform with id 42.

## PARAMETERS

### -id
Numeric ID of target platform

```yaml
Type: Int32
Parameter Sets: (All)
Aliases: PlatformID

Required: True
Position: 1
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -op
Patch operation to perform.

```yaml
Type: String
Parameter Sets: (All)
Aliases: Operation

Required: False
Position: 2
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -path
Platform setting path to update.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -value
Value to apply to the platform setting.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -operations
Collection of patch operations to apply to the platform settings.

```yaml
Type: Hashtable[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
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

## RELATED LINKS

[https://pspas.pspete.dev/commands/Set-PASPlatform](https://pspas.pspete.dev/commands/Set-PASPlatform)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/sdk/rest-api-update-target-platform-settings.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/sdk/rest-api-update-target-platform-settings.htm)