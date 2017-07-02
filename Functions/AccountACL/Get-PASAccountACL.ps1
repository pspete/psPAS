function Get-PASAccountACL{
<#
.SYNOPSIS
Lists privileged commands rule for an account

.DESCRIPTION
Gets list of all priviledged commands associated with an account

.PARAMETER AccountPolicyId
The PolicyID associated with account.

.PARAMETER AccountAddress
The address of the account whose privileged commands will be listed.

.PARAMETER AccountUserName
The name of the account’s user.

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
TODO

.NOTES

.LINK

#>
    [CmdletBinding()]  
    param(
        [parameter(
            Mandatory=$true
        )]
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
        
        #Create URL for request
        $URI = "$baseURI/PasswordVault/WebServices/PIMServices.svc/Account/$($AccountAddress | 
        
            Get-EscapedString)|$($AccountUserName | 
            
                Get-EscapedString)|$($AccountPolicyId | 
                
                    Get-EscapedString)/PrivilegedCommands"
        
        #Send request to Web Service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET -Headers $sessionToken -WebSession $WebSession

    }#process

    END{$result.ListAccountPrivilegedCommandsResult}#end

}