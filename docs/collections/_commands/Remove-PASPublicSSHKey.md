---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Remove-PASPublicSSHKey
schema: 2.0.0
title: Remove-PASPublicSSHKey
---

# Remove-PASPublicSSHKey

## SYNOPSIS
Deletes a specific Public SSH Key from a specific vault user.

## SYNTAX

```
Remove-PASPublicSSHKey [-UserName] <String> [-KeyID] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deletes an authorized public SSH key for a specific user in the
Vault, preventing them from authenticating to the Vault through PSMP
using a corresponding private SSH key.

"Reset Users Passwords" Vault permission is required.

The authenticated user who runs this function must be in the same Vault
Location or higher as the user whose public SSH keys are deleted.

A user cannot manage their own public SSH keys.

## EXAMPLES

### EXAMPLE 1
```
Remove-PASPublicSSHKey -UserName Splitter -KeyID 415161FE8F2B408BB76BC244258C3697
```

Deletes specified ssh key from vault user "Splitter"

## PARAMETERS

### -UserName
The username of the Vault user whose public SSH keys will be added

A username cannot contain the following characters: "%", "&", "+" or ".".

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -KeyID
The ID of the public SSH key to delete.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
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

[https://pspas.pspete.dev/commands/Remove-PASPublicSSHKey](https://pspas.pspete.dev/commands/Remove-PASPublicSSHKey)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Delete%20Public%20SSH%20Key.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Delete%20Public%20SSH%20Key.htm)
