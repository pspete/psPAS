Function ConvertTo-FilterString {
	<#
.SYNOPSIS
Converts Hashtable Key-Value pairs to a string for use as a Filter value

.DESCRIPTION
When given a hashtable as input, converts key value pairs to filter string.
Returns single key hashtable, with string as value of the "filter" key.
If an input key is `modificationTime` (from Get-PASAccount), it is expected to have a datetime value;
this will be converted to unixtime, the operator for the filter value will be 'gte' rather than 'eq'.

.PARAMETER Parameters
Hashtable containing parameter names and values to include in output

.PARAMETER QuoteValue
Specify this switch to enclose the value of a key value pair in quotes when converting to a filter string

.EXAMPLE
$input | ConvertTo-FilterString

Joins Key & Value with "eq"
Joins Multiple Key Value pairs with ' AND '
Output: @{"filter" = "Key eq Value AND Key eq Value"}

.EXAMPLE
@{modificationTime=(Get-Date)} | ConvertTo-FilterString

@{"filter" = "modificationTime eq 12345678"}


Returns datetime as unixtime, with `gte` operator.

.EXAMPLE
$ht | ConvertTo-FilterString -QuoteValue

Name                           Value
----                           -----
filter                         Some eq "Value"

Encloses value of the key/value pair in quotes.

#>
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', 'FilterList', Justification = 'False Positive')]
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', '', Justification = 'False Positive')]
	[CmdletBinding()]
	[OutputType('System.Hashtable')]
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
		[switch]$QuoteValue
	)

	Begin {

	}

	Process {

		If ($Parameters) {

			$Parameters.Keys | ForEach-Object {

				$FilterList = [Collections.Generic.List[Object]]@()

			} {
				switch ($PSItem) {

					modificationTime {

						$null = $FilterList.Add("modificationTime gte $($Parameters[$PSItem] | ConvertTo-UnixTime)")

					}

					detectionTime {

						$null = $FilterList.Add("$PSItem $($Parameters[$PSItem])")

					}

					default {

						$value = $($Parameters[$PSItem])

						if ($QuoteValue) { $value = """$value""" }

						$null = $FilterList.Add("$PSItem eq $value")

					}

				}
			} {

				If ($FilterList.count -gt 0) {

					@{'filter' = $FilterList -join ' AND ' }

				}
			}

		}

	}

	End { }

}