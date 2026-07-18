function Assert-VersionRequirement {
	<#
.SYNOPSIS
Affirms that a version requirements are satisfied

.DESCRIPTION
Throws an error if a provided version number does not meet or exceed a required level.

Throws an error if an environment type does not apply for the current solution.

.PARAMETER ExternalVersion
A version number to compare against the required version

.PARAMETER RequiredVersion
The version number the ExternalVersion Number must meet.

.PARAMETER MaximumVersion
The version number the ExternalVersion Number cannot exceed.

.PARAMETER PrivilegeCloud
Specify to assert that the command is being run against a Privilege Cloud Solution

.PARAMETER SelfHosted
Specify to assert that the command is being run against a Self-Hosted solution

.EXAMPLE
Assert-VersionRequirement -ExternalVersion 1.0 -RequiredVersion 2.0

Throws an error as 1.0 does not equal or exceed 2.0

.EXAMPLE
Assert-VersionRequirement -ExternalVersion 1.0 -RequiredVersion 0.5

Returns nothing as 1.0 exceeds 0.5

.NOTES
General notes
#>
	[CmdletBinding(DefaultParameterSetName = 'CompareVersion')]
	param(
		# The Current Software Version
		[Parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'CompareVersion'
		)]
		[System.Version]
		$ExternalVersion = $psPASSession.ExternalVersion,

		# The Required Software Version
		[Parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'CompareVersion'
		)]
		[System.Version]
		$RequiredVersion,

		# The Maximum Supported Software Version
		[Parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'CompareVersion'
		)]
		[System.Version]
		$MaximumVersion,

		[Parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'PrivilegeCloud'
		)]
		[Switch]$PrivilegeCloud,

		[Parameter(
			Mandatory = $true,
			ValueFromPipelineByPropertyName = $true,
			ParameterSetName = 'SelfHosted'
		)]
		[Switch]$SelfHosted
	)

	begin {

		$ParentFunction = $((Get-ParentFunction).FunctionName)
		$UsedParameterSet = $((Get-ParentFunction).ParameterSetName)

	}

	process {

		switch ($PSBoundParameters.Keys) {

			'RequiredVersion' {

				if (-not (Compare-MinimumVersion -Version $ExternalVersion -MinimumVersion $RequiredVersion)) {

					throw "CyberArk $ExternalVersion does not meet the minimum version requirement of $RequiredVersion for $ParentFunction (using ParameterSet: $UsedParameterSet)"

				}

				continue

			}

			'MaximumVersion' {

				if (-not (Compare-MaximumVersion -Version $ExternalVersion -MaximumVersion $MaximumVersion)) {

					throw "CyberArk $ExternalVersion exceeds the maximum supported version of $MaximumVersion for $ParentFunction (using ParameterSet: $UsedParameterSet)"

				}

				continue

			}

			'PrivilegeCloud' {

				if (-not ($psPASSession.BaseUri -match 'cyberark.cloud')) {

					throw "$ParentFunction (using ParameterSet: $UsedParameterSet) is only applicable to Privilege Cloud Implementations"

				}

				continue

			}

			'SelfHosted' {

				if ($psPASSession.BaseUri -match 'cyberark.cloud') {

					throw "$ParentFunction (using ParameterSet: $UsedParameterSet) is only applicable for Self-Hosted Implementations"

				}

				continue

			}

		}

	}

	end { }

}