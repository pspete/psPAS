# .ExternalHelp psPAS-help.xml
function Remove-PASGroup {
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias('GroupID')]
		[int]$ID
	)

	begin {

		Assert-VersionRequirement -RequiredVersion 11.5

	}#begin

	process {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/API/UserGroups/$ID"

		if ($PSCmdlet.ShouldProcess($ID, 'Delete Group')) {

			#send request to web service
			Invoke-PASRestMethod -Uri $URI -Method DELETE

		}

	}

	end { }

}