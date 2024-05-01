---
category: psPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASAccountPasswordVersion
schema: 2.0.0
title: Get-PASAccountPasswordVersion
---

# Get-PASAccountPasswordVersion

## SYNOPSIS
Returns details of secret versions.

## SYNTAX

```
Get-PASAccountPasswordVersion [-AccountID] <String> [[-showTemporary] <Boolean>] [<CommonParameters>]
```

## DESCRIPTION
Returns all secret versions.

Requires the following Safe member authorizations:
- List accounts
- View Safe members

Requires CyberArk Version 12.1 or higher.

## EXAMPLES

### EXAMPLE 1
```powershell
PS C:\> Get-PASAccountPasswordVersion -AccountID 32_1
```

Get password versions for account with ID 32_1

### EXAMPLE 2
```powershell
PS C:\> Get-PASAccountPasswordVersion -AccountID 32_1 -showTemporary $true
```

Get password versions, including temporary versions for account with ID 32_1

## PARAMETERS

### -AccountID
The ID of the account to get password version details of.

```yaml
Type: String
Parameter Sets: (All)
Aliases: id

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -showTemporary
Whether to include temporary password versions in the results.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Get-PASAccountPasswordVersion](https://pspas.pspete.dev/commands/Get-PASAccountPasswordVersion)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Secrets-Get-versions.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Secrets-Get-versions.htm)
