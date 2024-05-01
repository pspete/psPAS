---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Clear-PASPrivateSSHKey
schema: 2.0.0
title: Clear-PASPrivateSSHKey
---

# Clear-PASPrivateSSHKey

## SYNOPSIS
Deletes all MFA caching SSH keys for all users.

## SYNTAX

```
Clear-PASPrivateSSHKey [<CommonParameters>]
```

## DESCRIPTION
Delete all MFA caching SSH keys used to connect to targets via PSM for SSH.

Requires the following permission in the Vault:
- Reset Users' Passwords.

Requires CyberArk Version 12.1 or higher.

## EXAMPLES

### EXAMPLE 1
```powershell
PS C:\> Clear-PASPrivateSSHKey
```

Delete all MFA caching SSH keys

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Clear-PASPrivateSSHKey](https://pspas.pspete.dev/commands/Clear-PASPrivateSSHKey)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Delete%20all%20MFA%20caching%20SSH%20keys.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Delete%20all%20MFA%20caching%20SSH%20keys.htm)
