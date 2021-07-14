---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Request-PASJustInTimeAccess
schema: 2.0.0
title: Request-PASJustInTimeAccess
---

# Request-PASJustInTimeAccess

## SYNOPSIS
Requests JIT access to a target Windows machine

## SYNTAX

```
Request-PASJustInTimeAccess [-AccountID] <String> [<CommonParameters>]
```

## DESCRIPTION
Requests and receives access, with administrative rights, to a target Windows machine.
The domain user who requests access will be added to the local Administrators group of the target machine.

## EXAMPLES

### EXAMPLE 1
```
Request-PASJustInTimeAccess -AccountID 36_3
```

Requests JIT access on the server for which the account with id 36_3 is a local account with local admin membership.

## PARAMETERS

### -AccountID
The ID of the local account that will be used to add the logged on user to the Administrators group on the target machine.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Request-PASJustInTimeAccess](https://pspas.pspete.dev/commands/Request-PASJustInTimeAccess)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetAccess.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/GetAccess.htm)
