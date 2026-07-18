---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASVRMServiceConfig
schema: 2.0.0
title: Get-PASVRMServiceConfig
---

# Get-PASVRMServiceConfig

## SYNOPSIS
This method gets the current value for a specific configuration parameter.

## SYNTAX

```
Get-PASVRMServiceConfig [[-BaseURI] <String>] [-serviceName] <String> [-serverAddress] <String>
 [[-serviceUserName] <String>] [-servicePassword] <SecureString> [<CommonParameters>]
```

## DESCRIPTION
Gets the current values for all Disaster Recovery (DR) configuration parameters.

Returns Primary Vault configuration values including DefaultTimeout, DebugLevel, LockTimeout, and all DR-specific parameters.

## EXAMPLES

### EXAMPLE 1
```powershell
Get-PASVRMServiceConfig -serviceName DR -serverAddress "192.168.2.51" -servicePassword $SecurePassword
```

Gets all DR configuration parameters for the service at the specified address

## PARAMETERS

### -BaseURI
The URL of the PVWA server.
If not specified, uses the BaseURI from New-PASSession.

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 1
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -serviceName
The name of the service to manage.
Supported services: Vault, DR

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

### -serverAddress
The IP or host name of the Primary Vault or DR Vault

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 3
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -serviceUserName
The PARAgent user name.
Defaults to Administrator

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: False
Position: 4
Default value: Administrator
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -servicePassword
The PARAgent password as a SecureString

```yaml
Type: SecureString
Parameter Sets: (All)
Aliases:

Required: True
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
