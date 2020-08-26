# .ExternalHelp psPAS-help.xml
function Remove-PASAccount {
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', 'UseClassicAPI', Justification = "False Positive")]
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias("id")]
		[string]$AccountID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "v9"
		)]
		[switch]$UseClassicAPI
	)

	BEGIN {
		#check minimum version
		Assert-VersionRequirement -RequiredVersion 10.4
	}#begin

	PROCESS {

		switch ($PSCmdlet.ParameterSetName) {

			"V9" {

				#Create URL for request (earlier than 10.4)
				$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Accounts/$AccountID"
				break

			}

			default {

				#Create URL for request (Version 10.4 onwards)
				$URI = "$Script:BaseURI/api/Accounts/$AccountID"

			}

		}

		if ($PSCmdlet.ShouldProcess($AccountID, "Delete Account")) {

			#Send request to webservice
			Invoke-PASRestMethod -Uri $URI -Method DELETE -WebSession $Script:WebSession

		}

	}#process

	END { }#end
}