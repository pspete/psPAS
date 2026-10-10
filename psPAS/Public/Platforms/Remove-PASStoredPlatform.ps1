# .ExternalHelp psPAS-help.xml
function Remove-PASStoredPlatform {

	[CmdletBinding(SupportsShouldProcess)]
	param(	)

	begin {
		Assert-VersionRequirement -RequiredVersion 14.6
	}#begin

	process {
		#Create request URL
		$URI = "$($psPASSession.BaseURI)/API/Platforms/Storage"

		if ($PSCmdlet.ShouldProcess('Stored Platform', 'Delete Operation')) {

			#send request to web service
			Invoke-PASRestMethod -Uri $URI -Method DELETE

		}

	}

}