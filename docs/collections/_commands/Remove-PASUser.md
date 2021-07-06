---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Remove-PASUser
schema: 2.0.0
title: Remove-PASUser
---

# Remove-PASUser

## SYNOPSIS
Deletes a vault user

## SYNTAX

### Gen2 (Default)
```
Remove-PASUser -id <Int32> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Gen1
```
Remove-PASUser -UserName <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deletes an existing user from the vault

Default operation using the Gen2 API requires minimum version of 11.1

## EXAMPLES

### EXAMPLE 1
```
Remove-PASUser -id 1234
```

Deletes vault user with id 1234

Minimum required version 11.1

### EXAMPLE 2
```
Remove-PASUser -UserName This_User
```

Deletes vault user "This_User"

## PARAMETERS

### -id
The numeric id of the user to delete.

Minimum required version 11.1

```yaml
Type: Int32
Parameter Sets: Gen2
Aliases:

Required: True
Position: Named
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -UserName
The name of the user to delete from the vault

Should be specified for versions earlier than 11.1

```yaml
Type: String
Parameter Sets: Gen1
Aliases:

Required: True
Position: Named
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

[https://pspas.pspete.dev/commands/Remove-PASUser](https://pspas.pspete.dev/commands/Remove-PASUser)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Users%20Web%20Services%20-%20Delete%20User.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Users%20Web%20Services%20-%20Delete%20User.htm)
