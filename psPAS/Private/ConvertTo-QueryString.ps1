Function ConvertTo-QueryString {
	<#
.SYNOPSIS
Converts Hastable to a string for use as a url query string

.DESCRIPTION
When given a hashtable as input, converts key value pairs to query string

.PARAMETER Parameters
Hashtable containing parameter names and values to include in output string

.PARAMETER Format
Provide value of "Filter" to output string as REST filter

.EXAMPLE
$input | ConvertTo-QueryString

Joins Key & Value with "="
Joins Multiple Key Value pairs with '&'
Formats input as: "Key=Value&Key=Value"

.EXAMPLE
$input | ConvertTo-QueryString -Format Filter

Joins Key & Value with "eq"
Joins Multiple Key Value pairs with ' AND '
Formats input as: "Key%20eq%20Value%20AND%20Key%20eq%20Value"
#>

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
		[ValidateSet("Filter")]
		[string]$Format
	)

	Begin { }

	Process {

		If ($Parameters) {

			Switch ($Format) {

				"Filter" {

					($Parameters.Keys | ForEach-Object {

							"$PSItem eq $($Parameters[$PSItem])"

						}) -join ' AND ' | Get-EscapedString

				}

				default {

					($Parameters.Keys | ForEach-Object {

							"$PSItem=$($Parameters[$PSItem] | Get-EscapedString)"

						}) -join '&'

				}

			}

		}

	}

	End { }

}