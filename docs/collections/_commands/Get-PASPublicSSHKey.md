---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASPublicSSHKey
schema: 2.0.0
title: Get-PASPublicSSHKey
---

# Get-PASPublicSSHKey

## SYNOPSIS
Retrieves a user's SSH Keys.

## SYNTAX

```
Get-PASPublicSSHKey [-UserName] <String> [<CommonParameters>]
```

## DESCRIPTION
Retrieves all public SSH keys that are authorized for a specific user.

The "Reset User Passwords" Vault permission is required to query public SSH Keys.

The authenticated user who runs the function must be in the same Vault

Location or higher as the user whose public SSH keys are retrieved.

A user cannot manage their own public SSH keys.

## EXAMPLES

### EXAMPLE 1
```
Get-PASPublicSSHKey -UserName user1
```

Lists all SSH Keys for vault user

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASPublicSSHKey](https://pspas.pspete.dev/commands/Get-PASPublicSSHKey)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Get%20Public%20SSH%20Keys.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Get%20Public%20SSH%20Keys.htm)
