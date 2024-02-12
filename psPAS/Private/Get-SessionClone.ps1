function Get-SessionClone {
    <#
    .SYNOPSIS
    Deep copy a hashtable

    .DESCRIPTION
    Deep copy a hashtable or ordered dictionary, and return an ordered dictionary

    .PARAMETER InputObject
    A hashtable or OrderedDictionary to clone

    .EXAMPLE
    Get-SessionClone -InputObject $Hashtable

    Returns a new ordered hashtable, which is a deep copy of $Hashtable

    .OUTPUTS
    System.Collections.Specialized.OrderedDictionary
    #>
    [cmdletbinding()]
    [OutputType('System.Collections.Specialized.OrderedDictionary')]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipeline = $true
        )]
        $InputObject
    )
    process {
        if (($InputObject -is [hashtable]) -or ($InputObject -is [System.Collections.Specialized.OrderedDictionary])) {
            $clone = [ordered]@{}
            foreach ($key in $InputObject.keys) {
                if ($null -ne $InputObject[$key]) {
                    $clone[$key] = Get-SessionClone $InputObject[$key]
                } else {
                    $clone[$key] = $null
                }
            }
            return $clone
        } else {

            return $InputObject

        }
    }
}