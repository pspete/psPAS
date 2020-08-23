Function Get-PASDiscoveredAccount {
	<#
	.SYNOPSIS
	Returns discovered accounts from the Pending Accounts list.

	.DESCRIPTION
	Returns discovered accounts from the Pending Accounts list.
	Filters can be specified to limit the results.
	ID can be specified to focus in single account.
	Membership of Vault admins group required.

	.PARAMETER id
	The ID of a discovered account to get details of.

	.PARAMETER platformType
	Whether to return only the accounts of a specific platform
	Valid Values:
	- Windows Server Local
	- Windows Desktop Local
	- Windows Domain
	- Unix
	- Unix SSH Key
	- AWS
	- AWS Access Keys

	.PARAMETER privileged
	Whether to return only privileged accounts or not

	.PARAMETER AccountEnabled
	Whether to return only enabled accounts or not

	.PARAMETER search
	A term to search for.
	Search is supported for userName and address.

	.PARAMETER searchType
	The type of search to perform.
	The keyword can either be contained within the account property values,
	or at the beginning of the value specified in the Search parameter.
	When using a keyword at the beginning of a value, performance is enhanced.

	.PARAMETER offset
	The offset of the first returned accounts into the list of results.

	.PARAMETER limit
	The maximum number of returned accounts. If not specified, the server limits the results to 100.
	The maximum number that can be specified is 1000.

	.EXAMPLE
	Get-PASDiscoveredAccount

	Returns all discovered accounts

	.EXAMPLE
	Get-PASDiscoveredAccount -id 18_88

	Returns discovered account with id 18_88

	.EXAMPLE
	Get-PASDiscoveredAccount -platformType 'Windows Domain' -AccountEnabled $true -privileged $true -search SomeSearchTerm

	Returns discovered accounts matching query

	.LINK
	https://pspas.pspete.dev/commands/Get-PASDiscoveredAccount
	#>
	[CmdletBinding(DefaultParameterSetName = "byQuery")]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "byID"
		)]
		[string]$id,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "byQuery"
		)]
		[ValidateSet("Windows Server Local", "Windows Desktop Local", "Windows Domain", "Unix", "Unix SSH Key", "AWS", "AWS Access Keys")]
		[string]$platformType,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "byQuery"
		)]
		[boolean]$privileged,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "byQuery"
		)]
		[boolean]$AccountEnabled,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "byQuery"
		)]
		[string]$search,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "byQuery"
		)]
		[ValidateSet("startswith", "contains")]
		[string]$searchType,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "byQuery"
		)]
		[int]$offset,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "byQuery"
		)]
		[ValidateRange(1, 1000)]
		[int]$limit

	)

	Begin {

		Assert-VersionRequirement -RequiredVersion 11.6

		#Parameter to include as filter value in url
		$Parameters = [Collections.Generic.List[String]]@("platformType", "privileged", "accountEnabled")

	}

	Process {

		#Create URL for Request
		$URI = "$Script:BaseURI/api/DiscoveredAccounts"

		switch ($PSCmdlet.ParameterSetName) {

			"byID" {

				$URI = "$URI/$id"

				break

			}

			"byQuery" {

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
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		If ($null -ne $Result) {

			If ($PSCmdlet.ParameterSetName -eq "byQuery") {

				#Process nextlink if querying
				$Result = $Result | Get-NextLink

			}

			#Return result
			$Result

		}

	}

	End {}

}