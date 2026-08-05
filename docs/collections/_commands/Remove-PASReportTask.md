---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Remove-PASReportTask
schema: 2.0.0
---

# Remove-PASReportTask

## SYNOPSIS

Removes a report schedule.

## SYNTAX

```
Remove-PASReportTask [-id] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Removes an existing report schedule by ID.

This command requires CyberArk version 14.6 or later.

## EXAMPLES

### Example 1

```powershell
Remove-PASReportTask -id 12345
```

Removes the report schedule with the specified ID.

### Example 2

```powershell
Get-PASReportTask -name 'Some Report' | Remove-PASReportTask
```

Finds the report schedule named "Some Report" and removes it via the pipeline.

### Example 3

```powershell
Remove-PASReportTask -id 12345 -WhatIf
```

Shows what would happen if the report schedule with ID 12345 was removed, without actually removing it.

## PARAMETERS

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

### -WhatIf

Shows what would happen if the cmdlet runs. The cmdlet is not run.

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

### -id

The unique ID of the report schedule to remove.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

You can pipe objects with an `id` property to this command.

## OUTPUTS

### None

## NOTES

Minimum CyberArk version 14.6

## RELATED LINKS

[Remove-PASReportTask](https://pspas.pspete.dev/commands/Remove-PASReportTask)
