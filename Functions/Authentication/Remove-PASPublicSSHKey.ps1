function Remove-PASPublicSSHKey {
    <#
.SYNOPSIS
Deletes a specific Public SSH Key from a specific vault user.

.DESCRIPTION
Deletes an authorized public SSH key for a specific user in the
Vault, preventing them from authenticating to the Vault through PSMP
using a corresponding private SSH key.
"Reset Users Passwords" Vault permission is required.
The authenticated user who runs this function must be in the same Vault
Location or higher as the user whose public SSH keys are deleted.
A user cannot manage their own public SSH keys.

.PARAMETER UserName
The username of the Vault user whose public SSH keys will be added
A username cannot contain te follwing characters: "%", "&", "+" or ".".

.PARAMETER KeyID
The ID of the public SSH key to delete.

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
$token | Remove-PASPublicSSHKey -UserName Splitter -KeyID 415161FE8F2B408BB76BC244258C3697

Deletes specified ssh key from vault user "Splitter"

.INPUTS
All parameter values can be passed via the pipeline by property name.

.OUTPUTS
TODO

.NOTES

.LINK
#>
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateScript( {$_ -notmatch ".*(%|\&|\+|\.).*"})]
        [string]$UserName,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$KeyID,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [hashtable]$SessionToken,

        [parameter(ValueFromPipelinebyPropertyName = $true)]
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

        #Create URL string for request
        $URI = "$baseURI/$PVWAAppName/WebServices/PIMServices.svc/Users/$($UserName |

            Get-EscapedString)/AuthenticationMethods/SSHKeyAuthentication/AuthorizedKeys/$KeyID"

        #Send Request to web service
        Invoke-PASRestMethod -Uri $URI -Method DELETE -Headers $SessionToken -WebSession $WebSession

    }#process

    END {}#end
}