---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Remove-PASOpenIDConnectProvider
schema: 2.0.0
title: Remove-PASOpenIDConnectProvider
---

# Remove-PASOpenIDConnectProvider

## SYNOPSIS
Deletes a configured OIDC Identity Provider.

## SYNTAX

```
Remove-PASOpenIDConnectProvider [[-id] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deletes an OIDC Identity Provider.
Requires membership of Vault Admins group.

## EXAMPLES

### EXAMPLE 1
```powershell
PS C:\> Remove-PASOpenIDConnectProvider -id SomeOIDCProvider
```

Deletes OIDC Identity Provider with ID SomeOIDCProvider

### EXAMPLE 2
```powershell
PS C:\> Remove-PASOpenIDConnectProvider -id SomeOIDCProvider -WhatIf
```

Shows what would happen if the OIDC Identity Provider "SomeOIDCProvider" were deleted, without actually deleting it.

### EXAMPLE 3
```powershell
PS C:\> Get-PASOpenIDConnectProvider | Where-Object { $_.id -eq 'DeprecatedProvider' } | Remove-PASOpenIDConnectProvider
```

Deletes the OIDC Identity Provider named "DeprecatedProvider", with the id value supplied via the pipeline.

## PARAMETERS

### -id
The unique identifier of the provider to delete.

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

[https://pspas.pspete.dev/commands/Remove-PASOpenIDConnectProvider](https://pspas.pspete.dev/commands/Remove-PASOpenIDConnectProvider)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/OIDC-Delete-Provider.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/OIDC-Delete-Provider.htm)
