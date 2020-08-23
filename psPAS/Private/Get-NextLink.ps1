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

			While ( $null -ne $NextLink ) {

				$URI = "$Script:BaseURI/$NextLink"
				$NextResult = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession -TimeoutSec $TimeoutSec
				$NextLink = $NextResult.nextLink
				$null = $Result.AddRange(($NextResult.value))

			}

			#return list
			$Result

		}

	}

	End {}

}