---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Remove-PASApplication
schema: 2.0.0
title: Remove-PASApplication
---

# Remove-PASApplication

## SYNOPSIS
Deletes an application

## SYNTAX

```
Remove-PASApplication [-AppID] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deletes a specific application.

"Manage Users" permission is required to be held.

## EXAMPLES

### EXAMPLE 1
```
Remove-PASApplication -AppID NewApp
```

Deletes application "NewApp"

## PARAMETERS

### -AppID
The name of the application to delete.

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

[https://pspas.pspete.dev/commands/Remove-PASApplication](https://pspas.pspete.dev/commands/Remove-PASApplication)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Delete%20a%20Specific%20Application.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Delete%20a%20Specific%20Application.htm)
