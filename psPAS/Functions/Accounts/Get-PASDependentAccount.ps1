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
		#check if Privilege Cloud
		$isPcloud = $false
		if ($psPASSession.BaseUri -match 'cyberark.cloud') {
			$isPcloud = $true
		}

		#Parameter to include as filter value in url
		$Parameters = [Collections.Generic.List[String]]@('MasterAccountId', 'modificationTime', 'platformId', 'SafeName')
		# Parameters that should not be included in filter string
		$IDParameters = [Collections.Generic.List[String]]@('id', 'dependentAccountId')

	}#begin

	process {

		#Get Parameters to include in request
		$boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove @($Parameters + $IDParameters)
		$filterParameters = $PSBoundParameters | Get-PASParameter -ParametersToKeep $Parameters
		$FilterString = $filterParameters | ConvertTo-FilterString

		# Determine base URI
		switch ($PSCmdlet.ParameterSetName) {

			'SpecificAccount' {
				if ($isPcloud) {
					$URI = "$($psPASSession.ApiURI)/api/accounts/$id/account-dependents"
				}
				else {
					$URI = "$($psPASSession.BaseURI)/API/Accounts/$id/dependentAccounts"
				}
			}

			'AllDependentAccounts' {
				if ($isPcloud) {
					Throw "Privilege Cloud implementation does not support getting all dependent accounts. Please specify a specific account to get dependent accounts."
				}
				else {
					$URI = "$($psPASSession.BaseURI)/API/dependentAccounts"
				}

				if ($PSBoundParameters.Keys -notcontains 'Limit') {
					$Limit = 100   #default limit
					$boundParameters.Add('Limit', $Limit) # Add to boundparameters for inclusion in query string
				}
			}

			'SpecificDependentAccount' {
				if ($isPcloud) {
					$URI = "$($psPASSession.ApiURI)/api/accounts/$id/account-dependents/$($dependentAccountId)"
				}
				else {
					$URI = "$($psPASSession.BaseURI)/API/Accounts/$id/dependentAccounts/$($dependentAccountId)"
				}
			}

		}

		# Append filter string if present
		if ($null -ne $FilterString) {

			$boundParameters = $boundParameters + $FilterString

		}

		# Build query string
		$queryString = $boundParameters | ConvertTo-QueryString
		if ($queryString) {
			$URI = "$URI`?$queryString"
		}

		# Initial request
		$Result = Invoke-PASRestMethod -Uri $URI -Method GET -TimeoutSec $TimeoutSec
		$Total = $Result.Total

		if ($Total -gt 1) {
			$DependentAccounts = [Collections.Generic.List[Object]]::New(@($Result.DependentAccounts))
		}
		# If pagination is needed
		if ($Total -eq $Limit) {

			# Split and sanitize query string
			$URLParts = $URI.Split('?')
			$BaseURI = $URLParts[0]
			$queryString = if ($URLParts.Count -gt 1) { $URLParts[1] } else { '' }
			$queryString = (($queryString -split '&') | Where-Object {
					($_ -notmatch '^limit=') -and ($_ -notmatch '^offset=')
				}) -join '&'

			# Begin pagination
			$Offset = $Limit
			$pageCount = $Limit

			while ($pageCount -eq $Limit) {
				$nextLink = "limit=$Limit&Offset=$Offset"
				if ($queryString) {
					$nextLink = "$queryString&$nextLink"
				}

				try {
					$pageResult = Invoke-PASRestMethod -Uri "$BaseURI`?$nextLink" -Method GET -TimeoutSec $TimeoutSec
				} catch {
					# Pagination failed at Offset - terminate the loop."
					break
				}

				$pageCount = $pageResult.DependentAccounts.Count
				$Null = $DependentAccounts.AddRange($pageResult.DependentAccounts)
				$Offset += $Limit
			}

		}

		if ($null -ne $DependentAccounts) {
			$Result = $DependentAccounts
		}

		if ($null -ne $Result) {
			$Result
		}
	}

	end { }#end

}