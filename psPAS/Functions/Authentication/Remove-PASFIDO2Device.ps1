# .ExternalHelp psPAS-help.xml
Function Remove-PASFIDO2Device {

	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$id,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[switch]$OwnDevice

	)

	BEGIN {

		Assert-VersionRequirement -RequiredVersion 14.6

	}#begin

	PROCESS {

		switch ($PSCmdlet.ParameterSetName) {

			'OwnDevice' {

				# Create URL for request to remove user's own FIDO2 device
				$URI = "$($psPASSession.BaseURI)/api/fido2/selfKeys/$($id | Get-EscapedString)"
				$ShouldProcessMessage = 'Delete Own FIDO2 Device'
				break

			}

			default {

				# Create URL for request to remove user FIDO2 device 
				$URI = "$($psPASSession.BaseURI)/api/fido2/keys/$($id | Get-EscapedString)"
				$ShouldProcessMessage = 'Delete FIDO2 Device'

			}

		}

		if ($PSCmdlet.ShouldProcess($id, $ShouldProcessMessage)) {

			#Send request to web service
			Invoke-PASRestMethod -Uri $URI -Method DELETE

		}

	}#process

	END { }#end

}
