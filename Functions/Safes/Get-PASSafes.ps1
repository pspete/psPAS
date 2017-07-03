function Get-PASSafes{
<#
.SYNOPSIS
Returns all Safes

.DESCRIPTION
Gets information on all safes for the authenitcated user.

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
        
        #Create URL for Request
        $URI = "$baseURI/PasswordVault/WebServices/PIMServices.svc/Safes"
        
        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET -Headers $sessionToken -WebSession $WebSession

    }#process

    END{
    
        #return result
        $result
    
    }#end
}