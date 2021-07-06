---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Set-PASAuthenticationMethod
schema: 2.0.0
title: Set-PASAuthenticationMethod
---

# Set-PASAuthenticationMethod

## SYNOPSIS
Updates an authentication method

## SYNTAX

```
Set-PASAuthenticationMethod [-ID] <String> [[-displayName] <String>] [[-enabled] <Boolean>]
 [[-mobileEnabled] <Boolean>] [[-logoffUrl] <String>] [[-secondFactorAuth] <String>] [[-signInLabel] <String>]
 [[-usernameFieldLabel] <String>] [[-passwordFieldLabel] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates authentication method.

Membership of Vault admins group required.

## EXAMPLES

### EXAMPLE 1
```
Set-PASAuthenticationMethod -id SomeID -enabled $false
```

Disable authentication method "SomeID"

## PARAMETERS

### -ID
The authentication module unique identifier.

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

### -displayName
The display name of the authentication method.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -enabled
Whether or not the authentication method is enabled for use.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -mobileEnabled
Whether or not the authentication method is available from the mobile application.

```yaml
Type: Boolean
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -logoffUrl
The logoff page URL of the third-party server.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 5
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -secondFactorAuth
Defines which second factor authentication to use when connecting to the Vault.

An empty value will disable the second factor authentication.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -signInLabel
Defines the sign-in text for this authentication method.

Relevant only for CyberArk, RADIUS and LDAP authentication methods.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 7
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -usernameFieldLabel
Defines the label of the username field for this authentication method.

Relevant only for CyberArk, RADIUS, and LDAP authentication methods.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 8
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -passwordFieldLabel
Defines the label of the password field for this authentication method.

Relevant only for CyberArk, RADIUS, and LDAP authentication methods.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 9
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

[https://pspas.pspete.dev/commands/Set-PASAuthenticationMethod](https://pspas.pspete.dev/commands/Set-PASAuthenticationMethod)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Update_Authentication_method.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Update_Authentication_method.htm)
