Function Get-PASPropertyObject {
    <#
    .SYNOPSIS
    Designed to flatten objects returned from psPAS commands

    .DESCRIPTION
    psPAS output can contain multiple levels of nested properties.

    This function returns all property values as root level properties of the output object.

    Facilitates sending existing property values as parametes for Set-PAS* commands.

    .PARAMETER InputObject
    The input object to flatten

    .EXAMPLE
    $object = [PSCustomObject]@{

    Prop = "testvalue"
    Nest = [PSCustomObject]@{nestedproperty='nested value'}

    }

    $object | Get-PASPropertyObject

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

        #Iterate each property
        $InputObject.psobject.Properties | ForEach-Object {

            If ($null -ne $PSItem.value) {

                #save the property name
                $property = $PSItem.name

                switch ($PSItem) {

                    #where property value is another (nested) object, recursivley call the function for the object
                    { ($PSItem.value.gettype() | Select-Object -ExpandProperty Name) -match 'PSCustomObject' } {
                        $PSItem.value | Get-PASPropertyObject
                    }
                    default {
                        #add property name/value to hastable
                        $Properties.Add($Property, $PSItem.value)
                    }

                }
            }

        }

    }
    End {

        #output hashtable elements
        $Properties.GetEnumerator()

    }
}