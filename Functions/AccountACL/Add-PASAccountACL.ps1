function Add-PASAccountACL{
<#
.SYNOPSIS
Adds a new privileged command rule to an account.

.DESCRIPTION
Adds a new privileged command rule to an account.

.PARAMETER AccountPolicyId
The PolicyID associated with account.

.PARAMETER AccountAddress
The address of the account whose privileged commands will be listed.

.PARAMETER AccountUserName
The name of the account’s user.

.PARAMETER Command
The Command

.PARAMETER CommandGroup
Boolean for Command Grop

.PARAMETER PermissionType
Allow or Deny permission

.PARAMETER Restrictions
A restriction string

.PARAMETER UserName
The user this rule applies to

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
        [ValidateNotNullOrEmpty()]
        [string]$Command,

        [parameter(
            Mandatory=$true
        )]
        [boolean]$CommandGroup,

        [parameter(
            Mandatory=$true
        )]
        [ValidateSet("Allow","Deny")]
        [string]$PermissionType,

        [parameter(
            Mandatory=$false
        )]
        [ValidateNotNullOrEmpty()]
        [string]$Restrictions,

        [parameter(
            Mandatory=$true
        )]
        [ValidateNotNullOrEmpty()]
        [string]$UserName,
          
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

        #URL for request
        $URI = "$baseURI/PasswordVault/WebServices/PIMServices.svc/Account/$($AccountAddress | 
        
            Get-EscapedString)|$($AccountUserName | 
            
                Get-EscapedString)|$($AccountPolicyId | 
                
                    Get-EscapedString)/PrivilegedCommands"
        
        #Request body
        $Body = $PSBoundParameters | 
            
            Get-PASParameters -ParametersToRemove AccountAddress,AccountUserName,AccountPolicyID | 
            
                ConvertTo-Json
        
        #Send Request
        $result = Invoke-PASRestMethod -Uri $URI -Method PUT -Body $Body -Headers $sessionToken -WebSession $WebSession

    }#process

    END{$result.AddAccountPrivilegedCommandResult}#end

}