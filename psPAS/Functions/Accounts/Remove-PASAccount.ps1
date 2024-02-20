# .ExternalHelp psPAS-help.xml
function Remove-PASAccount {
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', 'UseGen1API', Justification = 'False Positive')]
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('id')]
		[string]$AccountID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = 'Gen1'
		)]
		[Alias('UseClassicAPI')]
		[switch]$UseGen1API
	)

	BEGIN {
		#check minimum version
		Assert-VersionRequirement -RequiredVersion 10.4
	}#begin

	PROCESS {

		switch ($PSCmdlet.ParameterSetName) {

			'Gen1' {

				#Create URL for request (earlier than 10.4)
				$URI = "$($psPASSession.BaseURI)/WebServices/PIMServices.svc/Accounts/$AccountID"
				break

			}

			default {

				#Create URL for request (Version 10.4 onwards)
				$URI = "$($psPASSession.BaseURI)/api/Accounts/$AccountID"

			}

		}

		if ($PSCmdlet.ShouldProcess($AccountID, 'Delete Account')) {

			#Send request to webservice
			Invoke-PASRestMethod -Uri $URI -Method DELETE

		}

	}#process

	END { }#end

}