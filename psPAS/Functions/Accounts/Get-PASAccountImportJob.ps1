# .ExternalHelp psPAS-help.xml
Function Get-PASAccountImportJob {
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'byID'
		)]
		[string]$id
	)

	Begin {

		Assert-VersionRequirement -RequiredVersion 11.6

	}

	Process {

		#Create URL for Request
		$URI = "$($psPASSession.BaseURI)/api/bulkactions/accounts"

		If ($PSCmdlet.ParameterSetName -eq 'byID') {

			$URI = "$URI/$id"

		}

		#send request
		$Result = Invoke-PASRestMethod -Uri $URI -Method GET

		If ($null -ne $Result) {

			If ($PSCmdlet.ParameterSetName -ne 'byID') {

				$Result = $Result.BulkActions

			}

			$Result | Add-ObjectDetail -typename 'psPAS.CyberArk.Vault.Account.Job'

		}

	}

	End {}

}