# .ExternalHelp psPAS-help.xml
function Enable-PASBYOKConfig {
	[CmdletBinding(SupportsShouldProcess)]
	param( )

	begin {
		Assert-VersionRequirement -PrivilegeCloud
	}

	process {

		#Create URL for request
		$URI = "$($psPASSession.ApiURI)/api/byok/enable"

		if ($PSCmdlet.ShouldProcess('BYOK', 'Enabling')) {

			#send request to web service
			$result = Invoke-PASRestMethod -Uri $URI -Method POST

			if ($null -ne $result) {

				$result

			}

		}

	}

	end {}

}
