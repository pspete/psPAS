---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Invoke-PASCPMOperation
schema: 2.0.0
title: Invoke-PASCPMOperation
---

# Invoke-PASCPMOperation

## SYNOPSIS
Marks accounts for CPM Verify, Change or Reconcile operations

## SYNTAX

### Verify
```
Invoke-PASCPMOperation -AccountID <String> [-VerifyTask] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### VerifyCredentials
```
Invoke-PASCPMOperation -AccountID <String> [-VerifyTask] [-UseGen1API] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### ChangeCredentials
```
Invoke-PASCPMOperation -AccountID <String> [-ChangeTask] -ImmediateChangeByCPM <String>
 [-ChangeCredsForGroup <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Change
```
Invoke-PASCPMOperation -AccountID <String> [-ChangeTask] [-ChangeEntireGroup <Boolean>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### SetNextPassword
```
Invoke-PASCPMOperation -AccountID <String> [-ChangeTask] -ChangeImmediately <Boolean>
 -NewCredentials <SecureString> [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Password/Update
```
Invoke-PASCPMOperation -AccountID <String> [-ChangeTask] -NewCredentials <SecureString>
 [-ChangeEntireGroup <Boolean>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Reconcile
```
Invoke-PASCPMOperation -AccountID <String> [-ReconcileTask] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Accounts Can be flagged for immediate verification, change or reconcile.

CPM Change Options:
- Flags a managed account credentials for an immediate CPM password change.
  - The "Initiate CPM password management operations" permission is required.
- Sets a password to use for an account's next CPM change.
  - The "Initiate CPM password management operations" & "Specify next password value" permission is required.
- Updates the account's password only in the Vault (without affecting the credentials on the target device).
  - The "Update password value" permission is required.

Verify & Reconcile both require "Initiate CPM password management operations"

Gen 1 Verify is not supported in Privilege Cloud

## EXAMPLES

### EXAMPLE 1
```
Invoke-PASCPMOperation -AccountID $ID -VerifyTask
```

Marks an account for verification

### EXAMPLE 2
```
Invoke-PASCPMOperation -AccountID $ID -VerifyTask -UseGen1API
```

Marks an account for verification using the Gen1 API

### EXAMPLE 3
```
Invoke-PASCPMOperation -AccountID $ID -ChangeTask -ImmediateChangeByCPM Yes
```

Marks an account for immediate change using the Gen1 API

Deprecated from version 13.2

### EXAMPLE 4
```
Invoke-PASCPMOperation -AccountID $ID -ChangeTask
```

Marks an account for immediate change

### EXAMPLE 5
```
Invoke-PASCPMOperation -AccountID $ID -ChangeTask -ChangeImmediately $true -NewCredentials $SecureString
```

Marks an account for immediate change to the specified password value

### EXAMPLE 6
```
Invoke-PASCPMOperation -AccountID $ID -ChangeTask -NewCredentials $SecureString
```

Changes the password for the account in the Vault

### EXAMPLE 7
```
Invoke-PASCPMOperation -AccountID $ID -ReconcileTask
```

Marks an account for immediate reconcile

## PARAMETERS

### -AccountID
The unique ID of the account.

```yaml
Type: String
Parameter Sets: (All)
Aliases: id

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -VerifyTask
Initiates a verify task

```yaml
Type: SwitchParameter
Parameter Sets: Verify, VerifyCredentials
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ChangeTask
Initiates a change task

```yaml
Type: SwitchParameter
Parameter Sets: ChangeCredentials, Change, SetNextPassword, Password/Update
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ReconcileTask
Initiates a reconcile task

Requires CyberArk version 9.10+

```yaml
Type: SwitchParameter
Parameter Sets: Reconcile
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ChangeImmediately
Whether or not the password will be changed immediately in the Vault.

Only relevant when specifying a password value for the next CPM change.

Minimum required version 10.1

```yaml
Type: Boolean
Parameter Sets: SetNextPassword
Aliases:

Required: True
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -NewCredentials
Secure String value of the new account password that will be allocated to the account in the Vault.

Only relevant when specifying a password value for the next CPM change, or updating the password only in the vault.

Minimum required version 10.1

```yaml
Type: SecureString
Parameter Sets: SetNextPassword, Password/Update
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -ChangeEntireGroup
Boolean value, dictating if all accounts that belong to the same group should have their passwords changed.

This is only relevant for accounts that belong to an account group.

Parameter will be ignored if account does not belong to a group.

Applicable to immediate change via CPM, and password change in the vault only.

Minimum required version 10.1

```yaml
Type: Boolean
Parameter Sets: Change
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

```yaml
Type: Boolean
Parameter Sets: Password/Update
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -ImmediateChangeByCPM
Yes/No value, dictating if the account will be scheduled for immediate change.

Specify Yes to initiate a password change by CPM - Relevant for Gen1 API only.

Deprecated from version 13.2

```yaml
Type: String
Parameter Sets: ChangeCredentials
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -ChangeCredsForGroup
Yes/No value, dictating if all accounts that belong to the same group should
have their passwords changed.

This is only relevant for accounts that belong to an account group.

Parameter will be ignored if account does not belong to a group.

Relevant for Gen1 API only.

```yaml
Type: String
Parameter Sets: ChangeCredentials
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: False
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

### -UseGen1API
Specify to force verification via Gen1 API.

Should be specified for versions earlier than 10.1

Gen 1 Verify is not supported in Privilege Cloud

```yaml
Type: SwitchParameter
Parameter Sets: VerifyCredentials
Aliases: UseClassicAPI

Required: True
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

## RELATED LINKS

[https://pspas.pspete.dev/commands/Invoke-PASCPMOperation](https://pspas.pspete.dev/commands/Invoke-PASCPMOperation)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Verify-credentials-v9-10.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Verify-credentials-v9-10.htm)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Change-credentials-immediately.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Change-credentials-immediately.htm)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/SetNextPassword.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/SetNextPassword.htm)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/ChangeCredentialsInVault.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/ChangeCredentialsInVault.htm)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Reconcile-account.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Reconcile-account.htm)
