---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASVRMServiceStatus
schema: 2.0.0
title: Get-PASVRMServiceStatus
---

# Get-PASVRMServiceStatus

## SYNOPSIS
Gets the operational status of a Vault service

## SYNTAX

```
Get-PASVRMServiceStatus [[-BaseURI] <String>] [-serviceName] <String> [-serverAddress] <String>
 [[-serviceUserName] <String>] [-servicePassword] <SecureString> [<CommonParameters>]
```

## DESCRIPTION
This method gets the current operational status of a specified service managed by the Vault Remote Manager.
Requires authentication with the PARAgent service credentials.

## EXAMPLES

### Example 1
```powershell
PS C:\> $password = ConvertTo-SecureString -String 'P@ssw0rd' -AsPlainText -Force
PS C:\> Get-PASVRMServiceStatus -serviceName Vault -serverAddress vault.company.com -servicePassword $password
```

Gets the operational status of the Vault service on the specified server

## PARAMETERS

### -BaseURI
The URL of the PVWA server, like https://example.com/PasswordVault
If not specified, uses the BaseURI from New-PASSession

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
The name of the service to check status for.
Supported services: Vault, DR, ENE

The ENE service requires CyberArk version 15.2 or higher.

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
The IP address or hostname of the Primary Vault or DR Vault server

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
The password of the PARAgent user as a secure string

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

[https://pspas.pspete.dev/commands/Get-PASVRMServiceStatus](https://pspas.pspete.dev/commands/Get-PASVRMServiceStatus)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/sdk/server-api-vrm-get-service-status.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/sdk/server-api-vrm-get-service-status.htm)