function Search-PASSafes{
<#
.SYNOPSIS
Returns all Safes

.DESCRIPTION
Gets information on all safes for the authenitcated user.

.PARAMETER Keywords
Keywords to search for. 

.PARAMETER sessionToken
Hashtable containing the session token returned from New-PASSession

.PARAMETER WebSession
WebRequestSession object returned from New-PASSession

.PARAMETER BaseURI
PVWA Web Address
Do not include "/PasswordVault/"

.EXAMPLE

.INPUTS
SessionToken, SafeName, WebSession & BaseURI 
can be piped to the function by propertyname

.OUTPUTS
List of safes and properties.

.NOTES

.LINK
#>
    [CmdletBinding()]  
    param(
        [parameter(
            Mandatory=$true
        )]
        [string]$Keywords,

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
        
        #Get Parameters to include in request
        $boundParameters = $PSBoundParameters | Get-PASParameters

        #Create Query String, escaped for inclusion in request URL
        $query = ($boundParameters.keys | foreach{
        
            "$_=$($boundParameters[$_] | Get-EscapedString)"
            
        }) -join '&'

        #Create URL for Request
        $URI = "$baseURI/PasswordVault/WebServices/PIMServices.svc/Safes?query=$query"
        
        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET -Headers $sessionToken -WebSession $WebSession

    }#process

    END{
    
        #return result
        $result.GetSafesResult
    
    }#end
}