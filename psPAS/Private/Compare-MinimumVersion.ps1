Function Compare-MinimumVersion {
	<#
	.SYNOPSIS
	Compares 2 version numbers

	.DESCRIPTION
	Compares 2 System.Version numbers.
	Returns True if Version is greater than or equal to MinimumVersion

	.PARAMETER Version
	A Version to compare against a Minimum Version

	.PARAMETER MinimumVersion
	The Minimum Version to compare against

	.EXAMPLE
	Compare-MinimumVersion -Version "9.8.0" -MinimumVersion "8.9.0"

	Returns True

	.EXAMPLE
	Compare-MinimumVersion -Version "9.8.0" -MinimumVersion "9.9.0"

	Returns False

	.NOTES

	#>
	[CmdletBinding()]
	[OutputType('System.Boolean')]
	Param(
		# A Version to compare against a Minimum Version
		[Parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[Alias('ExternalVersion')]
		[System.Version]
		$Version,

		# The Minimum Version to compare against
		[Parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true
		)]
		[System.Version]
		$MinimumVersion
	)

	Begin { }

	Process {

		# Only compare if version greater than "0.0"
		If ($Version -gt '0.0') {

			#Determine if Version is greater than or equal to MinimumVersion
			If ($Version -ge $MinimumVersion) {

				#Version is greater than or equal to MinimumVersion
				$True

			} Else {

				#Version is less than  MinimumVersion
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