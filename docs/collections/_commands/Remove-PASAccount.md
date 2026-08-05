---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Remove-PASAccount
schema: 2.0.0
title: Remove-PASAccount
---

# Remove-PASAccount

## SYNOPSIS
Deletes an account

## SYNTAX

### Default (Default)
```
Remove-PASAccount -AccountID <String> [-DeleteSSHKey <Boolean>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

### Gen1
```
Remove-PASAccount -AccountID <String> [-UseGen1API] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deletes a specific account in the Vault.

The user who runs this web service requires the "Delete Accounts" permission.

## EXAMPLES

### EXAMPLE 1
```
Remove-PASAccount -AccountID 19_1
```

Deletes the account with AccountID of 19_1

### EXAMPLE 2
```
Get-PASAccount -id 19_1 | Remove-PASAccount
```

Deletes the account returned by Get-PASAccount.

### EXAMPLE 3
```
Remove-PASAccount -AccountID 19_1 -UseGen1API
```

Deletes the account with AccountID of 19_1 using the Gen1 (PIMServices.svc) API endpoint, for use against CyberArk versions earlier than 10.4.

### EXAMPLE 4
```
Remove-PASAccount -AccountID 19_1 -DeleteSSHKey $true -WhatIf
```

Shows what would happen if the account and its associated SSH keys, both public (target) and private (Vault), were deleted, without actually deleting them.

## PARAMETERS

### -AccountID
The unique ID of the account to delete.

This is retrieved by the Get-PASAccount function.

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
Specify to force usage the Gen1 API endpoint.

Should be specified for versions earlier than 10.4

```yaml
Type: SwitchParameter
Parameter Sets: Gen1
Aliases: UseClassicAPI

Required: False
Position: Named
Default value: None
Accept pipeline input: False
Accept wildcard characters: False
```

### -DeleteSSHKey
For SSH Key accounts, indicates whether to delete both the public (target) and private (Vault) account keys.

On Self-Hosted environments, this is passed as the `deleteSshKeyFromVaultAndTarget` URL parameter, and requires
minimum version of 15.2. Defaults to $false (the private key is deleted from the Vault, the public key on the
target is not).

On Privilege Cloud, this is passed as the `deleteOnlyPrivateSshKey` URL parameter. Specify $true to delete both
account keys, or $false to delete only the public (target) key.

```yaml
Type: Boolean
Parameter Sets: Default
Aliases:

Required: False
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

[https://pspas.pspete.dev/commands/Remove-PASAccount](https://pspas.pspete.dev/commands/Remove-PASAccount)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Delete%20Account.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Delete%20Account.htm)
