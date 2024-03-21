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

### Gen2 (Default)
```
Close-PASSession [<CommonParameters>]
```

### Gen1
```
Close-PASSession [-UseGen1API] [<CommonParameters>]
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

Shared authentication is supported in Privilege Cloud

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
Close-PASSession -UseGen1API
```

Logs off from the session related to the authorisation token using the Gen1 API endpoint.

## PARAMETERS

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

### -UseGen1API
Specify  to send the logoff request via the Gen1 API endpoint.

Should be specified for versions earlier than 10.4

```yaml
Type: SwitchParameter
Parameter Sets: Gen1
Aliases: UseClassicAPI

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

[https://pspas.pspete.dev/commands/Close-PASSession](https://pspas.pspete.dev/commands/Close-PASSession)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/CyberArk%20Authentication%20-%20Logoff_v10.htm#CyberArkLDAPRadiusWindows](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/CyberArk%20Authentication%20-%20Logoff_v10.htm#CyberArkLDAPRadiusWindows)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Shared%20Logon%20Authentication%20-%20Logoff.htm#Sharedlogonauthenticationlogoff](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Shared%20Logon%20Authentication%20-%20Logoff.htm#Sharedlogonauthenticationlogoff)
