---
title: Set-PASPlatformPSMConfig
---

## SYNOPSIS

    Update target platform PSM Policy details.

## SYNTAX

    Set-PASPlatformPSMConfig [-ID] <Int32> [-PSMServerID] <String> [[-PSMConnectors] <PSObject[]>] [<CommonParameters>]

## DESCRIPTION

    Allows Vault admins to update the PSM Policy Section of a target platform.

## PARAMETERS

    -ID <Int32>
        Numeric ID of target platform

    -PSMServerID <String>
        PSM server ID linked to the platform

    -PSMConnectors <PSObject[]>
        Collection of PSM Connectors to link to the platform

    <CommonParameters>
        This cmdlet supports the common parameters: Verbose, Debug,
        ErrorAction, ErrorVariable, WarningAction, WarningVariable,
        OutBuffer, PipelineVariable, and OutVariable. For more information, see
        about_CommonParameters (https:/go.microsoft.com/fwlink/?LinkID=113216).

## EXAMPLES

    -------------------------- EXAMPLE 1 --------------------------

    PS C:\>$PSMConfig = Get-PASPlatformPSMConfig -ID 23

    $PSMConfig.PSMConnectors += ([PSCustomObject]@{"PSMConnectorID"="PSM-RDP";"Enabled"=$true})
    $PSMConfig | Set-PASPlatformPSMConfig -ID 23

    Adds PSM-RDP as an additional connection component configured on platform with id of 23




    -------------------------- EXAMPLE 2 --------------------------

    PS C:\>$PSMConfig = Get-PASPlatformPSMConfig -ID 23

    $PSMConfig | Set-PASPlatformPSMConfig -ID 23 -PSMServerID PSM-LoadBalancer-EMEA

    Updates configured PSMServer on platform with id of 23 to PSM-LoadBalancer-EMEA




    -------------------------- EXAMPLE 3 --------------------------

    PS C:\>$ConnectionComponent = $([PSCustomObject]@{"PSMConnectorID"="PSM-SSH";"Enabled"=$true})

    Set-PASPlatformPSMConfig -ID 52 -PSMServerID PSM-LoadBalancer-EMEA -PSMConnectors $ConnectionComponent

    Configures platform with ID 42 with connection component PSM-SSH
    ! Any other Connection Components currently configured will be removed.




    -------------------------- EXAMPLE 4 --------------------------

    PS C:\>Set-PASPlatformPSMConfig -id 42 -PSMServerID PSM-LoadBalancer-EMEA

    Clears all configured Connection Components from platform with id of 42
