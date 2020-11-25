---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Unlock-PASAccount
schema: 2.0.0
title: Unlock-PASAccount
---

# Unlock-PASAccount

## SYNOPSIS
Checks in an exclusive account in to the Vault.

## SYNTAX

```
Unlock-PASAccount [-AccountID] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Checks in an account, locked due to an exclusive account policy, to the Vault.

If the account is managed automatically by the CPM, after it is checked in,the password is changed immediately.

If the account is managed manually, a notification is sent to a user who is authorised to change the password.

The account is checked in automatically after it has been changed.

Requires Initiate CPM password management operations on the Safe where the account is stored.

## EXAMPLES

### EXAMPLE 1
```
Unlock-PASAccount -AccountID 21_3
```

Will check-in exclusive access account with ID of "21_3"

### EXAMPLE 2
```
Get-PASAccount xAccount | Unlock-PASAccount
```

Will check-in exclusive access account xAccount

## PARAMETERS

### -AccountID
The unique ID of the account.

This is retrieved by the Get-PASAccount function.

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
Minimum CyberArk version 9.10

## RELATED LINKS

[https://pspas.pspete.dev/commands/Unlock-PASAccount](https://pspas.pspete.dev/commands/Unlock-PASAccount)

