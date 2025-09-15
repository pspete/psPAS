function Compare-MinimumVersion {
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
	param(
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

	begin { }

	process {

		# Only compare if version greater than "0.0"
		if ($Version -gt '0.0') {

			#Determine if Version is greater than or equal to MinimumVersion
			if ($Version -ge $MinimumVersion) {

				#Version is greater than or equal to MinimumVersion
				$True

			} else {

				#Version is less than  MinimumVersion
				$False

			}

		}

		#Version is 0.0
		else {

			#Skip - Return True
			$True

		}

	}

	end { }

}