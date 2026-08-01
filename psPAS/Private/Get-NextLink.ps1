function Get-NextLink {
	<#
.SYNOPSIS
Follows & returns values from nextLink URLs

.DESCRIPTION
CyberArk API sometimes provides an object containing a `nextLink` property.
Function follows the URL provided as the value for `nextLink`.
Provides back all results obtained when following `nextLink`.

Some CyberArk APIs instead only provide a `totalCount`/`Total` value, with no
nextLink/nextCursor property. For these, pass the URI used for the initial
request via the RequestUri parameter; subsequent pages are requested by
incrementing an `offset` query parameter against that URI until the reported
total number of results have been collected.

.PARAMETER InitialResult
The value of the initial result containing the `nextLink` property

.PARAMETER BaseURI
The BaseURI to use for the relative NextLink query.
If not specified defaults to $psPASSession.BaseURI

.PARAMETER SavedFilter
A value matching a configured Saved Filters

.PARAMETER RequestUri
The URI used for the initial request.
Required to page through results using an incrementing `offset` query parameter
when the API response only provides a `totalCount` value and no nextLink/nextCursor
property.

.PARAMETER TimeoutSec
See Invoke-WebRequest
Specify a timeout value in seconds

.EXAMPLE
$Result | Get-NextLink

Where result has a `nextLink` property, processes each nextlink and returns results.

.EXAMPLE
$Result | Get-NextLink -RequestUri $URI

Where result has a `totalCount` property but no nextLink/nextCursor, requests
successive pages from $URI via an incrementing offset query parameter.
#>
	[CmdletBinding()]
	param(
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
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'BaseURI'
		)]
		[string]$BaseURI,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$RequestUri,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $false
		)]
		[int]$TimeoutSec
	)

	begin {
		switch ($PSCmdlet.ParameterSetName) {
			'BaseURI' {
				#SH & PCloud BaseURI is sometimes different
				#*Allow PCloud to be specified via parameter
			}
			default {
				#*but default here to the standard
				$BaseURI = $psPASSession.BaseURI
			}
		}
	}

	process {

		$LinkProperty = $null
		$ResultProperty = $null
		$TotalCountMode = $false

		switch ($InitialResult) {
			#SH & PCloud result and nextLink property names differ
			#*Figure out what properties we are dealing with here
			{ $null -ne $PSItem.value } {
				$ResultProperty = 'value'
			}

			{ $null -ne $PSItem.nextLink } {
				$LinkProperty = 'NextLink'
			}

			{ $null -ne $PSItem.items } {
				$ResultProperty = 'items'
			}

			{ $null -ne $PSItem.nextCursor } {
				$LinkProperty = 'nextCursor'
			}
		}

		if (($null -eq $LinkProperty) -and ($null -eq $ResultProperty)) {

			#API may only provide a totalCount/Total value, with no nextLink/nextCursor.
			#Figure out which (if either) of these count property names is present.
			$CountProperty = 'totalCount', 'Total' | Where-Object { $null -ne $InitialResult.$PSItem } | Select-Object -First 1

			if ($null -ne $CountProperty) {

				#page via an incrementing offset query parameter instead of a nextLink/nextCursor.
				#Find the property holding the returned items.
				$ResultProperty = $InitialResult.PSObject.Properties |
					Where-Object { ($PSItem.Name -ne $CountProperty) -and ($PSItem.Value -is [System.Collections.IEnumerable]) -and ($PSItem.Value -isnot [string]) } |
					Select-Object -First 1 -ExpandProperty Name

				$TotalCount = $InitialResult.$CountProperty
				$TotalCountMode = $true

			}

		}

		#Proceed if there are results
		if (($null -ne $InitialResult.${ResultProperty}) -and ($InitialResult.${ResultProperty}.Count -gt 0)) {

			#store list of initial query results
			$Result = [Collections.Generic.List[Object]]::New(($InitialResult.${ResultProperty}))

			#!SavedFilter is not inclduded in NextLink value.
			#* Create a query parameter for SavedFilter to include in URL
			$queryString = $PSBoundParameters | Get-PASParameter -ParametersToKeep SavedFilter | ConvertTo-QueryString

			if ($TotalCountMode) {

				#page via an incrementing offset query parameter against the original request URI
				while ($Result.Count -lt $TotalCount) {

					$Separator = if ($RequestUri -match '\?') { '&' } else { '?' }
					$URI = "$RequestUri${Separator}offset=$($Result.Count)"

					if ($null -ne $queryString) {

						$URI = "$URI&$queryString"

					}

					$NextResult = Invoke-PASRestMethod -Uri $URI -Method GET -TimeoutSec $TimeoutSec
					$PageResults = $NextResult.$ResultProperty

					if (($null -eq $PageResults) -or ($PageResults.Count -eq 0)) {

						break

					}

					$null = $Result.AddRange($PageResults)

				}

			} else {

				#iterate any nextLinks
				$NextLink = $InitialResult.$LinkProperty

				while ( $null -ne $NextLink ) {

					$URI = "$BaseURI/$NextLink"

					#*If there is a SavedFilter querystring, append it to the URL
					if ($null -ne $queryString) {

						#Build URL from base URL/NextLink
						$URI = "$URI`&$queryString"

					}

					$NextResult = Invoke-PASRestMethod -Uri $URI -Method GET -TimeoutSec $TimeoutSec
					$NextLink = $NextResult.$LinkProperty
					$null = $Result.AddRange(($NextResult.$ResultProperty))

				}

			}

			#return list
			$Result

		}

	}

	end {}

}
