# .ExternalHelp psPAS-help.xml
Function Start-PASAccountImportJob {
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$source,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[object[]]$accountsList
	)

	Begin {

		Assert-VersionRequirement -RequiredVersion 11.6

		#Create URL for Request
		$URI = "$($psPASSession.BaseURI)/api/bulkactions/accounts"

	}

	Process {

		#Get all parameters that will be sent in the request
		$boundParameters = $PSBoundParameters | Get-PASParameter

		#Create body of request
		$body = $boundParameters | Get-PASParameter | ConvertTo-Json -Depth 3

		if ($PSCmdlet.ShouldProcess("List of $($accountsList.count) account(s)", 'Start Bulk Account Import Job')) {

			#send request
			$Result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body

			If ($null -ne $Result) {

				#Return Results
				try {

					#Query Import Job Status
					Get-PASAccountImportJob -id $Result

				}

				catch {

					#Return Import Job ID
					[PSCustomObject]@{'id' = $Result }

				}

			}

		}

	}

	End {}

}