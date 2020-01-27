function New-PASOnboardingRule {
	<#
.SYNOPSIS
Adds a new on-boarding rule to the Vault

.DESCRIPTION
Adds a new on-boarding rule to the Vault, that filters discovered local privileged pending accounts.
When a discovered pending account matches a rule, it will be automatically on-boarded to the safe that
is defined in the rule and the password will be reconciled.
If a newly discovered account does not match any rule, it will be added to the PendingAccounts list.

This function must be run with a Vault Admin account.

.PARAMETER DecisionPlatformId
The ID of the platform that will be associated to the on-boarded account.
For Versions 9.8 to 10.1

.PARAMETER TargetPlatformID
The ID of the platform that will be associated to the on-boarded account.
For Version 10.2 onwards

.PARAMETER DecisionSafeName
The name of the Safe where the on-boarded account will be stored.
For Versions 9.8 to 10.1

.PARAMETER TargetSafeName
The name of the Safe where the on-boarded account will be stored.
For Version 10.2 onwards

.PARAMETER IsAdminUIDFilter
Whether or not only pending accounts whose UID is set to will be on-boarded
automatically according to this rule.
For Versions 9.8 to 10.1

.PARAMETER IsAdminIDFilter
Whether or not UNIX accounts with UID=0 or Windows accounts with SID ending in 500 will be onboarded automatically
using this rule.
If set to false, all accounts matching the rule will be onboarded.
For Version 10.2 onwards

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
For Version 10.2 onwards

.PARAMETER AddressFilter
IP Address or DNS name of the machine by which to filter.
For Version 10.2 onwards

.PARAMETER AddressMethod
The method to use when applying the address filter (Equals / Begins with/ Ends with).
This parameter is ignored if AddressFilter is not specified.
For Version 10.2 onwards

.PARAMETER AccountCategoryFilter
Filter for Privileged or Non-Privileged accounts.
For Version 10.2 onwards

.PARAMETER RuleName
Name of the rule
If left blank, a name will be generated automatically.
For Version 10.2 onwards

.PARAMETER RuleDescription
A description of the rule.
For Version 10.2 onwards

.EXAMPLE
New-PASOnboardingRule -DecisionPlatformId DecisionPlatform -DecisionSafeName DecisionSafe -SystemTypeFilter Windows

Adds Onboarding Rule for Windows Accounts

.INPUTS
All parameters can be piped by property name

.OUTPUTS
Outputs Object of Custom Type psPAS.CyberArk.Vault.OnboardingRule
Output format is defined via psPAS.Format.ps1xml.
To force all output to be shown, pipe to Select-Object *

.NOTES
Before running:
Create the Safe and the reconcile account according to the rule�s definition.
Associate the reconcile account with the platform that is defined in the rule.
Make sure that the user whose credentials will be used for this session is a member of
the Safe specified in the TargetSafeName parameter with the Add accounts permission.

.LINK
https://pspas.pspete.dev/commands/New-PASOnboardingRule
#>
	[CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = "post_V10_2")]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "pre_V10_2"
		)]
		[ValidateLength(1, 99)]
		[string]$DecisionPlatformId,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "post_V10_2"
		)]
		[ValidateLength(1, 99)]
		[string]$TargetPlatformId,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "pre_V10_2"
		)]
		[ValidateLength(1, 28)]
		[string]$DecisionSafeName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "post_V10_2"
		)]
		[ValidateLength(1, 28)]
		[string]$TargetSafeName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "pre_V10_2"
		)]
		[ValidateSet("Yes", "No")]
		[String]$IsAdminUIDFilter,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "post_V10_2"
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
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "post_V10_2"
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
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "post_V10_2"
		)]
		[ValidateSet("Equals", "Begins", "Ends")]
		[string]$AddressMethod,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "post_V10_2"
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
		[string]$RuleDescription
	)

	BEGIN {
		$MinimumVersion = [System.Version]"9.8"
		$RequiredVersion = [System.Version]"10.2"
	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/api/AutomaticOnboardingRules"

		#create request body
		$body = $PSBoundParameters | Get-PASParameter | ConvertTo-Json

		#Get Values for ShouldProcess Message
		If ($PSCmdlet.ParameterSetName -eq "post_V10_2") {

			Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $RequiredVersion

			#version 10.2 parameters
			$SafeName = $TargetSafeName
			$PlatformID = $TargetPlatformId

		}
		ElseIf ($PSCmdlet.ParameterSetName -eq "pre_V10_2") {

			Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

			#pre 10.2 parameters
			$SafeName = $DecisionSafeName
			$PlatformID = $DecisionPlatformId

		}

		if ($PSCmdlet.ShouldProcess($SafeName, "Add On-Boarding Rule Using '$PlatformID'")) {

			#send request to web service
			$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -WebSession $Script:WebSession

			if ($result) {

				$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.OnboardingRule

			}

		}

	}#process

	END { }#end

}