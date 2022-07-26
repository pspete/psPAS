function Get-PASParameter {
	<#
.SYNOPSIS
Removes defined parameter values from a passed $PSBoundParameters object

.DESCRIPTION
When passed a $PSBoundParameters hashtable, this function removes standard parameters
(like Verbose/Confirm etc) and returns the passed object with only the non-standard
parameters left in place.
This enables the returned object to be used to create the required JSON object to pass
to the CyberArk REST API.

.PARAMETER Parameters
This is the input object from which to remove the default set of parameters.
It is intended to accept the $PSBoundParameters object from another function.

.PARAMETER ParametersToRemove
Accepts an array of any additional parameter keys which should be removed from the passed input
object. Specifying additional parameter names/keys here means that the default value assigned
to the BaseParameters parameter will remain unchanged.

.EXAMPLE
$PSBoundParameters | Get-PASParameter

.EXAMPLE
Get-PASParameter -Parameters $PSBoundParameters -ParametersToRemove param1,param2

.INPUTS
$PSBoundParameters object

.OUTPUTS
Hashtable/$PSBoundParameters object, with defined parameters removed.
#>
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', 'FilteredParameters', Justification = 'False Positive')]
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', 'ParametersToKeep', Justification = 'False Positive')]
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', 'ParametersToRemove', Justification = 'False Positive')]
	[CmdletBinding(DefaultParameterSetName = 'Remove')]
	[OutputType('System.Collections.Hashtable')]
	param(
		[parameter(
			Position = 0,
			Mandatory = $true,
			ValueFromPipeline = $true)]
		[Hashtable]$Parameters,

		[parameter(
			Mandatory = $false,
			ParameterSetName = 'Remove'
		)]
		[array]$ParametersToRemove = @(),

		[parameter(
			Mandatory = $false,
			ParameterSetName = 'Keep'
		)]
		[array]$ParametersToKeep = @()

	)

	BEGIN {

		$BaseParameters = [Collections.Generic.List[String]]@(
			[System.Management.Automation.PSCmdlet]::CommonParameters +
			[System.Management.Automation.PSCmdlet]::OptionalCommonParameters +
			'SessionVariable' +
			'UseClassicAPI' +
			'UseGen1API' +
			'TimeoutSec'
		)

	}#begin

	PROCESS {

		$Parameters.Keys | ForEach-Object {

			$FilteredParameters = @{ }

		} {

			if ($PSCmdlet.ParameterSetName -eq 'Keep') {

				if ($ParametersToKeep -contains $PSItem) {

					$FilteredParameters.Add($PSItem, $Parameters[$PSItem])

				}

			}

			Else {

				if (($BaseParameters + $ParametersToRemove) -notcontains $PSItem) {

					$FilteredParameters.Add($PSItem, $Parameters[$PSItem])

				}
			}

		} { $FilteredParameters }

	}#process

	END { }#end

}