# .ExternalHelp psPAS-help.xml
function Disable-PASBYOKConfig {
	[CmdletBinding(SupportsShouldProcess)]
	param( )

	begin {
		Assert-VersionRequirement -PrivilegeCloud
	}

	process {

		#Create URL for request
		$URI = "$($psPASSession.ApiURI)/api/byok/disable"

		if ($PSCmdlet.ShouldProcess('BYOK', 'Disabling')) {

			#send request to web service
			$result = Invoke-PASRestMethod -Uri $URI -Method POST

			if ($null -ne $result) {

				$result

			}

		}

	}

	end {}

}
