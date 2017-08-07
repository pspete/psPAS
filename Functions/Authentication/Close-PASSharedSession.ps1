function Close-PASSharedSession {
    <#
.SYNOPSIS
Logoff from CyberArk Vault shared user.

.DESCRIPTION
Performs Logoff and removes the Vault session.

.PARAMETER sessionToken
Hashtable containing the session token returned from New-PASSharedSession

.PARAMETER WebSession
WebRequestSession object returned from New-PASSession

.PARAMETER BaseURI
A string containing the base web address to send te request to.
Pass the portion the PVWA HTTP address.
Do not include "/PasswordVault/"

.PARAMETER PVWAAppName
The name of the CyberArk PVWA Virtual Directory.
Defaults to PasswordVault

.EXAMPLE
$token | Close-PASSharedSession

Logs off from the session related to the authorisation token.

.INPUTS
Valid CyberArk Authentication session token
WebSession object
URL string
can all be piped in by property name

.OUTPUTS
None

.NOTES

.LINK
#>
    [CmdletBinding()]
    param(
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

    BEGIN {

    }#begin

    PROCESS {

        #Construct URL for request
        $URI = "$baseURI/$PVWAAppName/WebServices/auth/Shared/RestfulAuthenticationService.svc/Logoff"

        #Send Logon Request
        Invoke-PASRestMethod -Uri $URI -Method POST -Header $sessionToken -WebSession $WebSession

    }#process

    END {}#end
}