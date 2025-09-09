---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Add-PASDependentAccount
schema: 2.0.0
title: Add-PASDependentAccount
---

# Add-PASDependentAccount

## SYNOPSIS
Adds a dependent account to an existing account

## SYNTAX

```
Add-PASDependentAccount [-AccountId] <String> [[-name] <String>] [-platformId] <String>
 [-platformAccountProperties] <Hashtable> [[-automaticManagementEnabled] <Boolean>]
 [[-manualManagementReason] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Adds a dependent account to an existing account. The dependent account is created in the same Safe and folder as the master account.

The user performing this task must have the "Add Accounts" permissions on the Safe:

## EXAMPLES

### Example 1
```powershell
PS C:\> Add-PASDependentAccount -AccountId 12_34 -name "windows-1.2.3.4-service-test" -platformId 10 -platformAccountProperties @{"address"="1.2.3.4";"servicename"="test"}
```

Adds a Dependent Account with the specified property values

## PARAMETERS

### -AccountId
The account id of the master account

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

### -name
The name of the dependent account

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -platformId
Unique identifier of the dependent platform

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -platformAccountProperties
Hashtable containing key-value pairs to associate with the dependent account, as defined by the dependent account platform.

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: True
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

[https://pspas.pspete.dev/commands/Add-PASDependentAccount](https://pspas.pspete.dev/commands/Add-PASDependentAccount)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/add-dependent-account.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/add-dependent-account.htm)
