---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Remove-PASPrivateSSHKey
schema: 2.0.0
title: Remove-PASPrivateSSHKey
---

# Remove-PASPrivateSSHKey

## SYNOPSIS
Deletes an MFA caching SSH key.

## SYNTAX

```
Remove-PASPrivateSSHKey [[-UserID] <Int32>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deletes an MFA caching SSH key for connecting to targets via PSM for SSH.
Either deletes your key, or the key for another specific user.
If deleting a key for another user, the user who runs this command must be at the same vault location level or higher, and requires the "Reset Users' Passwords" permission in the Vault.

Requires CyberArk Version 12.1 or higher.

## EXAMPLES

### EXAMPLE 1
```powershell
PS C:\> Remove-PASPrivateSSHKey
```

Deletes your MFA caching SSH key.

### EXAMPLE 2
```powershell
PS C:\> Remove-PASPrivateSSHKey -UserID 646
```

Deletes MFA caching SSH key for user with id 646.

## PARAMETERS

### -UserID
The numerical id of the user to delete the key for.

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: 0
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

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Remove-PASPrivateSSHKey](https://pspas.pspete.dev/commands/Remove-PASPrivateSSHKey)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Delete%20MFA%20caching%20SSH%20key.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Delete%20MFA%20caching%20SSH%20key.htm)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Delete%20MFA%20caching%20SSH%20key%20for%20another%20user.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Delete%20MFA%20caching%20SSH%20key%20for%20another%20user.htm)
