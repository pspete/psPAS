Function Compare-MaximumVersion {
	<#
	.SYNOPSIS
	Compares 2 version numbers

	.DESCRIPTION
	Compares 2 System.Version numbers.
	Returns True if Version is less than MaximumVersion

	.PARAMETER Version
	A Version to compare against a Maximum Version

	.PARAMETER MaximumVersion
	The Minimum Version to compare against

	.EXAMPLE
	Compare-MaximumVersion -Version "9.8.0" -MaximumVersion "9.9.0"

	Returns True

	.EXAMPLE
	Compare-MaximumVersion -Version "9.8.0" -MinimumVersion "9.7.9"

	Returns False

	.NOTES

	#>
	[CmdletBinding()]
	[OutputType('System.Boolean')]
	Param(
		# A Version to compare against a Maximum Version
		[Parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[Alias('ExternalVersion')]
		[System.Version]
		$Version,

		# The Maximum Version to compare against
		[Parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[System.Version]
		$MaximumVersion
	)

	Begin { }

	Process {

		# Only compare if version greater than "0.0"
		If ($Version -gt '0.0') {

			#Determine if Version is less than MaximumVersion
			If ($Version -lt $MaximumVersion) {

				#Version is less than MaximumVersion
				$True

			} Else {

				#Version is greater than  MaximumVersion
				$False

			}

		}

		#Version is 0.0
		Else {

			#Skip - Return True
			$True

		}

	}

	End { }

}