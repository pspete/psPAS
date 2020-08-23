Function Get-PASAccountImportJob {
	<#
	.SYNOPSIS
	Gets the status of bulk account upload jobs performed by the user.

	.DESCRIPTION
	Returns the result of all bulk account upload jobs, or an individual job identified by it's ID.
	Once the upload has finished, the API returns the result.
	The result contains a list of all the accounts that succeeded or failed to upload.

	.PARAMETER id
	The identifier for the bulk account upload.

	.EXAMPLE
	Get-PASAccountImportJob

	Returns status details of user's account upload jobs

	.EXAMPLE
	Get-PASAccountImportJob -id 4

	Returns status details of user's account upload job with id of 4

	.LINK
	https://pspas.pspete.dev/commands/Get-PASAccountImportJob
	#>
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "byID"
		)]
		[string]$id
	)

	Begin {

		Assert-VersionRequirement -RequiredVersion 11.6

	}

	Process {

		#Create URL for Request
		$URI = "$Script:BaseURI/api/bulkactions/accounts"

		If ($PSCmdlet.ParameterSetName -eq "byID") {

			$URI = "$URI/$id"

		}

		#send request
		$Result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		If ($null -ne $Result) {

			If ($PSCmdlet.ParameterSetName -ne "byID") {

				$Result = $Result.BulkActions

			}

			$Result | Add-ObjectDetail -typename "psPAS.CyberArk.Vault.Account.Job"

		}

	}

	End {}

}