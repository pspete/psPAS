---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Set-PASOAuthProvider
schema: 2.0.0
title: Set-PASOAuthProvider
---

# Set-PASOAuthProvider

## SYNOPSIS
Updates an OAuth 2.0 provider.

## SYNTAX

```
Set-PASOAuthProvider [-id] <String> [[-accessTokenValidationMode] <Int32>] [[-introspectionUrl] <String>]
 [[-issuerUrl] <String>] [[-publicKey] <String>] [[-signatureValidationMode] <Int32>]
 [[-allowedUsers] <PSObject[]>] [[-audience] <String>] [[-jwksUrl] <String>] [[-clientCredentials] <PSObject>]
 [[-clientIdClaimType] <String>] [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Updates an existing OAuth 2.0 provider.
Requires membership of Vault Admins group.

Properties not supplied in the request are retrieved from the existing provider and included in the update.

## EXAMPLES

### EXAMPLE 1
```powershell
Set-PASOAuthProvider -id SomeOAuthProvider -accessTokenValidationMode 2 -issuerUrl 'https://as.example.com' -publicKey '-----BEGIN PUBLIC KEY-----...'
```

Updates the OAuth 2.0 provider SomeOAuthProvider to use local token validation.

### EXAMPLE 2
```powershell
Set-PASOAuthProvider -id SomeOAuthProvider -allowedUsers @( @{ userName = 'vaultadmin'; priority = 1 } ) -Confirm:$false
```

Updates the allowed users of the OAuth 2.0 provider SomeOAuthProvider, suppressing the confirmation prompt.

## PARAMETERS

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

Required: False
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

Required: False
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

Required: False
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

Required: False
Position: 10
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -id
The unique identifier of the OAuth provider to update.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
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

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Set-PASOAuthProvider](https://pspas.pspete.dev/commands/Set-PASOAuthProvider)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/sdk/oauth-update-provider.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/sdk/oauth-update-provider.htm)
