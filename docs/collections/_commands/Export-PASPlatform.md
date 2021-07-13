---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Export-PASPlatform
schema: 2.0.0
title: Export-PASPlatform
---

# Export-PASPlatform

## SYNOPSIS
Export a platform

## SYNTAX

```
Export-PASPlatform [-PlatformID] <String> [-path] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Export a platform to a zip file in order to import it to a different Vault environment.

Vault Admin group membership required.

## EXAMPLES

### EXAMPLE 1
```
Export-PASPlatform -PlatformID YourPlatform -Path C:\Platform.zip
```

Exports UnixSSH to Platform.zip platform package.

## PARAMETERS

### -PlatformID
The name of the platform.

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

### -path
The folder to export the platform configuration to.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
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
Minimum CyberArk version 10.4

## RELATED LINKS

[https://pspas.pspete.dev/commands/Export-PASPlatform](https://pspas.pspete.dev/commands/Export-PASPlatform)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/ExportPlatform.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/ExportPlatform.htm)
