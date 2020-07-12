function Get-EscapedString {
	<#
.SYNOPSIS
Outputs escaped string value.

.DESCRIPTION
Wrapper for the System.Uri EscapeDataString method.
When provided with an input string, an escaped string will be output.
This can be used for forming URLs and query strings where spaces are not allowed.

.PARAMETER inputString
String to escape

.EXAMPLE
"Safe Name" | Get-EscapedString

.INPUTS
String Value

.OUTPUTS
Escaped String Value
#>
	[CmdletBinding()]
	[OutputType('System.String')]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[string]$inputString

	)

	Begin {}

	Process {

		#Output escaped string
		[System.Uri]::EscapeDataString($inputString)

	}

	End {}

}