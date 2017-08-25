function Remove-PASApplicationAuthenticationMethod {
    <#
.SYNOPSIS
Deletes an authentication method from an application

.DESCRIPTION
Deletes a specific authentication method from a defined application.
"Manage Users" permission is required.

.PARAMETER AppID
The ID of the application in which the authentication will be deleted.

.PARAMETER AuthID
The unique ID of the specific authentication.

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
$token | Remove-PASApplicationAuthenticationMethod -AppID NewApp -AuthID 1

Deletes authentication method with ID of 1 from "NewApp"

.EXAMPLE
$token | Get-PASApplicationAuthenticationMethods -AppID NewApp | Remove-PASApplicationAuthenticationMethod

Deletes all authentication methods from "NewApp"

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
        [string]$AuthID,

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

        #request URL
        $URI = "$baseURI/$PVWAAppName/WebServices/PIMServices.svc/Applications/$($AppID |

            Get-EscapedString)/Authentications/$($AuthID |

                Get-EscapedString)"

        #Send Request
        Invoke-PASRestMethod -Uri $URI -Method DELETE -Headers $sessionToken -WebSession $WebSession

    }#process

    END {}#end

}