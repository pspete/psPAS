# .ExternalHelp psPAS-help.xml
function Get-PASRequest {
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Requests'
		)]
		[ValidateNotNullOrEmpty()]
		[ValidateSet('MyRequests', 'IncomingRequests')]
		[string]$RequestType,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'bulkactions'
		)]
		[int]$id,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Requests'
		)]
		[boolean]$OnlyWaiting,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Requests'
		)]
		[boolean]$Expired,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'bulkactions'
		)]
		[boolean]$DisplayExtendedItems
	)

	BEGIN {
		Assert-VersionRequirement -RequiredVersion 9.10
	}#begin

	PROCESS {

		#Create URL for Request
		switch ($PSCmdlet.ParameterSetName) {

			'bulkactions' {

				Assert-VersionRequirement -RequiredVersion 13.2

				$URI = "$($psPASSession.BaseURI)/API/$($PSCmdlet.ParameterSetName)/$id"
				break

			}

			'Requests' {

				$URI = "$($psPASSession.BaseURI)/API/$($RequestType)"
				break

			}

		}

		#Create QueryString
		$queryString = $PSBoundParameters | Get-PASParameter -ParametersToRemove RequestType, id | ConvertTo-QueryString

		if ($null -ne $queryString) {

			#Add QueryString to URL
			$URI = "$URI`?$queryString"

		}

		#send request to PAS web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		If ($null -ne $result) {

			#Return Results
			switch ($PSCmdlet.ParameterSetName) {

				'bulkactions' {

					$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Request.BulkAction
					break

				}

				'Requests' {

					$result.$RequestType | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Request.Details
					break

				}

			}

		}

	}#process

	END { }#end

}