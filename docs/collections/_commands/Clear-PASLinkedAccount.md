---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Clear-PASLinkedAccount
schema: 2.0.0
title: Clear-PASLinkedAccount
---

# Clear-PASLinkedAccount

## SYNOPSIS

Clears a linked account association.

## SYNTAX

```
Clear-PASLinkedAccount [-AccountID] <String> [-extraPasswordIndex] <Int32> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Clears the association between a linked account and a source account.

The following Safe authorizations are required on the Safe where the source account is stored to run this command:
- List accounts
- Update account properties
- Manage Safe
  - Only required when `RequireManageSafeToClearLinkedAccount` is enabled in the configuration.

## EXAMPLES

### EXAMPLE 1
```powershell
PS C:\> Clear-PASLinkedAccount -AccountID 12_34 -extraPasswordIndex 3
```

Clears extraPass3 from account with ID 12_34

## PARAMETERS

### -AccountID
The id value of the source account

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

### -extraPasswordIndex
The linked account's extra password index.

The index can be for a Reconcile account, Logon account, or other linked account that is defined in the Platform configuration.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
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

[https://pspas.pspete.dev/commands/Clear-PASLinkedAccount](https://pspas.pspete.dev/commands/Clear-PASLinkedAccount)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Link-account-unlink.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Link-account-unlink.htm)
