---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Remove-PASOAuthProvider
schema: 2.0.0
title: Remove-PASOAuthProvider
---

# Remove-PASOAuthProvider

## SYNOPSIS
Deletes a configured OAuth Identity Provider.

## SYNTAX

```
Remove-PASOAuthProvider [-id] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deletes a configured OAuth Identity Provider.
Requires membership of Vault Admins group.

## EXAMPLES

### EXAMPLE 1
```powershell
PS C:\> Remove-PASOAuthProvider -id SomeOAuthProvider
```

Deletes OAuth Identity Provider with ID SomeOAuthProvider

### EXAMPLE 2
```powershell
PS C:\> Remove-PASOAuthProvider -id LegacyOAuthProvider -WhatIf
```

Shows what would happen if the OAuth Identity Provider "LegacyOAuthProvider" were deleted, without actually deleting it.

### EXAMPLE 3
```powershell
PS C:\> [PSCustomObject]@{id = 'LegacyOAuthProvider'} | Remove-PASOAuthProvider -Confirm:$false
```

Deletes the OAuth Identity Provider "LegacyOAuthProvider", with the id value supplied via the pipeline, suppressing the confirmation prompt.

## PARAMETERS

### -id
The unique identifier of the OAuth provider to delete.

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

[https://pspas.pspete.dev/commands/Remove-PASOAuthProvider](https://pspas.pspete.dev/commands/Remove-PASOAuthProvider)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/sdk/oauth-delete-provider.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/sdk/oauth-delete-provider.htm)