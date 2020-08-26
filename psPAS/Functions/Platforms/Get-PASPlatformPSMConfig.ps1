# .ExternalHelp psPAS-help.xml
Function Get-PASPlatformPSMConfig {
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[int]$ID
	)

	BEGIN {

		Assert-VersionRequirement -RequiredVersion 11.5

	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/API/Platforms/Targets/$ID/PrivilegedSessionManagement"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		If ($null -ne $result) {

			$result

		}

	}#process

	END { }#end

}