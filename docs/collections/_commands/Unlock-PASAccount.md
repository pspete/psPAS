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
Checks-in an exclusive access account, or unlocks an account checked-out or locked by another user.

## SYNTAX

### CheckIn (Default)
```
Unlock-PASAccount [-AccountID] <String> [-CheckIn] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Unlock
```
Unlock-PASAccount [-AccountID] <String> [-Unlock] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Unlocks or Checks in an account, locked due to an exclusive account policy, to the Vault.

If the account is managed automatically by the CPM, after it is checked in,the password is changed immediately.

If the account is managed manually, a notification is sent to a user who is authorised to change the password.

The account is checked in automatically after it has been changed.

Requires Initiate CPM password management operations on the Safe where the account is stored.

Where a user holds the "Unlock Account" permission on a safe, they may use this function to issue an "Unlock" command on an account checked out or locked by another user.

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

### EXAMPLE 3
```
Unlock-PASAccount -AccountID 21_3 -Unlock
```

Unlocks account with ID of "21_3" when locked by another user.

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

### -CheckIn
Specifies that the account should be Checked-In

```yaml
Type: SwitchParameter
Parameter Sets: CheckIn
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -Unlock
Specifies that the account should be unlocked

```yaml
Type: SwitchParameter
Parameter Sets: Unlock
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES
Minimum CyberArk version 9.10 (Check-In Account)
Minimum CyberArk version 11.6 (Unlock Account)

## RELATED LINKS

[https://pspas.pspete.dev/commands/Unlock-PASAccount](https://pspas.pspete.dev/commands/Unlock-PASAccount)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Checkin-account.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Checkin-account.htm)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/pas/Latest/en/Content/PASIMP/AutoUnlockinPSM.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/pas/Latest/en/Content/PASIMP/AutoUnlockinPSM.htm)

[https://docs.cyberark.com/PAS/Latest/en/Content/SDK/Unlock-account.htm](https://docs.cyberark.com/PAS/Latest/en/Content/SDK/Unlock-account.htm)

