---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Enable-PASPlatform
schema: 2.0.0
title: Enable-PASPlatform
---

# Enable-PASUser

## SYNOPSIS

Enables a specific vault user.

## SYNTAX

```
Enable-PASUser [-id] <Int32> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Reenables a disabled vault user

## EXAMPLES

### EXAMPLE 1
```powershell
Enable-PASUser -id 1234
```

Enables the vault user with id 1234

### EXAMPLE 2
```powershell
Get-PASUser -search Bob | Enable-PASUser
```

Finds vault users matching the search term "Bob" and enables each matching account, using the id value supplied via the pipeline

### EXAMPLE 3
```powershell
Enable-PASUser -id 1234 -WhatIf
```

Shows what would happen if the vault user with id 1234 was enabled, without making the change

### EXAMPLE 4
```powershell
Get-PASUser -UserStatus Suspended | Enable-PASUser
```

Finds all currently suspended vault users and enables each of them

## PARAMETERS

### -id
The unique numerical id of the user

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: 0
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

[https://pspas.pspete.dev/commands/Enable-PASUser](https://pspas.pspete.dev/commands/Enable-PASUser)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Enable-user.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Enable-user.htm)