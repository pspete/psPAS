# .ExternalHelp psPAS-help.xml
function Restore-PASDiscoveredLocalAccount {
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$id
	)

	begin {

		Assert-VersionRequirement -PrivilegeCloud

	}#begin

	process {

		#Create URL for Request
		$URI = "$($psPASSession.ApiURI)/api/discovered-accounts/$id/restore"

		if ($PSCmdlet.ShouldProcess($id, 'Restore Discovered Local Account')) {

			#send request to web service
			Invoke-PASRestMethod -Uri $URI -Method POST

		}

	}#process

	end { }#end

}
