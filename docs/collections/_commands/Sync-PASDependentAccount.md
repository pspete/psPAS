---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Sync-PASDependentAccount
schema: 2.0.0
title: Sync-PASDependentAccount
---

# Sync-PASDependentAccount

## SYNOPSIS

This syncs the dependent account secret with its master account.

## SYNTAX

```
Sync-PASDependentAccount [-accountId] <String> [-dependentAccountId] <String> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION

Syncs the dependent account secret with its master account.

The user performing this task must have the following permissions in the Safe where the privileged account is stored:

Initiate CPM password management operations

Requires minimum version 14.6.

## EXAMPLES

### EXAMPLE 1

```powershell
PS C:\> Sync-PASDependentAccount -accountId 12_34 -dependentAccountId 56_78
```
Synchronizes the password of dependent account with ID 56_78 with its parent account 12_34.

## PARAMETERS

### -accountId

The ID of the parent account whose password will be synchronized to the dependent account.

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

### -dependentAccountId

The ID of the dependent account that will receive the synchronized password from the parent account.

```yaml
Type: String
Parameter Sets: (All)
Aliases: dependentid

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
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

Requires minimum version 14.6

## RELATED LINKS

[https://pspas.pspete.dev/commands/Sync-PASDependentAccount](https://pspas.pspete.dev/commands/Sync-PASDependentAccount)

[https://docs.cyberark.com/PAS/Latest/en/Content/WebServices/Dependent-Accounts.htm](https://docs.cyberark.com/PAS/Latest/en/Content/WebServices/Dependent-Accounts.htm)
