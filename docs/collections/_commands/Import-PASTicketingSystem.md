---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Import-PASTicketingSystem
schema: 2.0.0
title: Import-PASTicketingSystem
---

# Import-PASTicketingSystem

## SYNOPSIS

Imports a ticketing system into Privilege Cloud.

## SYNTAX

```
Import-PASTicketingSystem [-ImportFile] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION

Imports a custom ticketing system that is not supported by default.

## EXAMPLES

### Example 1

```powershell
PS C:\> Import-PASTicketingSystem -ImportFile C:\CustomTicketingSystem.zip
```

Imports the custom ticketing system defined in the CustomTicketingSystem.zip package

## PARAMETERS

### -ImportFile

A zip file that contains .dll and .xml files to configure the custom ticketing system.

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

[https://pspas.pspete.dev/commands/Import-PASTicketingSystem](https://pspas.pspete.dev/commands/Import-PASTicketingSystem)

[https://docs.cyberark.com/privilege-cloud-shared-services/latest/en/content/privilegecloudapis/privcloud-ticketing-systems-custom-import.htm](https://docs.cyberark.com/privilege-cloud-shared-services/latest/en/content/privilegecloudapis/privcloud-ticketing-systems-custom-import.htm)
