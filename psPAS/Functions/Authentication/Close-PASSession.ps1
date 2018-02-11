function Close-PASSession {
    <#
.SYNOPSIS
Logoff from CyberArk Vault.

.DESCRIPTION
Performs Logoff and removes the Vault session.

.PARAMETER sessionToken
Hashtable containing the session token returned from New-PASSession

.PARAMETER WebSession
WebRequestSession object returned from New-PASSession

.PARAMETER BaseURI
PVWA Web Address
Do not include "/PasswordVault/"

.PARAMETER PVWAAppName
The name of the CyberArk PVWA Virtual Directory.
Defaults to PasswordVault

.EXAMPLE
$token | Close-PASSession

Logs off from the session related to the authorisation token.

.INPUTS
All Parameters accept piped values by propertyname

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

    BEGIN {}#begin

    PROCESS {

        #Construct URL for request
        $URI = "$baseURI/$PVWAAppName/WebServices/auth/Cyberark/CyberArkAuthenticationService.svc/Logoff"

        #Send Logoff Request
        Invoke-PASRestMethod -Uri $URI -Method POST -Headers $sessionToken -WebSession $WebSession

    }#process

    END {}#end
}