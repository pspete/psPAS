---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Remove-PASApplicationAuthenticationMethod
schema: 2.0.0
title: Remove-PASApplicationAuthenticationMethod
---

# Remove-PASApplicationAuthenticationMethod

## SYNOPSIS
Deletes an authentication method from an application

## SYNTAX

```
Remove-PASApplicationAuthenticationMethod [-AppID] <String> [-AuthID] <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Deletes a specific authentication method from a defined application.

"Manage Users" permission is required.

## EXAMPLES

### EXAMPLE 1
```
Remove-PASApplicationAuthenticationMethod -AppID NewApp -AuthID 1
```

Deletes authentication method with ID of 1 from "NewApp"

### EXAMPLE 2
```
Get-PASApplicationAuthenticationMethod -AppID NewApp | Remove-PASApplicationAuthenticationMethod
```

Deletes all authentication methods from "NewApp"

## PARAMETERS

### -AppID
The ID of the application in which the authentication will be deleted.

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

### -AuthID
The unique ID of the specific authentication.

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

## RELATED LINKS

[https://pspas.pspete.dev/commands/Remove-PASApplicationAuthenticationMethod](https://pspas.pspete.dev/commands/Remove-PASApplicationAuthenticationMethod)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Delete%20a%20Specific%20Authentication.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Delete%20a%20Specific%20Authentication.htm)
