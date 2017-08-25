function New-PASOnboardingRule {
    <#
.SYNOPSIS
Adds a new on-boarding rule to the Vault

.DESCRIPTION
Adds a new on-boarding rule to the Vault, that filters discovered local privileged pending accounts.
When a discovered pending account matches a rule, it will be automatically on-boarded to the safe that
is defined in the rule and the password will be reconciled.

This function must be run with a Vault Admin account.

.PARAMETER DecisionPlatformId
The ID of the platform that will be associated to the on-boarded account.

.PARAMETER DecisionSafeName
The name of the Safe where the on-boarded account will be stored.

.PARAMETER IsAdminUIDFilter
Whether or not only pending accounts whose UID is set to will be on-boarded
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

.PARAMETER PVWAAppName
The name of the CyberArk PVWA Virtual Directory.
Defaults to PasswordVault

.EXAMPLE
$token | New-PASOnboardingRule -DecisionPlatformId DecisionPlatform -DecisionSafeName DecisionSafe -SystemTypeFilter Windows

Adds Onboarding Rule for Windows Accounts

.INPUTS
All parameters can be piped by property name

.OUTPUTS
Outputs Object of Custom Type psPAS.CyberArk.Vault.OnboardingRule
SessionToken, WebSession, BaseURI are passed through and
contained in output object for inclusion in subsequent
pipeline operations.

Output format is defined via psPAS.Format.ps1xml.
To force all output to be shown, pipe to Select-Object *

.NOTES
Not Tested

.LINK

#>
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateLength(1, 99)]
        [string]$DecisionPlatformId,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateLength(1, 28)]
        [string]$DecisionSafeName,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet("Yes", "No")]
        [String]$IsAdminUIDFilter,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet("Workstation", "Server")]
        [string]$MachineTypeFilter,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet("Windows", "Unix")]
        [string]$SystemTypeFilter,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateLength(0, 512)]
        [string]$UserNameFilter,

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
        [string]$BaseURI<#,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$PVWAAppName = "PasswordVault"#>
    )

    BEGIN {}#begin

    PROCESS {

        #Create URL for request
        $URI = "$baseURI/$PVWAAppName/api/AutomaticOnboardingRules"

        #create request body
        $body = $PSBoundParameters | Get-PASParameters | ConvertTo-Json

        #send request to web service
        $result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -Headers $sessionToken -WebSession $WebSession

    }#process

    END {

        $result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.OnboardingRule -PropertyToAdd @{

            "sessionToken" = $sessionToken
            "WebSession"   = $WebSession
            "BaseURI"      = $BaseURI
            #"PVWAAppName"  = $PVWAAppName

        }

    }#end

}