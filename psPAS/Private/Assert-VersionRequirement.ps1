Function Assert-VersionRequirement {
	<#
.SYNOPSIS
Affirms that a version satisfies a required level

.DESCRIPTION
Throws an error if a provided version number odes not meet or exceed a required level.

.PARAMETER ExternalVersion
A version number to comapre against the required version

.PARAMETER RequiredVersion
The version number the ExternalVersion Number must meet.

.PARAMETER MaximumVersion
The version number the ExternalVersion Number cannot exceed.

.EXAMPLE
Assert-VersionRequirement -ExternalVersion 1.0 -RequiredVersion 2.0

Throws an error as 1.0 does not equal or exceed 2.0

.EXAMPLE
Assert-VersionRequirement -ExternalVersion 1.0 -RequiredVersion 0.5

Returns nothing as 1.0 exceeds 0.5

.NOTES
General notes
#>
	[CmdletBinding()]
	Param(
		# The Current Software Version
		[Parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[System.Version]
		$ExternalVersion = $Script:ExternalVersion,

		# The Required Software Version
		[Parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[System.Version]
		$RequiredVersion,

		# The Maximum Supported Software Version
		[Parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[System.Version]
		$MaximumVersion
	)

	Begin {

		$ParentFunction = $((Get-ParentFunction).FunctionName)
		$UsedParameterSet = $((Get-ParentFunction).ParameterSetName)

	}

	Process {

		switch ($PSBoundParameters.Keys) {

			'RequiredVersion' {

				If (-not (Compare-MinimumVersion -Version $ExternalVersion -MinimumVersion $RequiredVersion)) {

					Throw "CyberArk $ExternalVersion does not meet the minimum version requirement of $RequiredVersion for $ParentFunction (using ParameterSet: $UsedParameterSet)"

				}

				Continue

			}
		
			'MaximumVersion' {

				If (-not (Compare-MaximumVersion -Version $ExternalVersion -MaximumVersion $MaximumVersion)) {

					Throw "CyberArk $ExternalVersion exceeds the maximum supported version of $MaximumVersion for $ParentFunction (using ParameterSet: $UsedParameterSet)"

				}

				Continue

			}

		}

	}

	End { }

}