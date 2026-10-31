---
external help file: psPAS-help.xml
Module Name: psPAS
online version:
schema: 2.0.0
title: Find-PASUserOrGroup
---

# Find-PASUserOrGroup

## SYNOPSIS
Searches for users and groups

## SYNTAX

```
Find-PASUserOrGroup [-search <String>] [-memberType <String>] [-directorySource <String>] [-sort <String>] [-limit <Int32>] [<CommonParameters>]
```

## DESCRIPTION
Searches vault and directory users and groups.

Requires CyberArk Version 15.2 or higher.

## EXAMPLES

### EXAMPLE 1
```powershell
Find-PASUserOrGroup -search admin
```

Finds users and groups with names matching admin

### EXAMPLE 2
```powershell
Find-PASUserOrGroup -search admin -memberType group -directorySource domain.com
```

Finds groups from the domain.com directory with names matching admin

## PARAMETERS

### -search
Search text to match against user and group names

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

### -memberType
Return only users or only groups

Valid values: user, group

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

### -directorySource
Return only users and groups from the named LDAP directory

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

### -sort
The property and direction to sort results by, e.g. "name asc"

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

### -limit
The maximum number of results to return

```yaml
Type: Int32
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

## RELATED LINKS

[https://pspas.pspete.dev/commands/Find-PASUserOrGroup](https://pspas.pspete.dev/commands/Find-PASUserOrGroup)
