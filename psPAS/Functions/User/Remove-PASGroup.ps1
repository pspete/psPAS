# .ExternalHelp psPAS-help.xml
Function Remove-PASGroup {
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias('GroupID')]
		[int]$ID
	)

	BEGIN {

		Assert-VersionRequirement -RequiredVersion 11.5

	}#begin

	Process {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/API/UserGroups/$ID"

		if ($PSCmdlet.ShouldProcess($ID, 'Delete Group')) {

			#send request to web service
			Invoke-PASRestMethod -Uri $URI -Method DELETE

		}

	}

	End { }

}