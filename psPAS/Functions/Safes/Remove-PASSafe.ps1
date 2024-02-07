# .ExternalHelp psPAS-help.xml
function Remove-PASSafe {
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', 'UseGen1API', Justification = 'False Positive')]
	[CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'Gen2')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$SafeName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = 'Gen1'
		)]
		[switch]$UseGen1API

	)

	BEGIN { }#begin

	PROCESS {

		switch ($PSCmdlet.ParameterSetName) {

			'Gen1' {

				Assert-VersionRequirement -MaximumVersion 12.3

				#Create URL for request
				$URI = "$($psPASSession.BaseURI)/WebServices/PIMServices.svc/Safes/$($SafeName |
				Get-EscapedString)"

				break

			}

			default {

				Assert-VersionRequirement -RequiredVersion 12.1

				#Create URL for request
				$URI = "$($psPASSession.BaseURI)/api/Safes/$($SafeName | Get-EscapedString)"

				break

			}

		}

		if ($PSCmdlet.ShouldProcess($SafeName, 'Delete Safe')) {

			#Send request to web service
			Invoke-PASRestMethod -Uri $URI -Method DELETE

		}

	}#process

	END { }#end

}