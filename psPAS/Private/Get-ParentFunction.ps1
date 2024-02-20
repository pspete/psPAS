Function Get-ParentFunction {
	<#
	.SYNOPSIS
	Returns details of the calling function from a variable scope

	.DESCRIPTION
	Returns the FunctionName and the ParameterSetName which was used to invoke another function

	.PARAMETER Scope
	The Scope number from which to return the calling functions details.

	.EXAMPLE
	Function Test-Parent {Test-Child}
	Function Test-Child {Get-ParentFunction}
	$example = Test-Parent

	$example.FunctionName #Returns Test-Parent

	.EXAMPLE
	Function Test-Example {
		[CmdletBinding()]
		param([parameter(ParameterSetName = "ExampleParamSet")][string]$Name)
			Test-Parent
	}
	Function Test-Parent {Test-Child}
	Function Test-Child {Get-ParentFunction -Scope 3}
	$example = Test-Example -Name "test"

	$example.Function #Returns "Test-Example"
	$example.ParameterSetName #Returns "ExampleParamSet"

	.NOTES

	#>
	[CmdletBinding()]
	Param(
		# The scope number from which to retrieve the parent function name
		[Parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $true
		)]
		[Int]
		$Scope = 2
	)

	Process {

		#Get MyInvocation details from required scope
		$CommandData = (Get-Variable MyInvocation -Scope $Scope).Value
		[PSCustomObject]@{
			CommandData      = $CommandData
			FunctionName     = $CommandData.MyCommand.Name
			ParameterSetName = (Get-Variable PSCmdlet -Scope $Scope -ErrorAction SilentlyContinue).Value.ParameterSetName
		}

	}

}