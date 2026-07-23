---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Remove-PASDiscoveryScanDefinition
schema: 2.0.0
title: Remove-PASDiscoveryScanDefinition
---

# Remove-PASDiscoveryScanDefinition

## SYNOPSIS

Delete a scan definition

## SYNTAX

```
Remove-PASDiscoveryScanDefinition [-id] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Delete a scan definition

## EXAMPLES

### Example 1

```powershell
PS C:\> Remove-PASDiscoveryScanDefinition -id 1234
```

Delete a scan definition

## PARAMETERS

### -id

The id of the scan definition to delete

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
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

[https://pspas.pspete.dev/commands/Remove-PASDiscoveryScanDefinition](https://pspas.pspete.dev/commands/Remove-PASDiscoveryScanDefinition)

[https://docs.cyberark.com/identity-protection-space/latest/en/content/discovery/discovery-apis/discovery-deletescandefinition.htm](https://docs.cyberark.com/identity-protection-space/latest/en/content/discovery/discovery-apis/discovery-deletescandefinition.htm)
