function ConvertFrom-Base64UrlString {
	<#
	.SYNOPSIS
	Converts a Base64Url-encoded string to bytes

	.DESCRIPTION
	Converts a Base64Url-encoded string (URL-safe Base64 without padding) to a byte array.
	This format is used in FIDO2/WebAuthn specifications.

	.PARAMETER InputString
	The Base64Url-encoded string to convert

	.EXAMPLE
	ConvertFrom-Base64UrlString -InputString 'SGVsbG8gV29ybGQ'

	Converts the Base64Url string to bytes

	.NOTES
	Base64Url encoding uses - and _ instead of + and / and removes padding (=)
	#>
	[CmdletBinding()]
	[OutputType([byte[]])]
	param(
		[Parameter(
			Mandatory = $true,
			ValueFromPipeline = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$InputString
	)

	process {
		# Convert Base64Url to standard Base64
		$base64 = $InputString.Replace('-', '+').Replace('_', '/')
		
		# Add padding if necessary
		$padding = 4 - ($base64.Length % 4)
		if ($padding -ne 4) {
			$base64 += '=' * $padding
		}
		
		# Convert to bytes
		[System.Convert]::FromBase64String($base64)
	}
}
