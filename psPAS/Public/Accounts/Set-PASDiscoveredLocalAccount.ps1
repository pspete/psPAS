# .ExternalHelp psPAS-help.xml
function Set-PASDiscoveredLocalAccount {
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
		[hashtable]$customProperties,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string[]]$tags,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$isPrivileged,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$applyRules
	)

	begin {

		Assert-VersionRequirement -PrivilegeCloud

	}#begin

	process {

		#Create URL for Request
		$URI = "$($psPASSession.ApiURI)/api/discovered-accounts/$id"

		if ($PSBoundParameters.ContainsKey('applyRules')) {

			$URI = "$URI`?applyRules=$applyRules"

		}

		#Get Parameters to include in request body
		$Body = $PSBoundParameters | Get-PASParameter -ParametersToRemove id, applyRules | ConvertTo-Json

		if ($PSCmdlet.ShouldProcess($id, 'Edit Discovered Local Account Properties')) {

			#send request to web service
			$result = Invoke-PASRestMethod -Uri $URI -Method PATCH -Body $Body

			if ($null -ne $result) {

				$result

			}

		}

	}#process

	end { }#end

}
