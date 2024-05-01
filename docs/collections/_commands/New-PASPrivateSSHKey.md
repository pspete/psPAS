---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/New-PASPrivateSSHKey
schema: 2.0.0
title: New-PASPrivateSSHKey
---

# New-PASPrivateSSHKey

## SYNOPSIS
Generates an MFA caching SSH key.

## SYNTAX

### Personal (Default)
```
New-PASPrivateSSHKey [-formats <String[]>] [-keyPassword <SecureString>] [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

### UserID
```
New-PASPrivateSSHKey [-formats <String[]>] [-keyPassword <SecureString>] -UserID <Int32> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Generates an MFA caching SSH key for connecting to targets via PSM for SSH.
Either generates a key for your user, or the key for another specific user.
If generating a key for another user, the user who runs this command requires the "Reset Users' Passwords" permission in the Vault.
Additionally, the user who runs the command must be in the same Vault Location or higher as the specified user.

Requires CyberArk Version 12.1 or higher.

## EXAMPLES

### EXAMPLE 1
```powershell
PS C:\> New-PASPrivateSSHKey
```

Generates an MFA caching SSH key for you, to be used connecting to targets via PSM for SSH.

### EXAMPLE 2
```powershell
PS C:\> New-PASPrivateSSHKey -formats OpenSSH, PEM, PPK
```

Generates an MFA caching SSH key in OpenSSH, PEM & PPK formats.

### EXAMPLE 3
```powershell
PS C:\> New-PASPrivateSSHKey -UserID 646
```

Generates an MFA caching SSH key for user with id 646.

### EXAMPLE 4
```powershell
PS C:\> New-PASPrivateSSHKey -keyPassword $cred.Password -UserID 646
```

Generates an MFA caching SSH key for user with id 646, protected by a passphrase

## PARAMETERS

### -formats
Specify the output formats required for the generated key.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -keyPassword
An optional passphrase to protect the key with.

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -UserID
The numerical id of the user to generate the key for.

```yaml
Type: Int32
Parameter Sets: UserID
Aliases:

Required: True
Position: Named
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

[https://pspas.pspete.dev/commands/New-PASPrivateSSHKey](https://pspas.pspete.dev/commands/New-PASPrivateSSHKey)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Generate%20MFA%20caching%20SSH%20key%20for%20another%20user.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Generate%20MFA%20caching%20SSH%20key%20for%20another%20user.htm)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Generate%20MFA%20caching%20SSH%20key.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/WebServices/Generate%20MFA%20caching%20SSH%20key.htm)
