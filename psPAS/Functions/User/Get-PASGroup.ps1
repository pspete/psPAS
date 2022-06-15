# .ExternalHelp psPAS-help.xml
function Get-PASGroup {
	[CmdletBinding(DefaultParameterSetName = 'groupType')]
	param(
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
			ParameterSetName = 'filter'
		)]
		[ValidateSet('groupType eq Directory', 'groupType eq Vault')]
		[string]$filter,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'groupType'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'filter'
		)]
		[string[]]$sort,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$search,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$includeMembers
	)

	BEGIN {
		Assert-VersionRequirement -RequiredVersion 10.5
	}#begin

	PROCESS {

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

		#Create URL for request
		$URI = "$Script:BaseURI/API/UserGroups"

		#Get Parameters to include in request
		$boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove groupType, groupName
		$filterProperties = $PSBoundParameters | Get-PASParameter -ParametersToKeep groupType, groupName
		$FilterString = $filterProperties | ConvertTo-FilterString

		If ($null -ne $FilterString) {

			$boundParameters = $boundParameters + $FilterString

		}

		#Create Query String, escaped for inclusion in request URL
		$queryString = $boundParameters | ConvertTo-QueryString

		if ($null -ne $queryString) {

			#Build URL from base URL
			$URI = "$URI`?$queryString"

		}

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		If ($null -ne $result) {

			$result.value | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Group

		}

	}#process

	END { }#end

}