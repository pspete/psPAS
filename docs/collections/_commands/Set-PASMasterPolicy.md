---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Set-PASMasterPolicy
schema: 2.0.0
title: Set-PASMasterPolicy
---

# Set-PASMasterPolicy

## SYNOPSIS
Updates Master Policy

## SYNTAX

```
Set-PASMasterPolicy [[-DualControl] <Boolean>] [[-MultiLevelApproval] <Boolean>]
 [[-OnlyManagersApproval] <Boolean>] [[-ConfirmersNumber] <Int32>] [[-EnforceExclusiveAccess] <Boolean>]
 [[-EnforceOneTimePassword] <Boolean>] [[-TransparentConnection] <Boolean>] [[-AllowViewPassword] <Boolean>]
 [[-RequireReason] <Boolean>] [[-AllowFreeText] <Boolean>] [[-PasswordChangeDays] <Int32>]
 [[-PasswordVerificationDays] <Int32>] [[-RequireMonitoringAndIsolation] <Boolean>]
 [[-RecordActivity] <Boolean>] [[-RetentionPeriod] <Int32>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Allows a Vault Admin to update Master Policy Settings

## EXAMPLES

### Example 1
```powershell
PS C:\> Set-PASMasterPolicy -DualControl $false
```

Disables Dual Control in master Policy

## PARAMETERS

### -AllowFreeText
Allow free text reason.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -AllowViewPassword
Allow view password policy.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ConfirmersNumber
Configure number of confirmers policy.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -DualControl
Set Dual control policy.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -EnforceExclusiveAccess
Enforce exclusive access policy.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -EnforceOneTimePassword
Enforce one-time password policy.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -MultiLevelApproval
Configure Multi-level approvals.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -OnlyManagersApproval
Configure approval by managers only policy.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PasswordChangeDays
Password change frequency policy.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 10
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PasswordVerificationDays
Password verification frequency policy.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 11
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -RecordActivity
Record activity policy.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 13
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -RequireMonitoringAndIsolation
Require monitoring and isolation policy.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 12
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -RequireReason
Require reason policy.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -RetentionPeriod
Retention period policy.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 14
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -TransparentConnection
Transparent connection policy.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
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

### System.Boolean

### System.Int32

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Set-PASMasterPolicy](https://pspas.pspete.dev/commands/Set-PASMasterPolicy)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/update-policy-by-id.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/update-policy-by-id.htm)