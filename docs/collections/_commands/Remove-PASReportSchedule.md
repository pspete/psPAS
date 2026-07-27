---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Remove-PASReportSchedule
schema: 2.0.0
---

# Remove-PASReportSchedule

## SYNOPSIS

Removes a report schedule.

## SYNTAX

```
Remove-PASReportSchedule [-id] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Removes an existing report schedule by ID.

This command requires CyberArk version 14.6 or later.

## EXAMPLES

### Example 1

```powershell
Remove-PASReportSchedule -id 12345
```

Removes the report schedule with the specified ID.

## PARAMETERS

### -id

The unique ID of the report schedule to remove.

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

### System.String

You can pipe objects with an `id` property to this command.

## OUTPUTS

### None

## NOTES

Minimum CyberArk version 14.6

## RELATED LINKS

[Remove-PASReportSchedule](https://pspas.pspete.dev/commands/Remove-PASReportSchedule)