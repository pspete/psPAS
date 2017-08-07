function Get-PASParameters {
    <#
.SYNOPSIS
Removes defined parameter values from a passed $PSBoundParameters object

.DESCRIPTION
When passed a $PSBoundParameters hashtable, this function removes standard parameters
(like Verbose/Confirm etc) and returns the passed object with only the non-standard
parameters left in place.
This enables the returned object to be used to cretae the required JSON object to pass
to the CyberArk REST API.

.PARAMETER Parameters
This is the input object from which to remove the default set of parameters.
It is intended to accept the $PSBoundParameters object from another function.

.PARAMETER ParametersToRemove
Accepts an array of any additional parameter keys which should be removed from the passed input
object. Specifying additional parameter names/keys here means that the default value assigned
to the BaseParameters parameter will remain unchanged.

.PARAMETER BaseParameters
This is the default list of paramter names/keys which will be removed from the passed object.
Contains all standard parmaters associated with PowerShell advanced functions, as well as
additional parameter names related to the CyberArk REST API but which are never included in a
JSON object sent to the API (URL for instance).
For normal operation, there is no need to pass anything for the BaseParameters parameter.
The default value should be used.

.EXAMPLE
$PSBoundParameters | Get-PASParameters

.EXAMPLE
Get-PASParameters -Parameters $PSBoundParameters -ParametersToRemove param1,param2

.INPUTS
$PSBoundParameters object

.OUTPUTS
Hashtable/$PSBoundParameters object, with defined parameters removed.

.NOTES

.LINK

#>
    [CmdletBinding()]
    param(
        [parameter(Position = 0,
            Mandatory = $true,
            ValueFromPipeline = $true
        )]
        [ValidateNotNullOrEmpty()]
        [Hashtable]$Parameters,
        [parameter(Mandatory = $false)]
        [array]$ParametersToRemove = @(),
        [parameter(Mandatory = $false)]
        [array]$BaseParameters = @("Debug",
            "ErrorAction",
            "ErrorVariable",
            "OutVariable",
            "OutBuffer",
            "PipelineVariable",
            "Verbose",
            "WarningAction",
            "WarningVariable",
            "WhatIf",
            "Confirm",
            "sessionToken",
            "BaseURI"
            "AccountID",
            "SessionVariable",
            "WebSession",
            "PVWAAppName")
    )

    BEGIN {

        Write-Debug "Function: $($MyInvocation.InvocationName)"

    }#begin

    PROCESS {

        #Combine base parameters and any additional parameters to remove
        ($BaseParameters + $ParametersToRemove) |

        ForEach-Object {

            Write-Debug "Removing Parameter: $_"
            #remove specified parameters from passed values
            $Parameters.Remove($_)

        }

    }#process

    END {

        #Return Object
        $Parameters

    }#end
}