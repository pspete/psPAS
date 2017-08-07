function Remove-PASAccountACL {
    <#
.SYNOPSIS
Deletes privileged commands rule from an account

.DESCRIPTION
Deletes privileged commands rule associated with account

.PARAMETER AccountPolicyID
ID of account from which the commands will be deleted

.PARAMETER Id
The ID of the command that will be deleted

.PARAMETER sessionToken
Hashtable containing the session token returned from New-PASSession

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
$token | Remove-PASAccountACL -AccountPolicyId UNIXSSH -AccountAddress machine -AccountUserName root -Id 12

Removes matching Privileged Account Rule from the account root

.EXAMPLE
$token | Get-PASAccount root | Get-PASAccountACL | Where-Object{$_.Command -eq "ifconfig"} | Remove-PASAccountACL

Removes matching Privileged Account Rule from account.

.INPUTS
All parameters can be piped by property name
Should accept pipeline objects from Get-PASAccountACL function

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
        [Alias("PolicyID")]
        [ValidateNotNullOrEmpty()]
        [string]$AccountPolicyId,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [string]$AccountAddress,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [string]$AccountUserName,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$Id,

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

        #URL for request
        $URI = "$baseURI/$PVWAAppName/WebServices/PIMServices.svc/Account/$($AccountAddress |

            Get-EscapedString)|$($AccountUserName |

                Get-EscapedString)|$($AccountPolicyId |

                    Get-EscapedString)/PrivilegedCommands/$Id"

        #Request Body
        $Body = @{}

        #Send Request to Web Service
        Invoke-PASRestMethod -Uri $URI -Method DELETE -Body $Body -Headers $sessionToken -WebSession $WebSession

    }#process

    END {}#end

}