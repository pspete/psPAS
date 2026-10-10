# .ExternalHelp psPAS-help.xml
function Get-PASPlatformPSMConfig {
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[int]$ID
	)

	begin {

		Assert-VersionRequirement -RequiredVersion 11.5

	}#begin

	process {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/API/Platforms/Targets/$ID/PrivilegedSessionManagement"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		if ($null -ne $result) {

			$result

		}

	}#process

	end { }#end

}