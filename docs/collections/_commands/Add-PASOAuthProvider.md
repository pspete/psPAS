---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Add-PASOAuthProvider
schema: 2.0.0
title: Add-PASOAuthProvider
---

# Add-PASOAuthProvider

## SYNOPSIS
Adds a new OAuth 2.0 provider.

## SYNTAX

```
Add-PASOAuthProvider [[-id] <String>] [[-accessTokenValidationMode] <Int32>] [[-introspectionUrl] <String>]
 [[-issuerUrl] <String>] [[-publicKey] <String>] [[-signatureValidationMode] <Int32>]
 [-allowedUsers] <PSObject[]> [-audience] <String> [[-jwksUrl] <String>] [-clientCredentials] <PSObject>
 [-clientIdClaimType] <String> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Adds a new OAuth 2.0 provider.
Requires membership of Vault Admins group.

## EXAMPLES

### EXAMPLE 1
```powershell
Add-PASOAuthProvider -id SomeOAuthProvider -accessTokenValidationMode 1 -introspectionUrl 'https://as.example.com/oauth2/introspect' -audience 'https://pvwa/passwordvault' -clientIdClaimType sub -clientCredentials @{ accountId = 'acc_12345' } -allowedUsers @( @{ userName = 'vaultuser'; priority = 1 } )
```

Adds an OAuth 2.0 provider named SomeOAuthProvider that validates access tokens remotely.

### EXAMPLE 2
```powershell
Add-PASOAuthProvider -id LocalOAuthProvider -accessTokenValidationMode 2 -issuerUrl 'https://as.example.com' -publicKey '-----BEGIN PUBLIC KEY-----...' -audience 'https://pvwa/passwordvault' -clientIdClaimType sub -clientCredentials @{ accountId = 'acc_12345' }
```

Adds an OAuth 2.0 provider named LocalOAuthProvider that validates access tokens locally.

## PARAMETERS

### -accessTokenValidationMode
How access tokens are validated.
Valid values are 1 (Remotely) or 2 (Locally).

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:
Accepted values: 1, 2

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -allowedUsers
User accounts used to log in to PVWA when the access token is valid.

```yaml
Type: PSObject[]
Parameter Sets: (All)
Aliases:

Required: True
Position: 6
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -audience
Audience (aud) value that must be present in incoming access tokens.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 7
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -clientCredentials
Client credentials account used to authenticate to the Authorization Server for token validation.

```yaml
Type: PSObject
Parameter Sets: (All)
Aliases:

Required: True
Position: 9
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -clientIdClaimType
The access token claim type where the client ID is stored.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 10
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -id
The unique identifier (name) of the OAuth provider.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 0
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -introspectionUrl
Authorization Server introspection URL used to validate access tokens remotely.
Required when accessTokenValidationMode is 1 (Remotely).

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

### -issuerUrl
Authorization Server issuer URL, used to validate the access token issuer.
Required when accessTokenValidationMode is 2 (Locally).

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -jwksUrl
JWKS endpoint URL exposing public keys used to validate token signatures.
Required for local validation if publicKey is not provided.

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

### -publicKey
Public key used to verify the access token signature for local validation.
Required for local validation if jwksUrl is not provided.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -signatureValidationMode
How strictly to validate token signatures.
Valid values are 1 (AllowStrongSignedOnly) or 2 (AllowSignedOnly).

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:
Accepted values: 1, 2

Required: False
Position: 5
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

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Add-PASOAuthProvider](https://pspas.pspete.dev/commands/Add-PASOAuthProvider)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/sdk/oauth-add-provider.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/sdk/oauth-add-provider.htm)
