---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/New-PASPlatformSecret
schema: 2.0.0
title: New-PASPlatformSecret
---

# New-PASPlatformSecret

## SYNOPSIS
Generates a secret for a platform.

## SYNTAX

```
New-PASPlatformSecret [-Platformid] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Generates a new secret for a specific platform.

Requires CyberArk Self-Hosted version 15.2 or higher.

## EXAMPLES

### Example 1
```powershell
PS C:\> New-PASPlatformSecret -Platformid SomePlatform
```

Generates a secret for the platform with id SomePlatform.

## PARAMETERS

### -Platformid
The unique id of the platform to generate a secret for.

```yaml
Type: String
Parameter Sets: (All)
Aliases: id

Required: True
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
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

### -WhatIf
Shows what would happen if the cmdlet runs. The cmdlet is not run.

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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

### System.String

## OUTPUTS

### System.Object
## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/New-PASPlatformSecret](https://pspas.pspete.dev/commands/New-PASPlatformSecret)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/generate%20secret%20for%20platform.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/generate%20secret%20for%20platform.htm)