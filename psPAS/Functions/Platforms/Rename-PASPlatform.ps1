# .ExternalHelp psPAS-help.xml
function Rename-PASPlatform {
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
		[string]$Name
	)

	begin {
		Assert-VersionRequirement -SelfHosted
		Assert-VersionRequirement -RequiredVersion 15.0
	}#begin

	process {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/API/Platforms/targets/$ID"

		#Get request parameters
		$boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove ID

		$body = $boundParameters | ConvertTo-Json

		if ($PSCmdlet.ShouldProcess($ID, "Update Target Platform Name")) {

			#send request to web service
			Invoke-PASRestMethod -Uri $URI -Method PUT -Body $body

		}

	}#process

	end { }#end

}
