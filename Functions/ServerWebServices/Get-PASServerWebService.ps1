function Get-PASServerWebService {
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

.PARAMETER PVWAAppName
The name of the CyberArk PVWA Virtual Directory.
Defaults to PasswordVault

.EXAMPLE
$token | Get-PASServerWebService

Displays CyberArk Web Service Information

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
            Mandatory = $false,
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

        #Create URL for request
        $URI = "$baseURI/$PVWAAppName/WebServices/PIMServices.svc/Verify"

        #send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $WebSession

    }#process

    END {

        if($result) {

            #return results
            $result | Select-Object ServerName, ServerId, ApplicationName , AuthenticationMethods

        }

    }#end
}