---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Set-PASVRMServiceConfig
schema: 2.0.0
title: Set-PASVRMServiceConfig
---

# Set-PASVRMServiceConfig

## SYNOPSIS
Sets one or multiple DR configuration parameters

## SYNTAX

```
Set-PASVRMServiceConfig [[-BaseURI] <String>] [-parameters] <Hashtable> [-serviceName] <String>
 [-serverAddress] <String> [[-serviceUserName] <String>] [-servicePassword] <SecureString> [-WhatIf] [-Confirm]
 [<CommonParameters>]
```

## DESCRIPTION
Sets one or more Disaster Recovery configuration parameters on the VRM service.
Use this command to configure DR replication settings and other operational parameters.
Requires authentication with the PARAgent service credentials and supports WhatIf for testing.

## EXAMPLES

### Example 1
```powershell
$password = ConvertTo-SecureString -String 'P@ssw0rd' -AsPlainText -Force
$params = @{ 'ReplicationInterval' = '300'; 'MaxRetries' = '5' }
Set-PASVRMServiceConfig -parameters $params -serviceName DR -serverAddress dr-vault.company.com -servicePassword $password
```

Sets multiple DR configuration parameters on the specified server

### Example 2
```powershell
$password = ConvertTo-SecureString -String 'P@ssw0rd' -AsPlainText -Force
Set-PASVRMServiceConfig -parameters @{ 'DebugLevel' = '3' } -serviceName Vault -serverAddress vault.company.com -servicePassword $password
```

Sets the DebugLevel configuration parameter on the Vault service

### Example 3
```powershell
$password = ConvertTo-SecureString -String 'P@ssw0rd' -AsPlainText -Force
Set-PASVRMServiceConfig -parameters @{ 'EnableReplicate' = 'Yes'; 'ReplicateInterval' = '60' } -serviceName DR -serverAddress dr-vault.company.com -servicePassword $password -WhatIf
```

Shows what would happen if the EnableReplicate and ReplicateInterval parameters were set on the DR service, without actually applying the change

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

### -parameters
A hashtable of configuration parameters to set.
Keys are parameter names, values are the desired settings

```yaml
Type: Hashtable
Parameter Sets: (All)
Aliases:

Required: True
Position: 2
Default value: None
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -serviceName
The name of the service to configure.
Supported services: Vault, DR

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

### -serverAddress
The IP address or hostname of the Primary Vault or DR Vault server

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 4
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
Position: 5
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
Position: 6
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

[https://pspas.pspete.dev/commands/Set-PASVRMServiceConfig](https://pspas.pspete.dev/commands/Set-PASVRMServiceConfig)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/sdk/server-api-vrm-set-service-config-.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/sdk/server-api-vrm-set-service-config-.htm)