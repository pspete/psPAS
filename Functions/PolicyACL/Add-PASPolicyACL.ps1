function Add-PASPolicyACL {
    <#
.SYNOPSIS
Adds a new privileged command rule

.DESCRIPTION
Adds a new privileged command rule to a policy.

.PARAMETER Command
The Command to Add

.PARAMETER CommandGroup
Boolean to define if commandgroup

.PARAMETER PermissionType
Allow or Deny Permission

.PARAMETER PolicyId
String value of Policy ID

.PARAMETER Restrictions
A restrictions string

.PARAMETER UserName
The user this rule applies to.
Specify "*" for all users

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
$token | Add-PASPolicyACL -Command "chmod" -CommandGroup $false -PermissionType Allow -PolicyId UNIXSSH -UserName user1

Adds Rule to UNIXSSH platform

.INPUTS
All parameters can be piped by property name

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
        [ValidateNotNullOrEmpty()]
        [string]$Command,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [boolean]$CommandGroup,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet("Allow", "Deny")]
        [string]$PermissionType,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [string]$PolicyId,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [string]$Restrictions,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
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

        #Create URL for request
        $URI = "$baseURI/$PVWAAppName/WebServices/PIMServices.svc/Policy/$($PolicyID |

            Get-EscapedString)/PrivilegedCommands"

        #Create request body
        $body = $PSBoundParameters |

        Get-PASParameters -ParametersToRemove PolicyId |

        ConvertTo-Json

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method PUT -Body $Body -Headers $sessionToken -WebSession $WebSession

    }#process

    END {

        if($result) {

            $result.AddPolicyPrivilegedCommandResult |

            Add-ObjectDetail -typename psPAS.CyberArk.Vault.ACL -PropertyToAdd @{

                "sessionToken" = $sessionToken
                "WebSession"   = $WebSession
                "BaseURI"      = $BaseURI
                "PVWAAppName"  = $PVWAAppName

            }

        }

    }#end

}