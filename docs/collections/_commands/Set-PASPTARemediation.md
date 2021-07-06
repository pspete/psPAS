---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Set-PASPTARemediation
schema: 2.0.0
title: Set-PASPTARemediation
---

# Set-PASPTARemediation

## SYNOPSIS
Updates automatic remediation settings in PTA

## SYNTAX

```
Set-PASPTARemediation [[-changePassword_SuspectedCredentialsTheft] <Boolean>]
 [[-changePassword_OverPassTheHash] <Boolean>] [[-reconcilePassword_SuspectedPasswordChange] <Boolean>]
 [[-pendAccount_UnmanagedPrivilegedAccount] <Boolean>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates automatic remediation settings configured in PTA

## EXAMPLES

### EXAMPLE 1
```
Set-PASPTARemediation -changePassword_SuspectedCredentialsTheft $true
```

Enables the "Change password on Suspected Credentials Theft" rule.

### EXAMPLE 2
```
Set-PASPTARemediation -reconcilePassword_SuspectedPasswordChange $false
```

Disables the "reconcile on suspected password change" rule.

## PARAMETERS

### -changePassword_SuspectedCredentialsTheft
Indicate if Change Password on Suspected Credential Theft the command is active

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -changePassword_OverPassTheHash
Indicate if the Change Password on Over Pass The Hash command is active

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -reconcilePassword_SuspectedPasswordChange
Indicate if the Reconcile Password on Suspected Password Change command is active

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -pendAccount_UnmanagedPrivilegedAccount
Indicate if the Add Unmanaged Accounts to Pending Accounts command is active

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: False
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
Minimum Version CyberArk 10.4

## RELATED LINKS

[https://pspas.pspete.dev/commands/Set-PASPTARemediation](https://pspas.pspete.dev/commands/Set-PASPTARemediation)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/AutomaticRemediation_UpdateConfiguration.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/AutomaticRemediation_UpdateConfiguration.htm)
