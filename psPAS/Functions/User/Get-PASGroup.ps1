# .ExternalHelp psPAS-help.xml
function Get-PASGroup {
	[CmdletBinding(DefaultParameterSetName = 'groupType')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'byID'
		)]
		[int]$id,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'groupType'
		)]
		[ValidateSet('Directory', 'Vault')]
		[string]$groupType,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'groupType'
		)]
		[string]$groupName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'groupType'
		)]
		[string[]]$sort,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'groupType'
		)]
		[string]$search,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'byID'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'groupType'
		)]
		[boolean]$includeMembers
	)

	BEGIN {
		Assert-VersionRequirement -RequiredVersion 10.5

		#Parameter to include in request
		$Parameters = [Collections.Generic.List[Object]]::New(@('groupType', 'groupName', 'id'))

	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/API/UserGroups"

		#Get Parameters to include in request
		$boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove $Parameters

		switch ($PSCmdlet.ParameterSetName) {

			'ByID' {

				#id parameter require 12.6
				Assert-VersionRequirement -RequiredVersion 12.6

				#Create URL for request
				$URI = "$URI/$id/"

				break

			}

			default {

				switch ($PSBoundParameters.Keys) {

					{ $_ -match 'includeMembers' } {

						#includeMembers parameter require 12.0
						Assert-VersionRequirement -RequiredVersion 12.0

						continue

					}

					{ $_ -match 'sort|groupName' } {

						#Sort parameter require 12.2
						Assert-VersionRequirement -RequiredVersion 12.2

					}

				}

				#Parse parameters to include as filter value in url
				$null = $Parameters.Remove('id')
				$filterProperties = $PSBoundParameters | Get-PASParameter -ParametersToKeep $Parameters
				$FilterString = $filterProperties | ConvertTo-FilterString

				If ($null -ne $FilterString) {

					$boundParameters = $boundParameters + $FilterString

				}

			}

		}

		#Create Query String, escaped for inclusion in request URL
		$queryString = $boundParameters | ConvertTo-QueryString

		if ($null -ne $queryString) {

			#Build URL from base URL
			$URI = "$URI`?$queryString"

		}

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		If ($null -ne $result) {

			switch ($PSCmdlet.ParameterSetName) {

				'groupType' {

					$result = $result.value

					Continue

				}

			}

			$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Group

		}

	}#process

	END { }#end

}