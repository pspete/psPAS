# .ExternalHelp psPAS-help.xml
Function Remove-PASStoredPlatform{

[CmdletBinding(SupportsShouldProcess)]
	param(	)

	BEGIN {
		Assert-VersionRequirement -RequiredVersion 14.6
	}#begin

	PROCESS {
		#Create request URL
		$URI = "$($psPASSession.BaseURI)/API/Platforms/Storage"

		if ($PSCmdlet.ShouldProcess('Stored Platform', "Delete Operation")) {

			#send request to web service
			Invoke-PASRestMethod -Uri $URI -Method DELETE

		}

	}

}