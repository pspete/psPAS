function ConvertTo-StructuredFilterString {
	<#
.SYNOPSIS
Converts Hashtable Key-Value pairs to a structured filter expression string

.DESCRIPTION
When given a hashtable as input, converts key/value pairs into a structured filter expression string,
as used by newer CyberArk API endpoints (e.g. the -filter parameter of Get-PASReport).
Returns a single key hashtable, with the expression string as the value of the "filter" key.

Supports the following operators, matching the CyberArk filter grammar:

- Comparison: EQ, NE, GT, GE, LT, LE
- Set: IN, NOTIN
- String: CONTAINS, NOTCONTAINS, STARTSWITH, ENDSWITH
- Null: IS NULL, IS NOTNULL

By default, a hashtable value is treated as a plain value to compare for equality (EQ).

To use a different operator, prefix the value with the operator keyword, e.g:
	@{status = 'NE Done'}
	@{age = 'GT 5'}
	@{description = 'IS NULL'}
	@{safe = 'IN Safe1,Safe2'}

An array value is treated as an implicit IN list.

Multiple key/value pairs in the input hashtable are joined with a single logical operator - see the
LogicalOperator parameter.

Parenthetical/grouped expressions (mixing AND & OR at different levels of precedence) are not
supported - a flat hashtable cannot express nested groups.
No psPAS function currently requires this; if a future caller needs a mixed-precedence expression,
this function will need to be extended, or a different input shape introduced.

.PARAMETER Parameters
Hashtable containing parameter names and values to include in output

.PARAMETER LogicalOperator
The logical operator (AND/OR) used to join multiple key/value pairs. Defaults to AND.

.PARAMETER QuoteValue
Specify this switch to always enclose string operand values in quotes, even if they contain no
whitespace. String operand values containing whitespace are always quoted, regardless of this switch.

.EXAMPLE
@{status = 'Done'} | ConvertTo-StructuredFilterString

Output: @{"filter" = "status EQ Done"}

.EXAMPLE
@{status = 'NE Done'; age = 'GT 5'} | ConvertTo-StructuredFilterString

Output: @{"filter" = "status NE Done AND age GT 5"}

.EXAMPLE
@{status = 'Done'; safe = 'Prod'} | ConvertTo-StructuredFilterString -LogicalOperator OR

Output: @{"filter" = "status EQ Done OR safe EQ Prod"}

.EXAMPLE
@{description = 'IS NULL'} | ConvertTo-StructuredFilterString

Output: @{"filter" = "description IS NULL"}

.EXAMPLE
@{safe = 'Safe1', 'Safe2'} | ConvertTo-StructuredFilterString

Output: @{"filter" = "safe IN Safe1,Safe2"}

.EXAMPLE
@{name = 'John Smith'} | ConvertTo-StructuredFilterString

Output: @{"filter" = 'name EQ "John Smith"'}

Values containing whitespace are automatically enclosed in quotes.

.NOTES
Based on documentation for filter parameter of Get Reports API endpoint:
https://docs.cyberark.com/pam-self-hosted/15.0/en/content/webservices/get-reports.htm

#>
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', 'FilterList', Justification = 'False Positive')]
	[CmdletBinding()]
	[OutputType('System.Collections.Hashtable')]
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
		[ValidateSet('AND', 'OR')]
		[string]$LogicalOperator = 'AND',

		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $false
		)]
		[switch]$QuoteValue
	)

	begin {

		#Matches a value which is entirely a null-check operator, with no operand
		$NullOperatorPattern = '^(?i)(IS NOTNULL|IS NULL)$'

		#Matches a value prefixed with an operator keyword, capturing the operator and the remaining operand text
		$ValueOperatorPattern = '^(?i)(EQ|NE|GT|GE|LT|LE|CONTAINS|NOTCONTAINS|STARTSWITH|ENDSWITH|NOTIN|IN)\s+(\S.*)$'

	}

	process {

		if ($Parameters) {

			$Parameters.Keys | ForEach-Object {

				$FilterList = [Collections.Generic.List[Object]]@()

			} {

				$Property = $PSItem
				$Value = $Parameters[$PSItem]

				#Note: deliberately if/elseif, not switch - switch auto-enumerates array values
				#element-by-element, and $Matches set inside a switch condition script block is not
				#visible in the case body
				if ($Value -is [datetime]) {

					$Operator = 'EQ'
					$OperandValues = @($Value | ConvertTo-UnixTime)

				} elseif ($Value -is [array]) {

					$Operator = 'IN'
					$OperandValues = $Value

				} elseif (($Value -is [string]) -and ($Value.Trim() -match $NullOperatorPattern)) {

					$Operator = $Matches[1].ToUpper()
					$OperandValues = $null

				} elseif (($Value -is [string]) -and ($Value.Trim() -match $ValueOperatorPattern)) {

					$Operator = $Matches[1].ToUpper()

					if ($Operator -in @('IN', 'NOTIN')) {

						$OperandValues = $Matches[2] -split '\s*,\s*'

					} else {

						$OperandValues = @($Matches[2])

					}

				} else {

					$Operator = 'EQ'
					$OperandValues = @($Value)

				}

				if ($null -eq $OperandValues) {

					$null = $FilterList.Add("$Property $Operator")

				} else {

					$FormattedValues = $OperandValues | ForEach-Object {

						if (($PSItem -is [string]) -and ($QuoteValue -or ($PSItem -match '\s'))) {

							"""$PSItem"""

						} else {

							$PSItem

						}

					}

					$null = $FilterList.Add("$Property $Operator $($FormattedValues -join ',')")

				}

			} {

				if ($FilterList.count -gt 0) {

					@{'filter' = $FilterList -join " $LogicalOperator " }

				}

			}

		}

	}

	end { }

}
