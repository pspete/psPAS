# .ExternalHelp psPAS-help.xml
function Get-PASDependentAccount {
	[CmdletBinding(DefaultParameterSetName = 'AllDependentAccounts')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'SpecificAccount'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'SpecificDependentAccount'
		)]
		[Alias('AccountID')]
		[string]$id,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'SpecificDependentAccount'
		)]
		[string]$dependentAccountId,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'AllDependentAccounts'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'SpecificAccount'
		)]
		[string]$search,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'AllDependentAccounts'
		)]
		[string]$MasterAccountId,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'AllDependentAccounts'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'SpecificAccount'
		)]
		[datetime]$modificationTime,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'AllDependentAccounts'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'SpecificAccount'
		)]
		[string]$platformId,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'AllDependentAccounts'
		)]
		[string]$SafeName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'AllDependentAccounts'
		)]
		[bool]$includeDeleted,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'SpecificAccount'
		)]
		[bool]$failed,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'SpecificDependentAccount'
		)]
		[bool]$extendedDetails,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'AllDependentAccounts'
		)]
		[ValidateRange(1, 1000)]
		[int]$limit,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $false
		)]
		[int]$TimeoutSec

	)

	begin {

		#check required version
		Assert-VersionRequirement -RequiredVersion 14.6

		#Parameter to include as filter value in url
		$Parameters = [Collections.Generic.List[String]]@('MasterAccountId', 'modificationTime', 'platformId', 'SafeName')

	}#begin

	process {

		#Get Parameters to include in request
		$boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove $Parameters, id, dependentAccountId
		$filterParameters = $PSBoundParameters | Get-PASParameter -ParametersToKeep $Parameters
		$FilterString = $filterParameters | ConvertTo-FilterString

		switch ($PSCmdlet.ParameterSetName) {

			'SpecificAccount' {

				#define base URL
				$URI = "$($psPASSession.BaseURI)/API/Accounts/$id/dependentAccounts"
				break

			}

			'AllDependentAccounts' {

				#define base URL
				$URI = "$($psPASSession.BaseURI)/API/dependentAccounts"

				if ($PSBoundParameters.Keys -notcontains 'Limit') {
					$Limit = 100   #default limit
					$boundParameters.Add('Limit', $Limit) # Add to boundparameters for inclusion in query string
				}

				break

			}

			'SpecificDependentAccount' {

				#define base URL
				$URI = "$($psPASSession.BaseURI)/API/Accounts/$id/dependentAccounts/$($dependentAccountId)"
				break

			}

		}

		if ($null -ne $FilterString) {

			$boundParameters = $boundParameters + $FilterString

		}

		#Create Query String, escaped for inclusion in request URL
		$queryString = $boundParameters | ConvertTo-QueryString

		if ($null -ne $queryString) {

			#Build URL from base URL
			$URI = "$URI`?$queryString"

		}

		#Send request to web service
		# Initial request
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -TimeoutSec $TimeoutSec
		$Total = $result.Total

		if ($Total -eq $Limit) {

			$DependentAccounts = [Collections.Generic.List[Object]]::New(@($result.DependentAccounts))

			$URLString = $URI.Split('?')
			$URI = $URLString[0]
			$queryString = if ($URLString.Count -gt 1) { $URLString[1] } else { '' }

			$queryString = (( $queryString -split '&' ) | Where-Object {
					($_ -notmatch '^limit=') -and ($_ -notmatch '^offset=')
				}) -join '&'

			$Offset = $Limit
			do {
				$nextLink = "limit=$Limit&Offset=$Offset"
				if ($queryString) {
					$nextLink = "$queryString&$nextLink"
				}

				try {
					$result = Invoke-PASRestMethod -Uri "$URI`?$nextLink" -Method GET -TimeoutSec $TimeoutSec
				} catch {
					# Error retrieving additional pages of results
					# We have to check for this because Total only reflects Page Size
					# Page Size Could equal the total number of results on the final page
					# So we just break out of the loop if an error occurs
					break
				}
				$pageCount = $result.DependentAccounts.Count

				$Null = $DependentAccounts.AddRange($result.DependentAccounts)

				$Offset += $Limit

				if ($pageCount -lt $Limit) {
					break
				}
			}
			while ($true)

			$Result = $DependentAccounts

		}


		if ($null -ne $result) {

			$Result

		}

	}#process

	end { }#end

}