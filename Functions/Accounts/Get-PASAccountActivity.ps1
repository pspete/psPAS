function Get-PASAccountActivity{
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

.EXAMPLE

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

        [parameter(ValueFromPipelinebyPropertyName=$true)]
        [Microsoft.PowerShell.Commands.WebRequestSession]$WebSession,

        [parameter(
            Mandatory=$true,
            ValueFromPipelinebyPropertyName=$true
        )]
        [string]$BaseURI

    )

    BEGIN{}#begin

    PROCESS{

        #Create request URL
        $URI = "$baseURI/PasswordVault/WebServices/PIMServices.svc/Accounts/$($AccountID | 
        
            Get-EscapedString)/Activities"

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET -Headers $sessionToken -WebSession $WebSession
        
    }#process

    END{
    
        If($result){

            #Return Results
            $result.GetAccountActivitiesResult | 
            
                Add-ObjectDetail -typename psPAS.CyberArk.Vault.AccountActivity -PropertyToAdd @{

                        "sessionToken" = $sessionToken
                        "WebSession" = $WebSession
                        "BaseURI" = $BaseURI

                }
        
        }
        
    }#end

}