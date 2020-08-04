function ConvertFrom-KeyValuePair {
	<#
.SYNOPSIS
Takes object containing key/value pair
Returns Property=Value object

.DESCRIPTION
Converts:
Key                        Value
---                        -----
PropertyName               False

Into:
UnlockAccounts             : False


.PARAMETER KeyValue
The object(s) containing the key / value pair data

.EXAMPLE
$object | ConvertFrom-KeyValuePair

Returns Key=Value object members for each matching entry in $object

#>
	[CmdletBinding()]
	param (
		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true
		)]
		[ValidateNotNullOrEmpty()]
		[object[]]$KeyValue
	)

	begin {

		$OutputObject = [PSCustomObject]@{ }

	}

	process {

		If ($null -ne $KeyValue) {

			$KeyValue | ForEach-Object {

				If ($null -ne $PSItem.key) {

					$OutputObject | Add-Member -Name $($PSItem.key) -Value $($PSItem.value) -MemberType NoteProperty

				}
			}
		}
	}

	end {
		$OutputObject
	}

}