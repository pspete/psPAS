---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASOAuthProvider
schema: 2.0.0
title: Get-PASOAuthProvider
---

# Get-PASOAuthProvider

## SYNOPSIS
Gets configured OAuth 2.0 providers.

## SYNTAX

```
Get-PASOAuthProvider [<CommonParameters>]
```

## DESCRIPTION
Gets all configured OAuth 2.0 providers.
Requires membership of Vault Admins group.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-PASOAuthProvider
```

Returns all configured OAuth 2.0 providers.

### EXAMPLE 2
```powershell
Get-PASOAuthProvider | Where-Object { $_.name -eq 'SomeProvider' }
```

Returns all configured OAuth 2.0 providers and filters the results to the provider named "SomeProvider".

## PARAMETERS

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASOAuthProvider](https://pspas.pspete.dev/commands/Get-PASOAuthProvider)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/sdk/oauth-get-all-providers.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/sdk/oauth-get-all-providers.htm)
