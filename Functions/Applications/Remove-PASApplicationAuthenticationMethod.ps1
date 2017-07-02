function Remove-PASApplicationAuthenticationMethod{
<#
.SYNOPSIS
Deletes an authentication method from an application

.DESCRIPTION
Deletes a specific authentication method from a defined application.
"Manage Users" permission is required.

.PARAMETER AppID
The ID of the applciation in which the authentication will be deleted.

.PARAMETER AuthID
The unique ID of the specific authentication.

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
        [ValidateNotNullOrEmpty()]
        [string]$AppID,

        [parameter(
            Mandatory=$true
        )]
        [ValidateNotNullOrEmpty()]
        [string]$AuthID,
          
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

        #request URL
        $URI = "$baseURI/PasswordVault/WebServices/PIMServices.svc/Applications/$($AppID | 
        
            Get-EscapedString)/Authentications/$($AuthID | 
            
                Get-EscapedString)"
        
        #Send Request
        Invoke-PASRestMethod -Uri $URI -Method DELETE -Headers $sessionToken -WebSession $WebSession

    }#process

    END{}#end

}