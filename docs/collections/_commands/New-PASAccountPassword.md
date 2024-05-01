---
category: psPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/New-PASAccountPassword
schema: 2.0.0
title: New-PASAccountPassword
---

# New-PASAccountPassword

## SYNOPSIS
Generates a new password for an existing account.

## SYNTAX

```
New-PASAccountPassword [-AccountID] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Generates a new password for an existing account.

Requires "Retrieve" safe permission for the safe where the account is stored. If using the PreventSameCharPerPrevPassPosition platform parameter, the "Use Password" permission must be held.
Requires CyberArk Version 12.0 or higher.

## EXAMPLES

### EXAMPLE 1
```powershell
PS C:\> New-PASAccountPassword -AccountID 12_3
```

Generates a new password for account with ID 12_3.

## PARAMETERS

### -AccountID
The ID of the account to generate the password for.

```yaml
Type: String
Parameter Sets: (All)
Aliases: id

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/New-PASAccountPassword](https://pspas.pspete.dev/commands/New-PASAccountPassword)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Secrets-Generate-Password.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Secrets-Generate-Password.htm)
