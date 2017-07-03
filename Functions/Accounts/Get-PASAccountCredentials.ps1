function Get-PASAccountCredentials{
<#
.SYNOPSIS
Returns password for an account.

.DESCRIPTION
Returns password for an account identified by its AccountID.
Will not return SSH Keys.
Cannot be used if a reson for password access must be specified.

.PARAMETER AccountID
The ID of the account whose password will be retrieved.

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
            Mandatory=$false
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
        
            Get-EscapedString)/Credentials"

        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET -Headers $sessionToken -WebSession $WebSession
        
    }#process

    END{
    
        #Return Results
        $result.Credentials
        
    }#end

}