# .ExternalHelp psPAS-help.xml
function Get-PASSafe {
	[CmdletBinding(DefaultParameterSetName = 'Gen2')]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$search,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[ValidateSet('safeName', 'managingCPM')]
		[string]$sort,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[ValidateSet('asc', 'desc')]
		[string]$sortDirection,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2-byName'
		)]
		[ValidateNotNullOrEmpty()]
		[Boolean]$includeAccounts,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[ValidateNotNullOrEmpty()]
		[Boolean]$extendedDetails,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1-byName'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2-byName'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$SafeName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2-byName'
		)]
		[ValidateNotNullOrEmpty()]
		[Boolean]$useCache,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = 'Gen1-byQuery'
		)]
		[string]$query,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = 'Gen1-byAll'
		)]
		[switch]$FindAll,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1-byName'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = 'Gen1-byAll'
		)]
		[switch]$UseGen1API,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $false
		)]
		[int]$TimeoutSec
	)

	begin {

		$typeName = 'psPAS.CyberArk.Vault.Safe'
		$Limit = 25   #default if you call the API with no value

	}#begin

	process {

		$boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove sortDirection

		if ($PSBoundParameters.containsKey('sortDirection')) {

			#Append sort direction to sort property for correct query string creation
			$boundParameters['sort'] = "$($boundParameters['sort']) $($PSBoundParameters['sortDirection'])"

		}

		#Create Query String, escaped for inclusion in request URL
		$queryString = $boundParameters | ConvertTo-QueryString

		switch ($PSCmdlet.ParameterSetName) {

			'Gen2' {

				#assign new type name
				$typeName = "$typeName.Gen2"

				switch ($PSBoundParameters) {

					( { $PSItem.ContainsKey('extendedDetails') }) {

						#check required version
						Assert-VersionRequirement -RequiredVersion 12.1

						if ($extendedDetails -eq $false) {

							#assign new type name
							$typeName = "$typeName.Name"

						}

					}

					default {

						Assert-VersionRequirement -RequiredVersion 12.0

					}

				}

				$returnProperty = 'value'

				#define base URL
				$URI = "$($psPASSession.BaseURI)/API/Safes"

				if ($null -ne $queryString) {

					#Build URL from base URL
					$URI = "$URI`?$queryString"

				}

				break

			}

			'Gen2-ByName' {

				#assign new type name
				$typeName = "$typeName.Gen2"

				Assert-VersionRequirement -RequiredVersion 12.2

				#define base URL
				$URI = "$($psPASSession.BaseURI)/API/Safes/$($SafeName | Get-EscapedString)"

				$boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove SafeName

				#Create Query String, escaped for inclusion in request URL
				$queryString = $boundParameters | ConvertTo-QueryString

				if ($null -ne $queryString) {

					#Build URL from base URL
					$URI = "$URI`?$queryString"

				}

				break

			}

			( { $PSItem -match '^Gen1-' } ) {

				#check required version
				Assert-VersionRequirement -MaximumVersion 12.3

				#Create URL for Gen1 API requests
				$URI = "$($psPASSession.BaseURI)/WebServices/PIMServices.svc/Safes"

			}

			'Gen1-byName' {

				$returnProperty = 'GetSafeResult'

				#Build URL from base URL
				$URI = "$URI/$($SafeName | Get-EscapedString)"

				break

			}

			'Gen1-byQuery' {

				$returnProperty = 'SearchSafesResult'

				if ($null -ne $queryString) {

					#Build URL from base URL
					$URI = "$URI`?$queryString"

				}

				break

			}

			'Gen1-byAll' {

				$returnProperty = 'GetSafesResult'

				break

			}

		}

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -TimeoutSec $TimeoutSec

		switch ($PSCmdlet.ParameterSetName) {

			( { $PSItem -match '^Gen1-' } ) {

				$Total = $result.Total

				if ($Total -gt 0) {

					$Safes = [Collections.Generic.List[Object]]::New(($result.$returnProperty))

					for ( $Offset = $Limit ; $Offset -lt $Total ; $Offset += $Limit ) {

						$Null = $Safes.AddRange((Invoke-PASRestMethod -Uri "$URI`?limit=$Limit&OffSet=$Offset$searchQuery" -Method GET -TimeoutSec $TimeoutSec).Safes)

					}

					$return = $Safes

				}

				elseif ($null -ne $result) {

					$return = $result.$returnProperty

				}

				break

			}

			'Gen2' {

				#return list
				$return = $Result | Get-NextLink -TimeoutSec $TimeoutSec

				break

			}

			default {

				#return result (Gen2-ByName)
				$return = $Result

				break

			}

		}

		if ($null -ne $return) {

			#Return Results
			$return | Add-ObjectDetail -typename $typeName

		}

	}#process

	end { }#end

}