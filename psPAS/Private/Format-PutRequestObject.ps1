Function Format-PutRequestObject {
    <#
    .SYNOPSIS
    Give source object properties, and request parameters,
    where a property is not present in a request, adds the current value from the source object.

    .DESCRIPTION
    Updates a source object with additional properties from another object.

    .PARAMETER InputObject
    The object representing current property values of an object to be updated

    .PARAMETER boundParameters
    The current request paramters for the update operation

    .PARAMETER ParametersToRemove
    Any parameter names from the input object which should not be included in the update request

    .PARAMETER ParametersToKeep
    Any parameter names from the input object which should be kept for the update request

    .EXAMPLE
    Format-PutRequestObject -InputObject $UserObject -boundParameters $BoundParameters -ParametersToRemove id

    updates the boundparameter value with key/values not already included, but present in InputObject

    .NOTES
    Pete Maan 2024
    #>
    [CmdLetBinding(DefaultParameterSetName = 'Remove')]
    Param (

        [Parameter(
            Mandatory = $True,
            ValueFromPipelineByPropertyName = $True
        )]
        [psobject]$InputObject,

        [Parameter(
            Mandatory = $True,
            ValueFromPipelineByPropertyName = $True
        )]$boundParameters,

        [parameter(
            Mandatory = $false,
            ValueFromPipelineByPropertyName = $True,
            ParameterSetName = 'Remove'
        )]
        [string[]]$ParametersToRemove,

        [parameter(
            Mandatory = $false,
            ValueFromPipelineByPropertyName = $True,
            ParameterSetName = 'Keep'
        )]
        [string[]]$ParametersToKeep

    )

    Begin {
        #initialise hashtable to hold exiting property values
        $ExistingProperties = @{}
    }

    Process {

        #ParametersToKeep or ParametersToRemove paramters to pass to Get-PASParameter
        $PasParameters = $PSBoundParameters | Get-PASParameter -ParametersToKeep ParametersToKeep, ParametersToRemove

        #Add properties of inputobject to ExistingProperties hashtable
        $InputObject | Get-PASPropertyObject | ForEach-Object {
            $ExistingProperties[$($PSItem.Key)] = $($PSItem.Value)
        }

        #Keep or remove any specified specific properties from the Input Object
        #* Not all property values from an object can be sent in a PUT request
        #* Keep or remove properties based on the input requirements for the PUT request.
        $ExistingParameters = $ExistingProperties | Get-PASParameter @PasParameters

        #If boundparameters does not include the existing propertyname, i.e. the property is not being udpated in the request:
        # Add the existing property to boundparameters for inclusion in a PUT request
        $ExistingParameters.Keys | ForEach-Object {
            If (-not($boundParameters.ContainsKey($PSItem))) {
                $boundParameters.Add($PSItem, $ExistingParameters[$PSItem])
            }
        }


    }

    End { }

}