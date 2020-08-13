Function ConvertTo-QueryString {
	<#
.SYNOPSIS
Converts Hashtable to a string for use as a url query string

.DESCRIPTION
When given a hashtable as input, converts key value pairs to query string

.PARAMETER Parameters
Hashtable containing parameter names and values to include in output string

.PARAMETER NoEscape
Specify to perform no escaping on the returned string.

.EXAMPLE
$input | ConvertTo-QueryString

Joins Key & Value with "="
Joins Multiple Key Value pairs with '&'
Formats input as: "Key=Value&Key=Value"

#>
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', 'FilterList', Justification = "False Positive")]
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', 'NoEscape', Justification = "False Positive")]
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
		[switch]$NoEscape
	)

	Begin { }

	Process {

		If ($Parameters) {

			$Parameters.Keys | ForEach-Object {

				$FilterList = [Collections.Generic.List[Object]]@()

			} {

				If ($NoEscape) {

					#Return Key=Value string, unescaped.
					$Value = "$PSItem=$($Parameters[$PSItem])"

				}
				Else {

					#Return Key=Value string, escaped.
					$Value = "$PSItem=$($Parameters[$PSItem] | Get-EscapedString)"

				}

				$null = $FilterList.Add($Value)

			} {

				If ($FilterList.count -gt 0) {

					$FilterList -join "&"

				}
			}

		}

	}

	End { }

}