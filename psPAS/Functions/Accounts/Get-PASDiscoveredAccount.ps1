# .ExternalHelp psPAS-help.xml
Function Get-PASDiscoveredAccount {
	[CmdletBinding(DefaultParameterSetName = 'byQuery')]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'byID'
		)]
		[string]$id,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'byQuery'
		)]
		[ValidateSet('Windows Server Local', 'Windows Desktop Local', 'Windows Domain', 'Unix', 'Unix SSH Key', 'AWS', 'AWS Access Keys', 'Azure Password Management')]
		[string]$platformType,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'byQuery'
		)]
		[boolean]$privileged,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'byQuery'
		)]
		[boolean]$AccountEnabled,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'byQuery'
		)]
		[string]$search,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'byQuery'
		)]
		[ValidateSet('startswith', 'contains')]
		[string]$searchType,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'byQuery'
		)]
		[ValidateRange(1, 1000)]
		[int]$limit

	)

	Begin {

		Assert-VersionRequirement -RequiredVersion 11.6

		#Parameter to include as filter value in url
		$Parameters = [Collections.Generic.List[String]]@('platformType', 'privileged', 'accountEnabled')

	}

	Process {

		#Create URL for Request
		$URI = "$($psPASSession.BaseURI)/api/DiscoveredAccounts"

		switch ($PSCmdlet.ParameterSetName) {

			'byID' {

				$URI = "$URI/$id"

				break

			}

			'byQuery' {

				If ($platformType -eq 'Azure Password Management') {

					Assert-VersionRequirement -RequiredVersion 11.7

				}

				#Get Parameters to include in request
				$boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove $Parameters
				$filterParameters = $PSBoundParameters | Get-PASParameter -ParametersToKeep $Parameters
				$FilterString = $filterParameters | ConvertTo-FilterString

				If ($null -ne $FilterString) {

					$boundParameters = $boundParameters + $FilterString

				}

				#Create Query String, escaped for inclusion in request URL
				$queryString = $boundParameters | ConvertTo-QueryString

				If ($null -ne $queryString) {

					#Build URL from base URL
					$URI = "$URI`?$queryString"

				}

				break

			}

		}

		#Send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		If ($null -ne $Result) {

			If ($PSCmdlet.ParameterSetName -eq 'byQuery') {

				#Process nextlink if querying
				$Result = $Result | Get-NextLink

			}

			#Return result
			$Result

		}

	}

	End {}

}