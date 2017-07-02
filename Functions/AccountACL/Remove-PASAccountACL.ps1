function Remove-PASAccountACL{
<#
.SYNOPSIS
Deletes privileged commands rule from an account

.DESCRIPTION
Deletes privileged commands rule associated with account

.PARAMETER PolicyID
ID of account from which the commands will be deleted

.PARAMETER Id
The ID of the command that will be deleted

.PARAMETER sessionToken
Hashtable containing the session token returned from New-PASSession

.PARAMETER sessionToken
Hashtable containing the session token returned from New-PASSession

.PARAMETER WebSession
WebRequestSession object returned from New-PASSession

.PARAMETER BaseURI
PVWA Web Address
Do not include "/PasswordVault/"

.EXAMPLE

.INPUTS
SessionToken, WebSession, BaseURI can be piped by property name

.OUTPUTS
None

.NOTES

.LINK

#>
    [CmdletBinding()]  
    param(
        [parameter(
            Mandatory=$true
        )]
        [ValidateNotNullOrEmpty()]
        [string]$PolicyID,

        [parameter(
            Mandatory=$true
        )]
        [ValidateNotNullOrEmpty()]
        [string]$AccountPolicyId,

        [parameter(
            Mandatory=$true
        )]
        [ValidateNotNullOrEmpty()]
        [string]$AccountAddress,

        [parameter(
            Mandatory=$true
        )]
        [ValidateNotNullOrEmpty()]
        [string]$AccountUserName,

        [parameter(
            Mandatory=$true
        )]
        [string]$Id,
          
        [parameter(
            Mandatory=$true,
            ValueFromPipelinebyPropertyName=$true
        )]
        [ValidateNotNullOrEmpty()]
        [hashtable]$SessionToken,

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

        #Request URL
        $URI = "$baseURI/PasswordVault/WebServices/PIMServices.svc/Policy/$($PolicyID | 
        
            Get-EscapedString)/PrivilegedCommands/$($Id | 
            
                Get-EscapedString)"
        
        #Request Body
        $Body = $PSBoundParameters | 
        
            Get-PASParameters -ParametersToRemove AccountAddress,AccountUserName,AccountPolicyID | 
            
                ConvertTo-Json

                #Send Request to Web Service
        Invoke-PASRestMethod -Uri $URI -Method DELETE -Body $Body -Headers $sessionToken -WebSession $WebSession

    }#process

    END{}#end

}