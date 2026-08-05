# .ExternalHelp psPAS-help.xml
function Invoke-PASBYOKRotation {
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$kms_arn
	)

	begin {
		Assert-VersionRequirement -PrivilegeCloud
	}

	process {

		#Create URL for request
		$URI = "$($psPASSession.ApiURI)/api/byok/rotate-customer-key"

		#Request body
		$Body = $PSBoundParameters | Get-PASParameter | ConvertTo-Json

		if ($PSCmdlet.ShouldProcess($kms_arn, 'Rotating BYOK Key')) {

			#send request to web service
			$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body

			if ($null -ne $result) {

				$result

			}

		}

	}

	end {}

}
