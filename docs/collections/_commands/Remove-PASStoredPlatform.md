---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Remove-PASStoredPlatform
schema: 2.0.0
---

# Remove-PASStoredPlatform

## SYNOPSIS
Removes the platform stored in memory.

## SYNTAX

```
Remove-PASStoredPlatform [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Removes the platform stored in memory.

Requires Vault Admin membership

## EXAMPLES

### Example 1
```powershell
PS C:\> Remove-PASStoredPlatform
```

Delete the stored platform from memory

## PARAMETERS

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

[https://pspas.pspete.dev/commands/Remove-PASStoredPlatform](https://pspas.pspete.dev/commands/Remove-PASStoredPlatform)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/deletestoredplatform.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/deletestoredplatform.htm)