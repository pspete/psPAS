function Remove-PASOnboardingRule{
<#
.SYNOPSIS
Deletes an automatic onboarding rule


.DESCRIPTION
Deletes an automatic onboarding rulefrom the Vault.
Vault Admin membership required.

.PARAMETER RuleID
The unique ID of the rule to delete.

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
        [string]$RuleID,
        
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
        $URI = "$baseURI/PasswordVault/api/AutomaticOnboardingRules/$($RuleID | 
        
            Get-EscapedString)"
        
        #Send request to web service
        Invoke-PASRestMethod -Uri $URI -Method DELETE -Headers $sessionToken -WebSession $WebSession

    }#process

    END{}#end
}