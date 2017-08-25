function Add-PASAccountGroupMember{
<#
.SYNOPSIS
Adds an account as a member of an account group.

.DESCRIPTION
Adds an account as a member of an account group.
The account can contain either password or SSH key.
The account must be stored in the same safe as the account group.
The following permissions are required on the safe where the account group will be created:
 - Add Accounts
 - Update Account Content
 - Update Account Properties

.PARAMETER GroupID
The unique ID of the account group

.PARAMETER AccountID
The ID of the account to add as a member

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

.INPUTS
All parameters can be piped by property name

.OUTPUTS
Outputs Object of Custom Type psPAS.CyberArk.Vault.AccountGroup
SessionToken, WebSession, BaseURI are passed through and
contained in output object for inclusion in subsequent
pipeline operations.
Output format is defined via psPAS.Format.ps1xml.
To force all output to be shown, pipe to Select-Object *

.NOTES
[Ambiguous documentation] YMMV

.LINK

#>
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory=$true,
            ValueFromPipelinebyPropertyName=$true
        )]
        [ValidateNotNullOrEmpty()]
        [string]$GroupID,

        [parameter(
            Mandatory=$true,
            ValueFromPipelinebyPropertyName=$true
        )]
        [string]$AccountID,

        [parameter(
            Mandatory=$true,
            ValueFromPipelinebyPropertyName=$true
        )]
        [ValidateNotNullOrEmpty()]
        [hashtable]$sessionToken,

        [parameter(
            ValueFromPipelinebyPropertyName=$true
        )]
        [Microsoft.PowerShell.Commands.WebRequestSession]$WebSession,

        [parameter(
            Mandatory=$true,
            ValueFromPipelinebyPropertyName=$true
        )]
        [string]$BaseURI<#,

		[parameter(
			Mandatory=$false,
			ValueFromPipelinebyPropertyName=$true
		)]
		[string]$PVWAAppName = "PasswordVault"#>
    )

    BEGIN{}#begin

    PROCESS{

        #Create URL for Request
        $URI = "$baseURI/API/AccountGroups/$($GroupID |

            Get-EscapedString)/Members"

        #Create body of request
        $body = $PSBoundParameters |

            Get-PASParameters -ParametersToRemove GroupID |

                ConvertTo-Json

        #send request to PAS web service
        $result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -Headers $sessionToken -WebSession $WebSession

    }#process

    END{

        if($result){

            $result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.AccountGroup -PropertyToAdd @{

                            "sessionToken" = $sessionToken
                            "WebSession" = $WebSession
                            "BaseURI" = $BaseURI
					        #"PVWAAppName" = $PVWAAppName

            }

        }

    }#end

}