Function Get-PASUserPropertyObject {
    <#
    .SYNOPSIS
    Designed to flatten objects returned from Get-PASUser

    .DESCRIPTION
    Get-PASUser output contains levels of nested properties, all with unique names.

    This function returns all property values as root level properties of the output object.

    Facilitates sending existing property values as parametes for Set-PASUser

    .PARAMETER InputObject
    The input object to flatten

    .EXAMPLE
    $object = [PSCustomObject]@{

    Prop = "testvalue"
    Nest = [PSCustomObject]@{nestedproperty='nested value'}

    }

    $object | Get-PASUserPropertyObject

    Name                           Value
    ----                           -----
    nestedproperty                 nested value
    Prop                           testvalue

    Outputs a flat object where nested property values are returned as top level properties of the output object

    .NOTES
    Pete Maan 2024
    #>
    [CmdLetBinding()]
    Param (

        [Parameter(
            Mandatory = $True,
            ValueFromPipeline = $True
        )]
        [psobject]$InputObject
    )

    Begin {
        $Properties = @{}
    }
    Process {

        $InputObject.psobject.Properties | ForEach-Object {


            If ($null -ne $PSItem.value) {
                $property = $PSItem.name
                switch ($PSItem) {

                    { ($PSItem.value.gettype() | Select-Object -ExpandProperty Name) -match 'PSCustomObject' } {
                        $PSItem.value | Get-PASUserPropertyObject
                    }
                    default {
                        $Properties.Add($Property, $PSItem.value)
                    }

                }
            }



        }



    }
    End {

        $Properties.GetEnumerator()

    }
}