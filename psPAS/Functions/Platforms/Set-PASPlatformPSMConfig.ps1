# .ExternalHelp psPAS-help.xml
Function Set-PASPlatformPSMConfig {
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[int]$ID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[AllowEmptyString()]
		[string]$PSMServerID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[AllowEmptyCollection()]
		[PSObject[]]$PSMConnectors
	)

	BEGIN {

		Assert-VersionRequirement -RequiredVersion 11.5

	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/API/Platforms/Targets/$ID/PrivilegedSessionManagement"

		$BoundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove ID

		$PlatformPSMConfig = Get-PASPlatformPSMConfig -ID $ID
		if ($null -ne $PlatformPSMConfig) {
			Format-PutRequestObject -InputObject $PlatformPSMConfig -boundParameters $BoundParameters -ParametersToKeep PSMServerID
		}

		#Request body
		$Body = $BoundParameters | ConvertTo-Json

		if ($PSCmdlet.ShouldProcess($ID, 'Update Platform PSM Config')) {

			#send request to web service
			$result = Invoke-PASRestMethod -Uri $URI -Method PUT -Body $Body

		}

		If ($null -ne $result) {

			$result

		}

	}#process

	END { }#end

}