---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Export-PASTicketingSystemLog
schema: 2.0.0
title: Export-PASTicketingSystemLog
---

# Export-PASTicketingSystemLog

## SYNOPSIS

Export ticketing system logs from Privilege Cloud

## SYNTAX

```
Export-PASTicketingSystemLog [[-days] <Int32>] [[-userID] <String>] [-path] <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

Export ticketing system logs collected from the Privilege Cloud Portal, for a specific user, recent period, or both.

## EXAMPLES

### Example 1

```powershell
PS C:\> Export-PASTicketingSystemLog -days 5 -path C:\SomeDirectory
```

Export the logs from the last 5 days for the privilege cloud ticketing systems

### Example 2

```powershell
PS C:\> Export-PASTicketingSystemLog -days 1 -userID TicketingUser -path C:\SomeDirectory
```

Export the logs from the previous day for the specified ticketing system user

## PARAMETERS

### -days

The number of days to include log entries from, up to a maximum of 7 days

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -userID

The unique ID of the user who requested the ticketing system.

If no user is defined, the log covers all system users.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -path

The path to save the exported logs to

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
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

[https://pspas.pspete.dev/commands/Export-PASTicketingSystemLog](https://pspas.pspete.dev/commands/Export-PASTicketingSystemLog)

[https://docs.cyberark.com/privilege-cloud-shared-services/latest/en/content/privilegecloudapis/privcloud-ticketing-systems-custom-export-logs.htm](https://docs.cyberark.com/privilege-cloud-shared-services/latest/en/content/privilegecloudapis/privcloud-ticketing-systems-custom-export-logs.htm)
