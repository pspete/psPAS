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
		$URI = "$($psPASSession.BaseURI)/API/Platforms/Targets/$ID/PrivilegedSessionManagement"

		#Request body
		$Body = $PSBoundParameters | Get-PASParameter -ParametersToRemove ID | ConvertTo-Json

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