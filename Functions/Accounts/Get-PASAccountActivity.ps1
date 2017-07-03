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
sessionToken, WebSession, BaseURI can be piped by property name

.OUTPUTS
AccountID, Account Safe, Safe Folder, Account Name,
and any other set property of the account are contained in output.

.NOTES
.LINK
#>
    [CmdletBinding()]  
    param(
        [parameter(
            Mandatory=$true
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
    
        #Return Results
        $result
        
    }#end

}