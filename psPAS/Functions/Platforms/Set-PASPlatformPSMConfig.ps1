Function Set-PASPlatformPSMConfig {
	<#
.SYNOPSIS
Update target platform PSM Policy details.

.DESCRIPTION
Allows Vault admins to update the PSM Policy Section of a target platform.

.PARAMETER ID
Numeric ID of target platform

.PARAMETER PSMServerID
PSM server ID linked to the platform

.PARAMETER PSMConnectors
Collection of PSM Connectors to link to the platform

.EXAMPLE
$PSMConfig = Get-PASPlatformPSMConfig -ID 23
$PSMConfig.PSMConnectors += ([PSCustomObject]@{"PSMConnectorID"="PSM-RDP";"Enabled"=$true})
$PSMConfig | Set-PASPlatformPSMConfig -ID 23

Adds PSM-RDP as an additional connection component configured on platform with id of 23

.EXAMPLE
$PSMConfig = Get-PASPlatformPSMConfig -ID 23
$PSMConfig | Set-PASPlatformPSMConfig -ID 23 -PSMServerID PSM-LoadBalancer-EMEA

Updates configured PSMServer on platform with id of 23 to PSM-LoadBalancer-EMEA

.EXAMPLE
$ConnectionComponent = $([PSCustomObject]@{"PSMConnectorID"="PSM-SSH";"Enabled"=$true})
Set-PASPlatformPSMConfig -ID 52 -PSMServerID PSM-LoadBalancer-EMEA -PSMConnectors $ConnectionComponent

Configures platform with ID 42 with connection component PSM-SSH
! Any other Connection Components currently configured will be removed.

.EXAMPLE
Set-PASPlatformPSMConfig -id 42 -PSMServerID PSM-LoadBalancer-EMEA

Clears all configured Connection Components from platform with id of 42
#>
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[int]$ID,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$PSMServerID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[PSObject[]]$PSMConnectors
	)

	BEGIN {

		Assert-VersionRequirement -RequiredVersion 11.5

	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/API/Platforms/Targets/$ID/PrivilegedSessionManagement"

		#Request body
		$Body = $PSBoundParameters | Get-PASParameter -ParametersToRemove ID | ConvertTo-Json

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method PUT -Body $Body -WebSession $Script:WebSession

		If ($null -ne $result) {

			$result

		}

	}#process

	END { }#end

}