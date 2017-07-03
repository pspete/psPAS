function Get-PASServerWebService{
<#
.SYNOPSIS
Returns details of the Web Service

.DESCRIPTION
Returns information on Server web service.
Returns the name of the Vault configured in the ServerDisplayName configuration parameter

.PARAMETER WebSession
WebRequestSession object returned from New-PASSession

.PARAMETER BaseURI
PVWA Web Address
Do not include "/PasswordVault/"

.EXAMPLE

.INPUTS
WebSession & BaseURI can be piped to the function by propertyname

.OUTPUTS
Webservice Details
ServerName, ServerID, ApplicationName & Available Authentication Methods

.NOTES

.LINK

#>
    [CmdletBinding()]  
    param(
        [parameter(
            Mandatory=$false,
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

        #Create URL for request
        $URI = "$baseURI/PasswordVault/WebServices/PIMServices.svc/Verify"

        #send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $WebSession

    }#process

    END{$result}#end
}