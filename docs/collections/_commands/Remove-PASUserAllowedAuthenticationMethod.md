---
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Remove-PASUserAllowedAuthenticationMethod
schema: 2.0.0
---

# Remove-PASUserAllowedAuthenticationMethod

## SYNOPSIS
Delete allowed authentication methods from multiple users

## SYNTAX

```
Remove-PASUserAllowedAuthenticationMethod [-userIds] <Int32[]> [-allowedAuthenticationMethods] <String[]>
 [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Deletes allowed authentication methods from multiple Vault users using a single request.

Requires the Add/Update Users authorizations to be held by the user running the command.

## EXAMPLES

### Example 1
```powershell
PS C:\> Remove-PASUserAllowedAuthenticationMethod -userIds 67,68,69 -allowedAuthenticationMethods LDAP
```

Deletes the LDAP authentication methods from users with ids 67, 68 & 69

## PARAMETERS

### -userIds
A list of strings of the user IDs from which to delete the allowed authentication methods.

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
A list of strings of all the non-Vault authentication methods (specified by ID) that the users cannot use to log on.

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

[https://pspas.pspete.dev/commands/Remove-PASUserAllowedAuthenticationMethod](https://pspas.pspete.dev/commands/Remove-PASUserAllowedAuthenticationMethod)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/bulk-delete-allowed-auth.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/webservices/bulk-delete-allowed-auth.htm)
