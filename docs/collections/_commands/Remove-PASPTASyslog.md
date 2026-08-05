---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Remove-PASPTASyslog
schema: 2.0.0
title: Remove-PASPTASyslog
---

# Remove-PASPTASyslog

## SYNOPSIS
Removes SYSLOG configuration from PTA

## SYNTAX

```
Remove-PASPTASyslog [-ID] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Removes a SYSLOG configuration from PTA

## EXAMPLES

### Example 1
```powershell
Remove-PASPTASyslog -ID SomeID
```

Removes specified SYSLOG configuration from PTA

### Example 2
```powershell
Remove-PASPTASyslog -ID 65f2a1c3b8e4a900123abcde -WhatIf
```

Shows what would happen if the SYSLOG configuration with the specified ID were removed, without making the change

### Example 3
```powershell
[PSCustomObject]@{ID = '65f2a1c3b8e4a900123abcde'} | Remove-PASPTASyslog
```

Removes the SYSLOG configuration using an ID value supplied via the pipeline

## PARAMETERS

### -ID
The ID of the SYSLOG configuration to delete

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

[https://pspas.pspete.dev/commands/Remove-PASPTASyslog](https://pspas.pspete.dev/commands/Remove-PASPTASyslog)
