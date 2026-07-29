---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Get-PASVRMDRSystemHealth
schema: 2.0.0
title: Get-PASVRMDRSystemHealth
---

# Get-PASVRMDRSystemHealth

## SYNOPSIS
Gets the DR system health check including replication status

## SYNTAX

```
Get-PASVRMDRSystemHealth [[-BaseURI] <String>] [-DRAddress] <String> [[-serviceUserName] <String>]
 [-servicePassword] <SecureString> [<CommonParameters>]
```

## DESCRIPTION
This method evaluates the overall system health of the DR environment.

## EXAMPLES

### Example 1
```powershell
PS C:\> $password = ConvertTo-SecureString -String 'P@ssw0rd' -AsPlainText -Force
PS C:\> Get-PASVRMDRSystemHealth -DRAddress dr-vault.company.com -servicePassword $password
```

Retrieves the DR system health status including replication information

### Example 2
```powershell
PS C:\> $password = ConvertTo-SecureString -String 'P@ssw0rd' -AsPlainText -Force
PS C:\> Get-PASVRMDRSystemHealth -BaseURI https://pvwa.company.com/PasswordVault -DRAddress dr-vault.company.com -serviceUserName PARAgentSvc -servicePassword $password
```

Retrieves the DR system health status using an explicit PVWA BaseURI and a non-default PARAgent user name

### Example 3
```powershell
PS C:\> $password = ConvertTo-SecureString -String 'P@ssw0rd' -AsPlainText -Force
PS C:\> [PSCustomObject]@{DRAddress = 'dr-vault.company.com'; servicePassword = $password} | Get-PASVRMDRSystemHealth | Format-List
```

Passes the DR address and credentials via the pipeline and displays all returned health properties

## PARAMETERS

### -BaseURI
The URL of the PVWA server.
If not specified, uses the BaseURI from New-PASSession

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

### -DRAddress
The IP address or hostname of the DR Vault server

```yaml
Type: String
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: None
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
Position: 2
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

[https://pspas.pspete.dev/commands/Get-PASVRMDRSystemHealth](https://pspas.pspete.dev/commands/Get-PASVRMDRSystemHealth)

[https://docs.cyberark.com/pam-self-hosted/latest/en/content/sdk/server-api-vrm-system-health.htm](https://docs.cyberark.com/pam-self-hosted/latest/en/content/sdk/server-api-vrm-system-health.htm)