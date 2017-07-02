function Remove-PASSafe{
<#
.SYNOPSIS
Delets a safe from the Vault


.DESCRIPTION
Delets a safe from the Vault.
The "Manage" Safe vault permission is required.

.PARAMETER SafeName
The name of the safe to delete.

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

.OUTPUTS
None


.NOTES

.LINK

#>
    [CmdletBinding()]  
    param(
        [parameter(
            Mandatory=$true,
            ValueFromPipelinebyPropertyName=$true
        )]
        [ValidateNotNullOrEmpty()]
        [string]$SafeName,
          
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
        [string]$BaseURI
    )
    
    BEGIN{}#begin

    PROCESS{
        
        #Create URL for request
        $URI = "$baseURI/PasswordVault/WebServices/PIMServices.svc/Safes/$($SafeName | 
        
            Get-EscapedString)"
        
        #Send request to web service
        Invoke-PASRestMethod -Uri $URI -Method DELETE -Headers $sessionToken -WebSession $WebSession

    }#process

    END{}#end
}