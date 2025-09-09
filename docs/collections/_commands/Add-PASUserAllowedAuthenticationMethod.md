---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Add-PASUserAllowedAuthenticationMethod
schema: 2.0.0
---

# Add-PASUserAllowedAuthenticationMethod

## SYNOPSIS
Adds allowed authentication methods to multiple Vault users.

## SYNTAX

```
Add-PASUserAllowedAuthenticationMethod [-userIds] <Int32[]> [-allowedAuthenticationMethods] <String[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Adds new authentication methods to a list of accounts in a single request.

## EXAMPLES

### Example 1
```powershell
PS C:\> Add-PASUserAllowedAuthenticationMethod -userIds 36,37 -allowedAuthenticationMethods SAML, RADIUS
```

Adds specified authentication methods to specified users

## PARAMETERS

### -userIds
A list of user IDs to add the allowed authentication methods to

```yaml
Type: Int32[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -allowedAuthenticationMethods
A list of the non-Vault authentication methods (specified by ID) that the users can use to log on.

```yaml
Type: String[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
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

[https://pspas.pspete.dev/commands/Add-PASUserAllowedAuthenticationMethod](https://pspas.pspete.dev/commands/Add-PASUserAllowedAuthenticationMethod)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/bulk-add-allowed-auth.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/bulk-add-allowed-auth.htm)