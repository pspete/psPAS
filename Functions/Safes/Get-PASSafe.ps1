function Get-PASSafe{
<#
.SYNOPSIS
Returns safe details from the vault.

.DESCRIPTION
Gets safe by SafeName, by search query string, or return all safes.

.PARAMETER SafeName
The name of a specific safe to get details of.

.PARAMETER query
Query String for safe search in the vault

.PARAMETER FindAll
Specify to find all safes

.PARAMETER sessionToken
Hashtable containing the session token returned from New-PASSession

.PARAMETER WebSession
WebRequestSession object returned from New-PASSession

.PARAMETER BaseURI
PVWA Web Address
Do not include "/PasswordVault/"

.EXAMPLE

.INPUTS
SessionToken, WebSession & BaseURI can be piped to the function by propertyname

.OUTPUTS
PSObject containing safe properties

.NOTES

.LINK

#>
    [CmdletBinding()]  
    param(
        [parameter(
            Mandatory=$false,
            ParameterSetName="byName"
        )]
        [ValidateNotNullOrEmpty()]
        [string]$SafeName,

        [parameter(
            Mandatory=$false,
            ParameterSetName="byQuery"
        )]
        [string]$query,

        [parameter(
            Mandatory=$false,
            ParameterSetName="byAll"
        )]
        [switch]$FindAll,

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

        #Create base URL for request
        $URI = "$baseURI/PasswordVault/WebServices/PIMServices.svc/Safes"

        #If SafeName specified
        If($($PSCmdlet.ParameterSetName) -eq "byName"){
            
            $returnProperty = "GetSafeResult"

            #Build URL from base URL
            $URI = "$URI/$($SafeName | Get-EscapedString)"
        
        }

        #If search query specified
        ElseIf($($PSCmdlet.ParameterSetName) -eq "byQuery"){
            
            $returnProperty = "SearchSafesResult"

            #Get Parameters to include in request
            $boundParameters = $PSBoundParameters | Get-PASParameters

            #Create Query String, escaped for inclusion in request URL
            $queryString = ($boundParameters.keys | foreach{
        
                "$_=$($boundParameters[$_] | Get-EscapedString)"
            
            }) -join '&'
        
            #Build URL from base URL
            $URI = "$URI`?$queryString"
        
        }

        ElseIf($($PSCmdlet.ParameterSetName) -eq "byAll"){
        
            $returnProperty = "GetSafesResult"
        
        }
        
        #send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET -Headers $sessionToken -WebSession $WebSession

    }#process

    END{$result.$returnProperty}#end
}