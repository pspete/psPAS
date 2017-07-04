﻿function Get-PASServer{
<#
.SYNOPSIS
Returns details of the Web Sevice Server

.DESCRIPTION
Returns information on Server.
Returns the name of the Vault configured in the ServerDisplayName configuration parameter
Appears to need Vault administrator rights

.PARAMETER sessionToken
Hashtable containing the session token returned from New-PASSession

.PARAMETER WebSession
WebRequestSession object returned from New-PASSession

.PARAMETER BaseURI
PVWA Web Address
Do not include "/PasswordVault/"

.EXAMPLE

.INPUTS
WebSession & BaseURI can be piped to the function by propertyname

.OUTPUTS
Webservice Server Details
ServerName, ExternalVersion, InternalVersion

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
        $URI = "$baseURI/PasswordVault/WebServices/PIMServices.svc/Server"

        #send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET -Headers $sessionToken -WebSession $WebSession

    }#process

    END{$result}#end
}