---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASServerWebService
schema: 2.0.0
title: Get-PASServerWebService
---

# Get-PASServerWebService

## SYNOPSIS
Returns details of the Web Service

## SYNTAX

```
Get-PASServerWebService [[-WebSession] <WebRequestSession>] [-BaseURI] <String> [[-PVWAAppName] <String>]
 [-UseGen1API] [<CommonParameters>]
```

## DESCRIPTION
Returns information on Server web service.

Returns the name of the Vault configured in the ServerDisplayName configuration parameter

## EXAMPLES

### EXAMPLE 1
```
Get-PASServerWebService
```

Displays CyberArk Web Service Information

## PARAMETERS

### -WebSession
WebRequestSession object returned from New-PASSession

```yaml
Type: WebRequestSession
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -BaseURI
PVWA Web Address

Do not include "/PasswordVault/"

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PVWAAppName
The name of the CyberArk PVWA Virtual Directory.

Defaults to PasswordVault

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
Default value: PasswordVault
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -UseGen1API
Force use of Gen1 API for request.

```yaml
Type: SwitchParameter
Parameter Sets: (All)
Aliases: UseClassicAPI

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

[https://pspas.pspete.dev/commands/Get-PASServerWebService](https://pspas.pspete.dev/commands/Get-PASServerWebService)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Server%20Web%20Services%20-%20Verify.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Server%20Web%20Services%20-%20Verify.htm)
