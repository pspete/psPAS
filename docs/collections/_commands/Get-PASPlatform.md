---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASPlatform
schema: 2.0.0
title: Get-PASPlatform
---

# Get-PASPlatform

## SYNOPSIS
Retrieves details of Vault platforms.

## SYNTAX

### targets (Default)
```
Get-PASPlatform [-Active <Boolean>] [-SystemType <String>] [-PeriodicVerify <Boolean>]
 [-ManualVerify <Boolean>] [-PeriodicChange <Boolean>] [-ManualChange <Boolean>]
 [-AutomaticReconcile <Boolean>] [-ManualReconcile <Boolean>] [<CommonParameters>]
```

### platforms
```
Get-PASPlatform [-Active <Boolean>] [-PlatformType <String>] [-Search <String>] [<CommonParameters>]
```

### platform-details
```
Get-PASPlatform -PlatformID <String> [<CommonParameters>]
```

### dependents
```
Get-PASPlatform [-DependentPlatform] [<CommonParameters>]
```

### groups
```
Get-PASPlatform [-GroupPlatform] [<CommonParameters>]
```

### rotationalGroups
```
Get-PASPlatform [-RotationalGroup] [<CommonParameters>]
```

## DESCRIPTION
Request platform configuration information from the Vault.

11.4+ can return details of target, dependent, group & rotational group platforms,
with additional filters available for target group queries.

11.1+ can return details of all target platforms.

Limited filters can be used to retrieve a subset of the platforms
For 9.10+, the "PlatformID" parameter is used to retrieve details of a single
specified platform from the Vault.

The output contained under the "Details" property differs depending
on which method (9.10+,11.1+ or 11.4+) is used, and which platform type is queried.

**Note:** When specifying PlatformID:

- if the platform properties contain a semicolon (';'), the API may not return the complete value.
- noted for ChangeCommand, ReconcileCommand & ConnectionCommand properties

## EXAMPLES

### EXAMPLE 1
```
Get-PASPlatform
```

Return details of all platforms

### EXAMPLE 2
```
Get-PASPlatform -Active $true
```

Get all active platforms

### EXAMPLE 3
```
Get-PASPlatform -Active $true -Search "WIN_"
```

Get active platforms matching search string "WIN_"

### EXAMPLE 4
```
Get-PASPlatform -PlatformID "CyberArk"
```

Get details of specific platform CyberArk

### EXAMPLE 5
```
Get-PASPlatform -GroupPlatform
```

Get details of all group platforms

### EXAMPLE 6
```
Get-PASPlatform -RotationalGroup
```

Get details of all rotational group platforms

### EXAMPLE 7
```
Get-PASPlatform -DependentPlatform
```

Get details of all dependent platforms

### EXAMPLE 8
```
Get-PASPlatform -Active $false -SystemType Windows
```

Get details of all deactivated Windows platforms

### EXAMPLE 9
```
Get-PASPlatform -Active $true -SystemType '*NIX' -AutomaticReconcile $true
```

Get details of all active Unix platforms configured for automatic reconciliation.

## PARAMETERS

### -Active
Filter active/inactive platforms

```yaml
Type: Boolean
Parameter Sets: targets, platforms
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PlatformType
Filter regular/group platforms

```yaml
Type: String
Parameter Sets: platforms
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Search
Filter platform by search pattern

```yaml
Type: String
Parameter Sets: platforms
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PlatformID
The unique ID/Name of the platform.

```yaml
Type: String
Parameter Sets: platform-details
Aliases: Name

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DependentPlatform
Specify to return details of dependent platforms

```yaml
Type: SwitchParameter
Parameter Sets: dependents
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -GroupPlatform
Specify to return details of group platforms

```yaml
Type: SwitchParameter
Parameter Sets: groups
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -RotationalGroup
Specify to return details of rotational group platforms

```yaml
Type: SwitchParameter
Parameter Sets: rotationalGroups
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SystemType
Filter target platforms for specific system type

```yaml
Type: String
Parameter Sets: targets
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PeriodicVerify
Filter target platforms by periodic verification configuration

```yaml
Type: Boolean
Parameter Sets: targets
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ManualVerify
Filter target platforms by manual verification configuration

```yaml
Type: Boolean
Parameter Sets: targets
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PeriodicChange
Filter target platforms by periodic change configuration

```yaml
Type: Boolean
Parameter Sets: targets
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ManualChange
Filter target platforms by manual change configuration

```yaml
Type: Boolean
Parameter Sets: targets
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AutomaticReconcile
Filter target platforms by automatic reconciliation configuration

```yaml
Type: Boolean
Parameter Sets: targets
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ManualReconcile
Filter target platforms by manual reconciliation configuration

```yaml
Type: Boolean
Parameter Sets: targets
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Minimum CyberArk version 9.10

CyberArk version 11.1 required for Active, PlatformType & Search parameters.

CyberArk version 11.4 required for extended filters for target platforms, and requests for dependent, group & rotational group platforms

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASPlatform](https://pspas.pspete.dev/commands/Get-PASPlatform)

