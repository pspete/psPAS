function ConvertTo-QueryString {
	<#
.SYNOPSIS
Converts Hashtable to a string for use as a url query string

.DESCRIPTION
When given a hashtable as input, converts key value pairs to query string

.PARAMETER Parameters
Hashtable containing parameter names and values to include in output string

.PARAMETER NoEscape
Specify to perform no escaping on the returned string.

.PARAMETER Delimiter
Specify the delimiter to use between key-value pairs in the returned string.

.PARAMETER Base64Encode
Specify to Base64 encode the returned string.

.PARAMETER URLEncode
Specify to URL encode the returned string.

.EXAMPLE
$input | ConvertTo-QueryString

Joins Key & Value with "="
Joins Multiple Key Value pairs with '&'
Formats input as: "Key=Value&Key=Value"

#>
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', 'FilterList', Justification = 'False Positive')]
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', 'NoEscape', Justification = 'False Positive')]
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', 'Delimiter', Justification = 'False Positive')]
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', 'Base64Encode', Justification = 'False Positive')]
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', 'URLEncode', Justification = 'False Positive')]
	[CmdletBinding()]
	[OutputType('System.String')]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[hashtable]$Parameters,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $false
		)]
		[switch]$NoEscape,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $false
		)]
		[string]$Delimiter,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $false
		)]
		[switch]$Base64Encode,

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $false
		)]
		[switch]$URLEncode
	)

	begin { }

	process {

		if ($Parameters) {

			$Parameters.GetEnumerator() | ForEach-Object {

				$FilterList = [Collections.Generic.List[Object]]@()

			} {

				if ($NoEscape) {

					#Return Key=Value string, unescaped.
					$Value = "$($PSItem.key)=$($PSItem.value)"

				} else {

					#Return Key=Value string, escaped.
					$Value = "$($PSItem.key)=$($PSItem.value | Get-EscapedString)"

				}

				$null = $FilterList.Add($Value)

			} {

				if ($FilterList.count -gt 0) {

					if ($Delimiter) {
						#Custom Delimiter
						$FilterList = $FilterList -join $Delimiter
					} else {
						#Join multiple Key=Value pairs with '&'
						$FilterList = $FilterList -join '&'
					}

					if ($Base64Encode) {
						#Base64 Encode the query string
						$FilterList = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($FilterList))
					}

					if ($URLEncode) {
						#URL Encode the query string
						$FilterList = [System.Web.HttpUtility]::UrlEncode($FilterList)
					}

				}
			}

		}

	}

	end {
		$FilterList
	}

}