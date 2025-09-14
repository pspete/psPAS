function Compare-MaximumVersion {
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
	param(
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

	begin { }

	process {

		# Only compare if version greater than "0.0"
		if ($Version -gt '0.0') {

			#Determine if Version is less than MaximumVersion
			if ($Version -lt $MaximumVersion) {

				#Version is less than MaximumVersion
				$True

			} else {

				#Version is greater than  MaximumVersion
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