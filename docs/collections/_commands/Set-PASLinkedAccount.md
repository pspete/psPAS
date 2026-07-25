---
category: psPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Set-PASLinkedAccount
schema: 2.0.0
title: Set-PASLinkedAccount
---

# Set-PASLinkedAccount

## SYNOPSIS
Associates one or more linked accounts to existing accounts.

## SYNTAX

```
Set-PASLinkedAccount [-AccountID] <String[]> [-safe] <String[]> [-extraPasswordIndex] <String[]>
 [-name] <String[]> [-folder] <String[]> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Associates a Reconcile account, Logon account, or other type of linked account that is defined in the platform configuration.

Multiple source accounts can be linked in a single bulk request by supplying more than one value for `-AccountID`.
Bulk linking requires CyberArk version 15.2 or later.

Requires the following Safe member authorizations:
- List accounts
  - Required for both the Safe of the linked account and the Safe of the source account.
- Update account properties.
  - Require for the Safe of the source account

Requires CyberArk Version 12.1+

## EXAMPLES

### EXAMPLE 1
```powershell
PS C:\> Set-PASLinkedAccount -AccountID 29_4 -safe Some_Safe -extraPasswordIndex 1 -name SomeAdmin -folder root
```

Adds "SomeAdmin" account from "Some_Safe" as the logon account for account with id 29_4

### EXAMPLE 2
```powershell
PS C:\> Set-PASLinkedAccount -AccountID 29_4 -safe Some_Safe -extraPasswordIndex 2 -name SomeAccount -folder root
```

Adds "SomeAccount" account from "Some_Safe" as the extrapass2 account for account with id 29_4

### EXAMPLE 3
```powershell
PS C:\> Set-PASLinkedAccount -AccountID 29_4 -safe Some_Safe -extraPasswordIndex 3 -name SomeReconcile -folder root
```

Adds "SomeReconcile" account from "Some_Safe" as the reconcile account for account with id 29_4

### EXAMPLE 4
```powershell
PS C:\> Set-PASLinkedAccount -AccountID 29_4, 30_5 -safe Some_Safe -extraPasswordIndex 1 -name SomeAdmin -folder root
```

Adds "SomeAdmin" as the logon account for accounts 29_4 and 30_5 in a single bulk request.

## PARAMETERS

### -AccountID
The AccountID of the account to associate a linked account to.

When more than one value is supplied, a bulk link request is sent.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases: id

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -safe
The Safe in which the linked account is stored.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -extraPasswordIndex
The linked account's extra password index (1,2, or 3).

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -name
The accountname of the linked account.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -folder
The folder in which the linked account is stored in it's safe.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 5
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

Bulk operations require CyberArk version 15.2 or later and are triggered when `-AccountID` contains more than one value.

## RELATED LINKS

[https://pspas.pspete.dev/commands/Set-PASLinkedAccount](https://pspas.pspete.dev/commands/Set-PASLinkedAccount)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Link-account.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Link-account.htm)
