function Add-PASAccountACL {
    <#
.SYNOPSIS
Adds a new privileged command rule to an account.

.DESCRIPTION
Adds a new privileged command rule to an account.

.PARAMETER AccountPolicyId
The PolicyID associated with account.

.PARAMETER AccountAddress
The address of the account whose privileged commands will be listed.

.PARAMETER AccountUserName
The name of the account’s user.

.PARAMETER Command
The Command

.PARAMETER CommandGroup
Boolean for Command Group

.PARAMETER PermissionType
Allow or Deny permission

.PARAMETER Restrictions
A restriction string

.PARAMETER UserName
The user this rule applies to

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
$token | Add-PASAccountACL -AccountPolicyID UNIXSSH -AccountAddress ServerA.domain.com -AccountUserName root `
        -Command 'for /l %a in (0,0,0) do xyz' -CommandGroup $false -PermissionType Deny -UserName TestUser

This will add a new Privileged Command Rule to root for user TestUser

.INPUTS
AccountPolicyId, AccountAddress, SessionToken, WebSession &
BaseURI can be piped by property name.
Results of GET-PASAccount can be piped into this function, but
username/accountname values must be explicitly specified due to
ambiguities in the propertynames.

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
        [Alias("PlatformID")]
        [ValidateNotNullOrEmpty()]
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
            ValueFromPipelinebyPropertyName = $false
        )]
        [ValidateNotNullOrEmpty()]
        [string]$AccountUserName,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $false
        )]
        [ValidateNotNullOrEmpty()]
        [string]$Command,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $false
        )]
        [boolean]$CommandGroup,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $false
        )]
        [ValidateSet("Allow", "Deny")]
        [string]$PermissionType,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $false
        )]
        [ValidateNotNullOrEmpty()]
        [string]$Restrictions,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $false
        )]
        [ValidateNotNullOrEmpty()]
        [string]$UserName,

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

                    Get-EscapedString)/PrivilegedCommands"

        #Request body
        $Body = $PSBoundParameters |

        Get-PASParameters -ParametersToRemove AccountAddress, AccountUserName, AccountPolicyID |

        ConvertTo-Json

        #Send Request
        $result = Invoke-PASRestMethod -Uri $URI -Method PUT -Body $Body -Headers $sessionToken -WebSession $WebSession

    }#process

    END {

        if($result) {

            $result.AddAccountPrivilegedCommandResult |

            Add-ObjectDetail -typename psPAS.CyberArk.Vault.ACL -PropertyToAdd @{

                "sessionToken" = $sessionToken
                "WebSession"   = $WebSession
                "BaseURI"      = $BaseURI
                "PVWAAppName"  = $PVWAAppName

            }

        }

    }#end

}