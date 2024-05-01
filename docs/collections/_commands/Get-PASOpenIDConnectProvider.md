---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASOpenIDConnectProvider
schema: 2.0.0
title: Get-PASOpenIDConnectProvider
---

# Get-PASOpenIDConnectProvider

## SYNOPSIS
Returns details of configured OIDC Identity Providers.

## SYNTAX

```
Get-PASOpenIDConnectProvider [[-id] <String>] [<CommonParameters>]
```

## DESCRIPTION
returns either a list of all OIDC Identity Providers, or details of a specific Provider.
Requires membership of Vault Admins group.

## EXAMPLES

### EXAMPLE 1
```powershell
PS C:\> Get-PASOpenIDConnectProvider
```

Returns details of all configured OIDC Providers.

### EXAMPLE 2
```powershell
PS C:\> Get-PASOpenIDConnectProvider -id SomeOIDCProvider
```

Returns details of OIDC Provider with ID SomeOIDCProvider

## PARAMETERS

### -id
An identifier of a specific provider to retrieve details of.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
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

[https://pspas.pspete.dev/commands/Get-PASOpenIDConnectProvider](https://pspas.pspete.dev/commands/Get-PASOpenIDConnectProvider)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/OIDC-Get-Specific-Provider.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/OIDC-Get-Specific-Provider.htm)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/OIDC-Get-All-Providers.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/OIDC-Get-All-Providers.htm)
