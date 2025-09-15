function ConvertTo-InsecureString {
	<#
	.SYNOPSIS
	Returns string value from SecureString input

	.DESCRIPTION
	Gets the decoded string value of an encoded SecureString

	.PARAMETER SecureString
	The SecureString to decode

	.EXAMPLE
	ConvertTo-InsecureString $SecureStringValue
	#>
	[CmdLetBinding()]
	[OutputType('System.String')]
	param (

		[Parameter(
			Mandatory = $True,
			ValueFromPipeline = $True
		)]
		[System.Security.SecureString]$SecureString
	)

	process {
		try {

			$ptr = [System.Runtime.InteropServices.Marshal]::SecureStringToGlobalAllocUnicode($SecureString)
			[System.Runtime.InteropServices.Marshal]::PtrToStringUni($ptr)

		}

		finally {

			[System.Runtime.InteropServices.Marshal]::ZeroFreeGlobalAllocUnicode($ptr)

		}
	}
}