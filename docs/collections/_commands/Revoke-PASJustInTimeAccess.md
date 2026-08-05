---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Revoke-PASJustInTimeAccess
schema: 2.0.0
title: Revoke-PASJustInTimeAccess
---

# Revoke-PASJustInTimeAccess

## SYNOPSIS
Revoke JIT access to a target Windows machine

## SYNTAX

```
Revoke-PASJustInTimeAccess [-AccountID] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Requests and receives access, with administrative rights, to a target Windows machine.
The domain user who issuing the command will be removed from the local Administrators group of the target machine.

## EXAMPLES

### EXAMPLE 1
```
Revoke-PASJustInTimeAccess -AccountID 36_3
```

Revokes JIT access on the server for which the account with id 36_3 is a local account with local admin membership.

### EXAMPLE 2
```
Get-PASAccount -id 36_3 | Revoke-PASJustInTimeAccess
```

Revokes JIT access using the account object returned by Get-PASAccount.

### EXAMPLE 3
```
'36_3', '44_9' | ForEach-Object { Revoke-PASJustInTimeAccess -AccountID $_ }
```

Revokes JIT access for each of the specified local admin accounts.

## PARAMETERS

### -AccountID
The ID of the local account that will be used to remove the authenticated user from the Administrators group on the target machine.

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

[https://pspas.pspete.dev/commands/Revoke-PASJustInTimeAccess](https://pspas.pspete.dev/commands/Revoke-PASJustInTimeAccess)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetAccess.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetAccess.htm)
