---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Add-PASOpenIDConnectProvider
schema: 2.0.0
title: Add-PASOpenIDConnectProvider
---

# Add-PASOpenIDConnectProvider

## SYNOPSIS
Adds a new OIDC Identity Provider.

## SYNTAX

```
Add-PASOpenIDConnectProvider -id <String> [-authenticationFlow <String>] [-authenticationEndpointUrl <String>]
 [-issuer <String>] [-description <String>] -discoveryEndpointUrl <String> [-jwkSet <String>]
 -clientId <String> [-clientSecret <SecureString>] -clientSecretMethod <String> [-userNameClaim <String>]
 [<CommonParameters>]
```

## DESCRIPTION
Adds a new OIDC Identity Provider.
Requires membership of Vault Admins group.

## EXAMPLES

### EXAMPLE 1
```powershell
PS C:\> Add-PASOpenIDConnectProvider -id SomeOIDCProvider -discoveryEndpointUrl https://SomeURLValue
 -clientId SomeID -clientSecretMethod POST
```

Adds an OIDC Identity Provider with ID SomeOIDCProvider.

## PARAMETERS

### -id
The unique identifier of the provider.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -authenticationFlow
The OIDC connection flow.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -authenticationEndpointUrl
The URL of the provider's authorization endpoint.
Authentication requests will be sent to this URL.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -issuer
The Issuer Identifier for the OpenID Provider.
Used to verify that the response was issued from a specific provider.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -description
A description of the provider.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -discoveryEndpointUrl
OIDC defines a discovery mechanism, called OpenID Connect Discovery, where an OIDC Identity provider publishes its metadata at a well-known URL.

This URL is metadata that describes the provider's configuration.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -jwkSet
The JSON web key set provided by the OIDC Identity Provider for validating JSON web tokens during the authentication flow.

The JSON must include a "keys" parameter, which is an array of JWT signing keys.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -clientId
The unique identifier for the client application.
This ID is created by the provider, and assigned to each client application upon registration.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -clientSecret
The client secret is only known to the application and the provider for secure communication during the authentication flow.
This secret is created by the provider, and assigned to each client application upon registration.

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

### -clientSecretMethod
The client authentication method for the client secret.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: Named
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -userNameClaim
The property in the ID token provided by the OIDC Identity Provider that contains the user name.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: Named
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

[https://pspas.pspete.dev/commands/Add-PASOpenIDConnectProvider](https://pspas.pspete.dev/commands/Add-PASOpenIDConnectProvider)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/OIDC-Add-Provider.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/OIDC-Add-Provider.htm)
