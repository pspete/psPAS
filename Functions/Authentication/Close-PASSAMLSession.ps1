function Close-PASSAMLSession {
    <#
.SYNOPSIS
Logoff from CyberArk Vault SAML Session.

.DESCRIPTION
Performs Vault Logoff from SAML session and removes the Vault session.

.PARAMETER sessionToken
Hashtable containing the session token returned from New-PASSAMLSession

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
$token | Close-PASSAMLSession

Logs off from the SAML session related to the authorisation token

.INPUTS

.OUTPUTS

.NOTES
Not Tested nor confirmed as working.
New-PASSAMLSession function needs to be fixed first.

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
        $URI = "$baseURI/$PVWAAppName/WebServices/auth/SAML/SAMLAuthenticationService.svc/Logoff"

        $Body = @{} | ConvertTo-Json

        #Send Logon Request
        Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -Header $sessionToken -WebSession $WebSession

    }#process

    END {}#end
}