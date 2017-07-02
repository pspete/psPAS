function Get-PASApplicationAuthenticationMethods{
<#
.SYNOPSIS
Returns information about all of the authentication methods of a specific application.

.DESCRIPTION
Returns information about all of the authentication methods of a specific application.
The user authenticated to the vault running the command must have the "Audit Users" permission.

.PARAMETER AppID
The name of the application for which infomration about authentication methods will be returned.

.PARAMETER sessionToken
Hashtable containing the session token returned from New-PASSession

.PARAMETER WebSession
WebRequestSession object returned from New-PASSession

.PARAMETER BaseURI
PVWA Web Address
Do not include "/PasswordVault/"

.EXAMPLE

.INPUTS

.OUTPUTS

.NOTES

.LINK

#>
    [CmdletBinding()]  
    param(
        [parameter(
            Mandatory=$true
        )]
        [string]$AppID,
          
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

        $URI = "$baseURI/PasswordVault/WebServices/PIMServices.svc/Applications/$($AppID | 
        
            Get-EscapedString)/Authentications"
        
        $result = Invoke-PASRestMethod -Uri $URI -Method GET -Headers $sessionToken -WebSession $WebSession

    }#process

    END{$result.authentication}#end

}