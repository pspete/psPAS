---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Add-PASPublicSSHKey
schema: 2.0.0
title: Add-PASPublicSSHKey
---

# Add-PASPublicSSHKey

## SYNOPSIS
Adds an authorised public SSH key for a specific user in the Vault.

## SYNTAX

```
Add-PASPublicSSHKey [-UserName] <String> [-PublicSSHKey] <String> [<CommonParameters>]
```

## DESCRIPTION
Adding an authorised public SSH key to a vault user allows the user
to authenticate to the Vault through PSMP using a corresponding private SSH key.

The "Reset User Passwords" Permission is required in the vault to manage public SSH keys.

The user account used to add the key MUST be in the same Vault Location or higher
then the user whose public SSH keys are added.

A user cannot manage their own public SSH keys.

## EXAMPLES

### EXAMPLE 1
```
Add-PASPublicSSHKey -UserName keyUser -PublicSSHKey AAAAB3NzaC1kc3MAAACBAJ3hB5SAF6mBXPlZlRoJEZi0KSIN+NU2iGiaXZXi9CDrgVxp6/andonandonandOON==
```

Adds SSH Key to vault user keyUser

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

### -PublicSSHKey
The content of the public SSH key as it appears in the authorized_keys file.

The key must not include new lines ('\n').

Do not include options such as "command", as they are not supported when
authenticating through PSMP.

This key can only include comments in English.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Add-PASPublicSSHKey](https://pspas.pspete.dev/commands/Add-PASPublicSSHKey)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Add%20Public%20SSH%20Keys.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Add%20Public%20SSH%20Keys.htm)
