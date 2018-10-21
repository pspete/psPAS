function Set-PASOnboardingRule {
	<#
.SYNOPSIS
Updates an automatic onboarding rule.

.DESCRIPTION
Updates an existing automatic onboarding rule.

.PARAMETER Id
The ID of the rule to update.

.PARAMETER TargetPlatformID
The ID of the platform that will be associated to the on-boarded account.

.PARAMETER TargetSafeName
The name of the Safe where the on-boarded account will be stored.

.PARAMETER IsAdminIDFilter
Whether or not UNIX accounts with UID=0 or Windows accounts with SID ending in 500 will be onboarded automatically
using this rule.
If set to false, all accounts matching the rule will be onboarded.

.PARAMETER MachineTypeFilter
The Machine Type by which to filter.
Leave blank for "Any"

.PARAMETER SystemTypeFilter
The System Type by which to filter.

.PARAMETER UserNameFilter
The name of the user by which to filter.

.PARAMETER UserNameMethod
The method to use when applying the user name filter (Equals / Begins with/ Ends with).
This parameter is ignored if UserNameFilter is not specified.

.PARAMETER AddressFilter
IP Address or DNS name of the machine by which to filter.

.PARAMETER AddressMethod
The method to use when applying the address filter (Equals / Begins with/ Ends with).
This parameter is ignored if AddressFilter is not specified.

.PARAMETER AccountCategoryFilter
Filter for Privileged or Non-Privileged accounts.

.PARAMETER RuleName
Name of the rule
If left blank, a name will be generated automatically.

.PARAMETER RuleDescription
A description of the rule.

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

.PARAMETER ExternalVersion
The External CyberArk Version, returned automatically from the New-PASSession function from version 9.7 onwards.
If the minimum version requirement of this function is not satisfied, execution will be halted.
Omitting a value for this parameter, or supplying a version of "0.0" will skip the version check.

.EXAMPLE
$token | Set-PASOnboardingRule -Id 1 -TargetPlatformId WINDOMAIN -TargetSafeName SafeName -SystemTypeFilter Windows

Updates Onboarding Rule with ID 1

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
Minimum Version: 10.5

.LINK

#>
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[int]$Id,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateLength(1, 99)]
		[string]$TargetPlatformId,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateLength(1, 28)]
		[string]$TargetSafeName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$IsAdminIDFilter,

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
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet("Equals", "Begins", "Ends")]
		[string]$UserNameMethod,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateLength(0, 255)]
		[string]$AddressFilter,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet("Equals", "Begins", "Ends")]
		[string]$AddressMethod,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet("Any", "Privileged", "NonPrivileged")]
		[string]$AccountCategoryFilter,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateLength(0, 255)]
		[string]$RuleName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateLength(0, 255)]
		[string]$RuleDescription,

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
		[string]$PVWAAppName = "PasswordVault",

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[System.Version]$ExternalVersion = "0.0"

	)

	BEGIN {
		$MinimumVersion = [System.Version]"10.5"
	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $ExternalVersion -RequiredVersion $MinimumVersion

		#Create URL for request
		$URI = "$baseURI/$PVWAAppName/api/AutomaticOnboardingRules/$Id"

		#create request body
		$body = $PSBoundParameters | Get-PASParameter -ParametersToRemove Id | ConvertTo-Json

		if($PSCmdlet.ShouldProcess($TargetPlatformId, "Update On-Boarding Rule $ID")) {

			#send request to web service
			$result = Invoke-PASRestMethod -Uri $URI -Method PUT -Body $Body -Headers $sessionToken -WebSession $WebSession

			if($result) {

				$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.OnboardingRule -PropertyToAdd @{

					"sessionToken"    = $sessionToken
					"WebSession"      = $WebSession
					"BaseURI"         = $BaseURI
					"PVWAAppName"     = $PVWAAppName
					"ExternalVersion" = $ExternalVersion

				}

			}

		}

	}#process

	END {}#end

}