Function Get-NextLink {
	<#
	.SYNOPSIS
	Follows & returns values from nextLink URLs

	.DESCRIPTION
	CyberArk API sometimes provides an object containing a `nextLink` property.
	Function follows the URL provided as the value for `nextLink`.
	Provides back all results obtained when following `nextLink`.

	.PARAMETER InitialResult
	The value of the initial result containing the `nextLink` property

	.PARAMETER SavedFilter
	A value matching a configured Saved Filters

	.PARAMETER TimeoutSec
	See Invoke-WebRequest
	Specify a timeout value in seconds

	.EXAMPLE
	$Result | Get-NextLink

	Where result has a `nextLink` property, processes each nextlink and returns results.
	#>
	[CmdletBinding()]
	Param(
		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		$InitialResult,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$SavedFilter,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $false
		)]
		[int]$TimeoutSec
	)

	Begin {}

	Process {

		If ($null -ne $InitialResult.value) {

			#store list of query results
			$Result = [Collections.Generic.List[Object]]::New(($InitialResult.value))

			#iterate any nextLinks
			$NextLink = $InitialResult.nextLink

			#!SavedFilter is not inclduded in NextLink value.
			#* Create a query parameter for SavedFilter to include in URL
			$queryString = $PSBoundParameters | Get-PASParameter -ParametersToKeep SavedFilter | ConvertTo-QueryString

			While ( $null -ne $NextLink ) {

				$URI = "$($psPASSession.BaseURI)/$NextLink"

				#*If there is a SavedFilter querystring, append it to the URL
				If ($null -ne $queryString) {

					#Build URL from base URL/NextLink
					$URI = "$URI`&$queryString"

				}

				$NextResult = Invoke-PASRestMethod -Uri $URI -Method GET -TimeoutSec $TimeoutSec
				$NextLink = $NextResult.nextLink
				$null = $Result.AddRange(($NextResult.value))

			}

			#return list
			$Result

		}

	}

	End {}

}