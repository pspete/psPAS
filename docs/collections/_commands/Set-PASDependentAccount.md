---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Set-PASDependentAccount
schema: 2.0.0
title: Set-PASDependentAccount
---

# Set-PASDependentAccount

## SYNOPSIS
Updates a Dependent Account

## SYNTAX

```
Set-PASDependentAccount [-accountId] <String> [-dependentAccountId] <String> [[-name] <String>]
 [[-platformAccountProperties] <Hashtable>] [[-automaticManagementEnabled] <Boolean>]
 [[-manualManagementReason] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates an existing dependent account.

Requires the Update account properties permission for the Account.

## EXAMPLES

### Example 1
```powershell
PS C:\> Set-PASDependentAccount -accountId 123_45 -dependentAccountId 123_560 -name SomeNewName
 -platformAccountProperties @{"Property"="Value"} -automaticManagementEnabled $false
 -manualManagementReason "Some Reason"
```

Updates the Dependent Account with the specified values

## PARAMETERS

### -accountId
The account ID of the master account

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
The unique ID of the dependent account

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

### -name
The name of the dependent account

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -platformAccountProperties
Hashtable of mandatory and optional parameters of the dependent account, based on the platform.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -automaticManagementEnabled
Whether the account secret is automatically managed by the CPM

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -manualManagementReason
The reason for disabling automatic secret management

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
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

[https://pspas.pspete.dev/commands/Set-PASDependentAccount](https://pspas.pspete.dev/commands/Set-PASDependentAccount)

[(https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/update-dependent-account.htm)](https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/update-dependent-account.htm)
