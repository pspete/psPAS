function Get-PASAccountACL {
    <#
.SYNOPSIS
Lists privileged commands rule for an account

.DESCRIPTION
Gets list of all privileged commands associated with an account

.PARAMETER AccountPolicyId
The PolicyID associated with account.

.PARAMETER AccountAddress
The address of the account whose privileged commands will be listed.

.PARAMETER AccountUserName
The name of the account’s user.

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
$token | Get-PASAccount root | Get-PASAccountACL

Returns Privileged Account Rules for the account root found by Get-PASAccount:

PolicyId Command                       PermissionType UserName Type    IsGroup
-------- -------                       -------------- -------- ----    -------
UNIXSSH  ifconfig                      Allow          TestUser Account False
UNIXSSH  for /l %a in (0,0,0) do start Deny           TestUser Account False
UNIXSSH  for /l %a in (0,0,0) do xyz   Allow          TestUser Account False

.INPUTS
All parameters can be piped by property name
Should accept pipeline objects from other *-PASAccount functions

.OUTPUTS
Outputs Object of Custom Type psPAS.CyberArk.Vault.ACL
SessionToken, WebSession, BaseURI are passed through and
contained in output object for inclusion in subsequent
pipeline operations.
Output format is defined via psPAS.Format.ps1xml.
To force all output to be shown, pipe to Select-Object *

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
        [string]$AccountPolicyId,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [Alias("Address")]
        [ValidateNotNullOrEmpty()]
        [string]$AccountAddress,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [Alias("UserName")]
        [ValidateNotNullOrEmpty()]
        [string]$AccountUserName,

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

        #Create URL for request
        $URI = "$baseURI/$PVWAAppName/WebServices/PIMServices.svc/Account/$($AccountAddress |

            Get-EscapedString)|$($AccountUserName |

                Get-EscapedString)|$($AccountPolicyId |

                    Get-EscapedString)/PrivilegedCommands"

        #Send request to Web Service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET -Headers $sessionToken -WebSession $WebSession #DevSkim: ignore DS104456

    }#process

    END {

        if($result) {

            $result.ListAccountPrivilegedCommandsResult |

            Add-ObjectDetail -typename psPAS.CyberArk.Vault.ACL -PropertyToAdd @{

                "sessionToken" = $sessionToken
                "WebSession"   = $WebSession
                "BaseURI"      = $BaseURI
                "PVWAAppName"  = $PVWAAppName

            }

        }

    }#end

}