function Add-PASPolicyACL{
<#
.SYNOPSIS
Adds a new privileged command rule

.DESCRIPTION
Adds a new privileged command rule to a policy.

.PARAMETER Command
The Command to Add

.PARAMETER CommandGroup
Boolean to define if commandgroup

.PARAMETER PermissionType
Allow or Deny Permission

.PARAMETER PolicyId
String value of Policy ID

.PARAMETER Restrictions
A restrictions string

.PARAMETER UserName
The user this rule applies to.
Specify "*" for all users

.PARAMETER sessionToken
Hashtable containing the session token returned from New-PASSession

.PARAMETER WebSession
WebRequestSession object returned from New-PASSession

.PARAMETER BaseURI
PVWA Web Address
Do not include "/PasswordVault/"

.EXAMPLE

.INPUTS
SessionToken, WebSession & BaseURI can be piped by property name

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
            Mandatory=$true
        )]
        [ValidateNotNullOrEmpty()]
        [string]$PolicyId,

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
        $URI = "$baseURI/PasswordVault/WebServices/PIMServices.svc/Policy/$($PolicyID | 
        
            Get-EscapedString)/PrivilegedCommands"
        
        #Create request body
        $body = $PSBoundParameters | 
        
            Get-PASParameters -ParametersToRemove PolicyId | 
            
                ConvertTo-Json
        
        #Send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method PUT -Body $Body -Headers $sessionToken -WebSession $WebSession

    }#process

    END{$result.AddPolicyPrivilegedCommandResult}#end

}