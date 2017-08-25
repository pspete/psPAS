function Get-PASApplications {
    <#
.SYNOPSIS
Returns list of all applications in Vault

.DESCRIPTION
Gets the List of all Application from the Vault.
Results can be filtered by specifying additional parameters
Audit Users permission is required.

.PARAMETER AppID
Application Name

.PARAMETER Location
Location of the application in the Vault hierarchy.
Default=\

.PARAMETER IncludeSubLocations
Will search be carried out in sublocations of specified location?
Boolean

.PARAMETER sessionToken
Hashtable containing the session token returned from New-PASSession

.PARAMETER WebSession
WebRequestSession object returned from New-PASSession

.PARAMETER BaseURI
PVWA Web Address
Do not include "/PasswordVault/"

.PARAMETER PVWAAppName
The name of the CyberArk PVWA Virtual Directory.
Defaults to PasswordVault

.EXAMPLE
$token | Get-PASApplications

Returns information on all defined applications

.INPUTS
All parameters can be piped by property name
Should accept pipeline objects from other *-PASApplication* functions

.OUTPUTS
Outputs Object of Custom Type psPAS.CyberArk.Vault.Application
SessionToken, WebSession, BaseURI are passed through and
contained in output object for inclusion in subsequent
pipeline operations.

Output format is defined via psPAS.Format.ps1xml.
To force all output to be shown, pipe to Select-Object *

.NOTES

.LINK

#>
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [string]$AppID,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [string]$Location,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [boolean]$IncludeSublocations,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [hashtable]$sessionToken,

        [parameter(
            ValueFromPipelinebyPropertyName = $true
        )]
        [Microsoft.PowerShell.Commands.WebRequestSession]$WebSession,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$BaseURI,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$PVWAAppName = "PasswordVault"
    )

    BEGIN {}#begin

    PROCESS {

        #Get parameters for request string
        $boundParameters = $PSBoundParameters | Get-PASParameters

        #Create query string
        $query = ($boundParameters.keys | ForEach-Object {

                "$_=$($boundParameters[$_] | Get-EscapedString)"

            }) -join '&'

        #Create URL for request
        $URI = "$baseURI/$PVWAAppName/WebServices/PIMServices.svc/Applications?$query"

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET -Headers $sessionToken -WebSession $WebSession



    }#process

    END {

        if($result) {

            #Return results
            $result.application | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Application -PropertyToAdd @{

                "sessionToken" = $sessionToken
                "WebSession"   = $WebSession
                "BaseURI"      = $BaseURI
                "PVWAAppName"  = $PVWAAppName

            }

        }

    }#end

}