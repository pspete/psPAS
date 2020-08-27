---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASGroup
schema: 2.0.0
title: Get-PASGroup
---

# Get-PASGroup

## SYNOPSIS
List groups from the vault

## SYNTAX

### groupType (Default)
```
Get-PASGroup [-groupType <String>] [-search <String>] [<CommonParameters>]
```

### filter
```
Get-PASGroup [-filter <String>] [-search <String>] [<CommonParameters>]
```

## DESCRIPTION
Returns a list of all existing user groups.

The user performing this task:
- Must have Audit users permissions in the Vault.
- Can see groups either only on the same level, or lower in the Vault hierarchy.

## EXAMPLES

### EXAMPLE 1
```
Get-PASGroup
```

Returns all existing groups

### EXAMPLE 2
```
Get-PASGroup -groupType Directory
```

Returns all existing Directory groups

### EXAMPLE 3
```
Get-PASGroup -groupType Vault
```

Returns all existing Vault groups

### EXAMPLE 4
```
Get-PASGroup -filter 'groupType eq Directory'
```

Returns all existing Directory groups

### EXAMPLE 5
```
Get-PASGroup -search "Vault Admins"
```

Returns all groups matching all search terms

### EXAMPLE 6
```
Get-PASGroup -search "Vault Admins" -groupType Directory
```

Returns all existing Directory groups matching all search terms

## PARAMETERS

### -groupType
Search for groups which are from a configured Directory or from the Vault.

```yaml
Type: String
Parameter Sets: groupType
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -filter
Filter according to REST standard.

*depreciated parameter in psPAS - filter value will automatically be set with if groupType specified.

```yaml
Type: String
Parameter Sets: filter
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -search
Search will match when ALL search terms appear in the group name.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Minimum Version 10.5

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASGroup](https://pspas.pspete.dev/commands/Get-PASGroup)

