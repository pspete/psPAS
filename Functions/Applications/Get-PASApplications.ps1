function Get-PASApplications{
<#
.SYNOPSIS
Returns list of all applications in Vault

.DESCRIPTION
Gets the List of all Application from the Vault.
Results can be filtered by specifying additioanl parameters
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

.EXAMPLE

.INPUTS
SessionToken, WebSession, BaseURI can be piped by property name

.OUTPUTS
Application details

.NOTES

.LINK

#>
    [CmdletBinding()]  
    param(
        [parameter(
            Mandatory=$false
        )]
        [ValidateNotNullOrEmpty()]
        [string]$AppID,

        [parameter(
            Mandatory=$false
        )]
        [ValidateNotNullOrEmpty()]
        [string]$Location,

        [parameter(
            Mandatory=$false
        )]
        [boolean]$IncludeSublocations,
        
        [parameter(
            Mandatory=$true,
            ValueFromPipelinebyPropertyName=$true
        )]
        [ValidateNotNullOrEmpty()]
        [hashtable]$sessionToken,

        [parameter(
            ValueFromPipelinebyPropertyName=$true
        )]
        [Microsoft.PowerShell.Commands.WebRequestSession]$WebSession,

        [parameter(
            Mandatory=$true,
            ValueFromPipelinebyPropertyName=$true
        )]
        [string]$BaseURI
    )

    BEGIN{}#begin

    PROCESS{

        #Get parameters for request string
        $boundParameters = $PSBoundParameters | Get-PASParameters
        
        #Create query string
        $query = ($boundParameters.keys | foreach{
        
            "$_=$($boundParameters[$_] | Get-EscapedString)"
            
        }) -join '&'

        #Create URL for request
        $URI = "$baseURI/PasswordVault/WebServices/PIMServices.svc/Applications?$query"

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET -Headers $sessionToken -WebSession $WebSession

        

    }#process

    END{
    
        #Return results
        $result.application
        
    }#end

}