function Get-PASAccountActivity {
    <#
.SYNOPSIS
Returns activities for an account.

.DESCRIPTION
Returns activities for a specific account identified by its AccountID.

.PARAMETER AccountID
The ID of the account whose activities will be retrieved.

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
$token | Get-PASAccount -Keywords root -Safe UNIXSafe | Get-PASAccountActivity

Will return the account activity for the account output by Get-PASAccount:

Time                Activity                  UserName      AccountName
----                --------                  --------      -----------
08/07/2017 13:05:46 Delete Privileged Command Administrator root
08/07/2017 13:02:54 Delete Privileged Command Administrator root
07/30/2017 10:49:32 Add Privileged Command    Administrator root
...
...
...

.INPUTS
All parameters can be piped by property name
Accepts pipeline input from Get-PASAccount

.OUTPUTS
Outputs Object of Custom Type psPAS.CyberArk.Vault.AccountActivity
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
        [string]$AccountID,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [hashtable]$sessionToken,

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

        #Create request URL
        $URI = "$baseURI/$PVWAAppName/WebServices/PIMServices.svc/Accounts/$($AccountID |

            Get-EscapedString)/Activities"

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET -Headers $sessionToken -WebSession $WebSession

    }#process

    END {

        If($result) {

            #Return Results
            $result.GetAccountActivitiesResult |

            Add-ObjectDetail -typename psPAS.CyberArk.Vault.AccountActivity -PropertyToAdd @{

                "sessionToken" = $sessionToken
                "WebSession"   = $WebSession
                "BaseURI"      = $BaseURI
                "PVWAAppName"  = $PVWAAppName

            }

        }

    }#end

}