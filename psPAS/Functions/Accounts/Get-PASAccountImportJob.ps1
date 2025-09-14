# .ExternalHelp psPAS-help.xml
function Get-PASAccountImportJob {
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'byID'
		)]
		[string]$id
	)

	begin {

		Assert-VersionRequirement -RequiredVersion 11.6

	}

	process {

		#Create URL for Request
		$URI = "$($psPASSession.BaseURI)/api/bulkactions/accounts"

		if ($PSCmdlet.ParameterSetName -eq 'byID') {

			$URI = "$URI/$id"

		}

		#send request
		$Result = Invoke-PASRestMethod -Uri $URI -Method GET

		if ($null -ne $Result) {

			if ($PSCmdlet.ParameterSetName -ne 'byID') {

				$Result = $Result.BulkActions

			}

			$Result | Add-ObjectDetail -typename 'psPAS.CyberArk.Vault.Account.Job'

		}

	}

	end {}

}