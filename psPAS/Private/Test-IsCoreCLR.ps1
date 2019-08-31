Function Test-IsCoreCLR {
	<#
.SYNOPSIS
Tests for PWSH

.DESCRIPTION
Returns "$true" if run from PWSH
Returns "$false" if run from PowerShell

.EXAMPLE
Test-IsCoreCLR

Returns "$true" if run from PWSH
Returns "$false" if run from PowerShell

#>

	if ($IsCoreCLR -or $PSEdition -eq 'Core') {

		$true

	} else {

		$false

	}

}