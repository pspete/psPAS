Function Get-ParentFunction {
	<#
	.SYNOPSIS
	Returns the name of the calling function from a variable scope

	.DESCRIPTION
	Long description

	.PARAMETER Scope
	The Scope number from which to return the calling functions name.

	.EXAMPLE
	Function Test-Parent {Test-Child}
	Function Test-Child {Get-ParentFunction}
	Test-Parent

	Returns Test-Parent

	.EXAMPLE
	Function Test-Example {Test-Parent}
	Function Test-Parent {Test-Child}
	Function Test-Child {Get-ParentFunction -Scope 3}
	Test-Example

	Returns Test-Example

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

	(Get-Variable MyInvocation -Scope $Scope).Value.MyCommand.Name

}