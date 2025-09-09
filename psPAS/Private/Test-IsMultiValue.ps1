function Test-IsMultiValue {
    <#
    .SYNOPSIS
        Tests if the input is a multi-value collection.

    .DESCRIPTION
        This function checks if the provided input is a collection with more than one item.
        It returns $true for collections like arrays or lists with multiple items, and $false otherwise.

    .PARAMETER Input
        The input object to test.

    .EXAMPLE
        PS C:\> Test-IsMultiValue -Input @(1, 2, 3)
        True

    .EXAMPLE
        PS C:\> Test-IsMultiValue -Input "SingleValue"
        False

    .EXAMPLE
        PS C:\> Test-IsMultiValue -Input $null
        False

    .NOTES
    Author: Pete Maan
    Date: August 2025
    #>
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [object]$Value
    )

    if ($null -eq $Value) {
        return $false
    }

    # If it's an array with more than one item, it's multivalued
    if ($Value -is [System.Array] -and $Value.Count -gt 1) {
        return $true
    }

    return $false
}
