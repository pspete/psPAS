Function Get-ByteArray {
	<#
.SYNOPSIS
Get a file as a ByteArray

.DESCRIPTION
Outputs a file to a ByteArray

.PARAMETER Path
The File to Read as a ByteArray

.EXAMPLE
Get-ByteArray -Path "C:\SomeFile.zip"

#>
	[CmdletBinding()]
	[OutputType('System.Byte[]')]
	Param(
		# The File to Convert to a ByteArray
		[Parameter(
			Mandatory = $true,
			ValueFromPipeline = $true
		)]
		[ValidateNotNullOrEmpty()]
		[ValidateScript( { Test-Path -Path $_ -PathType Leaf })]
		[String]
		$Path
	)

	Begin {}

	Process {
		[System.IO.File]::ReadAllBytes($Path)
	}

	End {}

}