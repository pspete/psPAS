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

.EXAMPLE
$input | ConvertTo-FilterString

Joins Key & Value with "eq"
Joins Multiple Key Value pairs with ' AND '
Output: @{"filter" = "Key eq Value AND Key eq Value"}

.EXAMPLE
@{modificationTime=(Get-Date)} | ConvertTo-FilterString

@{"filter" = "modificationTime eq 12345678"}


Returns datetime as unixtime, with `gte` operator.

#>
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', 'FilterList', Justification = "False Positive")]
	[CmdletBinding()]
	[OutputType('System.Hashtable')]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[hashtable]$Parameters
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

					default {

						$null = $FilterList.Add("$PSItem eq $($Parameters[$PSItem])")

					}

				}
			} {

				If ($FilterList.count -gt 0) {

					@{"filter" = $FilterList -join " AND " }

				}
			}

		}

	}

	End { }

}