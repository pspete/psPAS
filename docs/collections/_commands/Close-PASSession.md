---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Close-PASSession
schema: 2.0.0
title: Close-PASSession
---

# Close-PASSession

## SYNOPSIS
Logoff from CyberArk Vault.

## SYNTAX

### V10 (Default)
```
Close-PASSession [<CommonParameters>]
```

### v9
```
Close-PASSession [-UseClassicAPI] [<CommonParameters>]
```

### shared
```
Close-PASSession [-SharedAuthentication] [<CommonParameters>]
```

### saml
```
Close-PASSession [-SAMLAuthentication] [<CommonParameters>]
```

## DESCRIPTION
Performs Logoff and removes the Vault session.

## EXAMPLES

### EXAMPLE 1
```
Close-PASSession
```

Logs off from the session related to the authorisation token.

### EXAMPLE 2
```
Close-PASSession -SAMLAuthentication
```

Logs off from the session related to the authorisation token using the SAML Authentication API endpoint.

### EXAMPLE 3
```
Close-PASSession -SharedAuthentication
```

Logs off from the session related to the authorisation token using the Shared Authentication API endpoint.

### EXAMPLE 4
```
Close-PASSession -UseClassicAPI
```

Logs off from the session related to the authorisation token using the Classic API endpoint.

## PARAMETERS

### -UseClassicAPI
Specify the UseClassicAPI switch to send the logoff request via the Classic (v9) API endpoint.

Relevant for CyberArk versions earlier than 10.4

```yaml
Type: SwitchParameter
Parameter Sets: v9
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: False
Accept wildcard characters: False
```

### -SharedAuthentication
Specify the SharedAuthentication switch to logoff from a shared authentication session

```yaml
Type: SwitchParameter
Parameter Sets: shared
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -SAMLAuthentication
Specify the SAMLAuthentication switch to logoff from a session authenticated to with SAML

```yaml
Type: SwitchParameter
Parameter Sets: saml
Aliases:

Required: False
Position: Named
Default value: False
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### CommonParameters
This cmdlet supports the common parameters: -Debug, -ErrorAction, -ErrorVariable, -InformationAction, -InformationVariable, -OutVariable, -OutBuffer, -PipelineVariable, -Verbose, -WarningAction, and -WarningVariable. For more information, see [about_CommonParameters](http://go.microsoft.com/fwlink/?LinkID=113216).

## INPUTS

## OUTPUTS

## NOTES

## RELATED LINKS

[https://pspas.pspete.dev/commands/Close-PASSession](https://pspas.pspete.dev/commands/Close-PASSession)

