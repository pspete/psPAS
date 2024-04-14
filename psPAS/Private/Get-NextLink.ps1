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

	.PARAMETER BaseURI
	The BaseURI to use for the relative NextLink query.
	If not specified defaults to $psPASSession.BaseURI

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
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'BaseURI'
		)]
		[string]$BaseURI,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $false
		)]
		[int]$TimeoutSec
	)

	Begin {
		Switch ($PSCmdlet.ParameterSetName) {
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

	Process {

		switch ($InitialResult) {
			#SH & PCloud result and nextLink proprty names differ
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

		#Proceed if there are results
		If (($null -ne $InitialResult.${ResultProperty}) -and ($InitialResult.${ResultProperty}.Count -gt 0)) {

			#store list of initial query results
			$Result = [Collections.Generic.List[Object]]::New(($InitialResult.${ResultProperty}))

			#iterate any nextLinks
			$NextLink = $InitialResult.$LinkProperty

			#!SavedFilter is not inclduded in NextLink value.
			#* Create a query parameter for SavedFilter to include in URL
			$queryString = $PSBoundParameters | Get-PASParameter -ParametersToKeep SavedFilter | ConvertTo-QueryString

			While ( $null -ne $NextLink ) {

				$URI = "$BaseURI/$NextLink"

				#*If there is a SavedFilter querystring, append it to the URL
				If ($null -ne $queryString) {

					#Build URL from base URL/NextLink
					$URI = "$URI`&$queryString"

				}

				$NextResult = Invoke-PASRestMethod -Uri $URI -Method GET -TimeoutSec $TimeoutSec
				$NextLink = $NextResult.$LinkProperty
				$null = $Result.AddRange(($NextResult.$ResultProperty))

			}

			#return list
			$Result

		}

	}

	End {}

}