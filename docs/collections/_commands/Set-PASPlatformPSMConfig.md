---
category: PSPAS
external help file: psPAS-help.xml
Module Name: psPAS
online version: https://pspas.pspete.dev/commands/Set-PASPlatformPSMConfig
schema: 2.0.0
title: Set-PASPlatformPSMConfig
---

# Set-PASPlatformPSMConfig

## SYNOPSIS
Update target platform PSM Policy details.

## SYNTAX

```
Set-PASPlatformPSMConfig [-ID] <Int32> [[-PSMServerID] <String>] [[-PSMConnectors] <PSObject[]>] [-WhatIf]
 [-Confirm] [<CommonParameters>]
```

## DESCRIPTION
Allows Vault admins to update the PSM Policy Section of a target platform.

## EXAMPLES

### EXAMPLE 1
```
$PSMConfig = Get-PASPlatformPSMConfig -ID 23

$PSMConfig.PSMConnectors += (\[PSCustomObject\]@{"PSMConnectorID"="PSM-RDP";"Enabled"=$true})
Set-PASPlatformPSMConfig -ID 23 -PSMConnectors $PSMConfig.PSMConnectors
```

Adds PSM-RDP as an additional connection component configured on platform with id of 23

### EXAMPLE 2
```
$PSMConfig = Get-PASPlatformPSMConfig -ID 23

$PSMConfig | Set-PASPlatformPSMConfig -ID 23 -PSMServerID PSM-LoadBalancer-EMEA
```

Updates configured PSMServer on platform with id of 23 to PSM-LoadBalancer-EMEA

### EXAMPLE 3
```
$ConnectionComponent = $([PSCustomObject]@{"PSMConnectorID"="PSM-SSH";"Enabled"=$true})

Set-PASPlatformPSMConfig -ID 52 -PSMServerID PSM-LoadBalancer-EMEA -PSMConnectors $ConnectionComponent
```

Configures platform with ID 42 with connection component PSM-SSH

**Any other Connection Components currently configured will be removed.**

### EXAMPLE 4
```
Set-PASPlatformPSMConfig -id 42 -PSMServerID PSM-LoadBalancer-EMEA
```

Clears all configured Connection Components from platform with id of 42

## PARAMETERS

### -ID
Numeric ID of target platform

```yaml
Type: Int32
Parameter Sets: (All)
Aliases:

Required: True
Position: 1
Default value: 0
Accept pipeline input: True (ByPropertyName)
Accept wildcard characters: False
```

### -PSMServerID
PSM server ID linked to the platform

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

### -PSMConnectors
Collection of PSM Connectors to link to the platform

```yaml
Type: PSObject[]
Parameter Sets: (All)
Aliases:

Required: False
Position: 3
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

[https://pspas.pspete.dev/commands/Set-PASPlatformPSMConfig](https://pspas.pspete.dev/commands/Set-PASPlatformPSMConfig)

[https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Session%20Mngmnt%20-%20Update_Session_Management_Policy_Platform.htm](https://docs.cyberark.com/Product-Doc/OnlineHelp/PAS/Latest/en/Content/SDK/Session%20Mngmnt%20-%20Update_Session_Management_Policy_Platform.htm)
