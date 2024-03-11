# .ExternalHelp psPAS-help.xml
function Get-PASAccountActivity {
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', 'UseGen1API', Justification = 'False Positive')]
	[CmdletBinding(DefaultParameterSetName = 'Gen2')]
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

	BEGIN {	}#begin

	PROCESS {

		switch ($PSCmdlet.ParameterSetName) {

			'Gen1' {

				#!Depracated above 13.2
				Assert-VersionRequirement -MaximumVersion 13.2
				#URL for Request
				$URI = "$($psPASSession.BaseURI)/WebServices/PIMServices.svc"

				break

			}

			default {

				Assert-VersionRequirement -RequiredVersion 13.2
				#URL for Request
				$URI = "$($psPASSession.BaseURI)/api"

			}

		}

		#Create request URL
		$URI = "$URI/Accounts/$($AccountID | Get-EscapedString)/Activities"

		#Send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		If ($null -ne $result) {

			switch ($PSCmdlet.ParameterSetName) {

				'Gen1' {

					$result = $result.GetAccountActivitiesResult
					$typename = 'psPAS.CyberArk.Vault.Account.Activity'

					break

				}

				default {

					$result = $result.Activities
					$typename = 'psPAS.CyberArk.Vault.Account.Activity.Gen2'

				}

			}

			#Return Results
			$result | Add-ObjectDetail -typename $typename

		}

	}#process

	END { }#end

}