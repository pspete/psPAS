---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Start-PASVRMService
schema: 2.0.0
title: Start-PASVRMService
---

# Start-PASVRMService

## SYNOPSIS
Starts a Vault or DR service

## SYNTAX

```
Start-PASVRMService [[-BaseURI] <String>] [-serviceName] <String> [-serverAddress] <String>
 [[-serviceUserName] <String>] [-servicePassword] <SecureString> [-WhatIf] [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Starts a specified VRM service (Vault or DR) on the target server.
Use this command to bring services online after maintenance or troubleshooting.
Requires authentication with the PARAgent service credentials and supports WhatIf for testing.

## EXAMPLES

### Example 1
```powershell
$password = ConvertTo-SecureString -String 'P@ssw0rd' -AsPlainText -Force
Start-PASVRMService -serviceName Vault -serverAddress vault.company.com -servicePassword $password
```

Starts the Vault service on the specified server

### Example 2
```powershell
$password = ConvertTo-SecureString -String 'P@ssw0rd' -AsPlainText -Force
Start-PASVRMService -serviceName DR -serverAddress dr-vault.company.com -servicePassword $password
```

Starts the DR service on the specified server

### Example 3
```powershell
$password = ConvertTo-SecureString -String 'P@ssw0rd' -AsPlainText -Force
Start-PASVRMService -serviceName ENE -serverAddress vault.company.com -servicePassword $password -WhatIf
```

Shows what would happen if the ENE service was started, without actually starting it.
This service requires CyberArk version 15.2 or higher

## PARAMETERS

### -BaseURI
The URL of the PVWA server.
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
The name of the service to start.
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

[https://pspas.pspete.dev/commands/Start-PASVRMService](https://pspas.pspete.dev/commands/Start-PASVRMService)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/sdk/server-api-vrm-set-service-status-start.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/sdk/server-api-vrm-set-service-status-start.htm)