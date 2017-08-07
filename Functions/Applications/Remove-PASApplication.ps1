function Remove-PASApplication {
    <#
.SYNOPSIS
Deletes an application

.DESCRIPTION
Deletes a specific application.
"Manage Users" permission is required to be held.

.PARAMETER AppID
The name of the application to delete.

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
$token | Remove-PASApplication -AppID NewApp

Deletes application "NewApp"

.INPUTS
All parameters can be piped by property name
Should accept pipeline objects from other *-PASApplication* functions

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
        [string]$AppID,

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

        #Request URL
        $URI = "$baseURI/$PVWAAppName/WebServices/PIMServices.svc/Applications/$($AppID |

            Get-EscapedString)/"

        #Send Request
        Invoke-PASRestMethod -Uri $URI -Method DELETE -Headers $sessionToken -WebSession $WebSession

    }#process

    END {}#end

}