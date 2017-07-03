function New-PASOnboardingRule{
<#
.SYNOPSIS
Adds a new onboarding rule to the Vault

.DESCRIPTION
Adds a new onboarding rule to the Vault., that filters discovered
local privileged pending accounts.
When a discovered pending account matches a rule, it will be automatically onboarded to the safe that
is defined in the rule and the password will be reconciled.

This function must be run with a Vault Admin account.

.PARAMETER DecisionPlatformId
The ID of the platform that will be associated to the onboarded account.

.PARAMETER DecisionSafeName
The name of the Safe where the onboarded account will be stored.

.PARAMETER IsAdminUIDFilter
Whether or not only pending accounts whose UID is set to will be onboarded 
automatically according to this rule.

.PARAMETER MachineTypeFilter
The Machine Type by which to filter.

.PARAMETER SystemTypeFilter
The System Type by which to filter.

.PARAMETER UserNameFilter
The name of the user by which to filter.

.PARAMETER sessionToken
Hashtable containing the session token returned from New-PASSession

.PARAMETER WebSession
WebRequestSession object returned from New-PASSession

.PARAMETER BaseURI
PVWA Web Address
Do not include "/PasswordVault/"

.EXAMPLE

.INPUTS
SessionToken, WebSession & BaseURI can be piped to the function by propertyname

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
        [ValidateLength(1,99)]
        [string]$DecisionPlatformId,

        [parameter(
            Mandatory=$true
        )]
        [ValidateLength(1,28)]
        [string]$DecisionSafeName,

        [parameter(
            Mandatory=$false
        )]
        [ValidateSet("Yes","No")]
        [String]$IsAdminUIDFilter,

        [parameter(
            Mandatory=$false
        )]
        [ValidateSet("Workstation","Server")]
        [string]$MachineTypeFilter,

        [parameter(
            Mandatory=$true
        )]
        [ValidateSet("Windows","Unix")]
        [string]$SystemTypeFilter,

        [parameter(
            Mandatory=$false
        )]
        [ValidateLength(0,512)]
        [string]$UserNameFilter,
          
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
        $URI = "$baseURI/PasswordVault/api/AutomaticOnboardingRules"

        #create request body
        $body = $PSBoundParameters | Get-PASParameters | ConvertTo-Json

        #send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -Headers $sessionToken -WebSession $WebSession

    }#process

    END{$result}#end
}