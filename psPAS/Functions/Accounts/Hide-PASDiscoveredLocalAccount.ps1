# .ExternalHelp psPAS-help.xml
function Hide-PASDiscoveredLocalAccount {
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$id,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$reason
	)

	begin {

		Assert-VersionRequirement -PrivilegeCloud

	}#begin

	process {

		#Create URL for Request
		$URI = "$($psPASSession.ApiURI)/api/discovered-accounts/$id/ignore"

		#Get Parameters to include in request body
		$Body = $PSBoundParameters | Get-PASParameter -ParametersToRemove id | ConvertTo-Json

		if ($PSCmdlet.ShouldProcess($id, 'Ignore Discovered Local Account')) {

			#send request to web service
			Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body

		}

	}#process

	end { }#end

}
