function Remove-PASAccount {
    <#
.SYNOPSIS
Deletes an account

.DESCRIPTION
Deletes a specific account in the Vault.
The user who runs this web service requires the "Delete Accounts" permission

.PARAMETER AccountID
The unique ID  of the account to delete.
This is retrieved by the Get-PASAccount function.

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
$token | Remove-PASAccount -AccountID 19_1

Deletes the account with AccountID of 19_1

.INPUTS
All parameters can be piped by propertyname

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
        [string]$AccountID,

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
        $URI = "$baseURI/$PVWAAppName/WebServices/PIMServices.svc/Accounts/$AccountID"

        #Send request to webservice
        Invoke-PASRestMethod -Uri $URI -Method DELETE -Headers $sessionToken -WebSession $WebSession

    }#process

    END {}#end
}