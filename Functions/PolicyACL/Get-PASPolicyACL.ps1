function Get-PASPolicyACL{
<#
.SYNOPSIS
Lists OPM Rules for a policy

.DESCRIPTION
Gets a list of the priviledged commands (OPM Rules)
associated with this policy

.PARAMETER PolicyID
The ID of the Policy for which the privileged commands will be listed.

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
ListPolicyPrivilegedCommandsResult
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
        [string]$PolicyID,
          
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

        #Create URL for reuest
        $URI = "$baseURI/PasswordVault/WebServices/PIMServices.svc/Policy/$($PolicyID | 
        
            Get-EscapedString)/PrivilegedCommands"
        
        #Send Request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method GET -Headers $sessionToken -WebSession $WebSession

    }#process

    END{$result.ListPolicyPrivilegedCommandsResult}#end

}