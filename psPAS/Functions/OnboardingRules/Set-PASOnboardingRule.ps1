# .ExternalHelp psPAS-help.xml
function Set-PASOnboardingRule {
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[int]$Id,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateLength(1, 99)]
		[string]$TargetPlatformId,

		[parameter(
			Mandatory = $false,
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
		[ValidateSet('Workstation', 'Server')]
		[string]$MachineTypeFilter,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet('Windows', 'Unix')]
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
		[ValidateSet('Equals', 'Begins', 'Ends')]
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
		[ValidateSet('Equals', 'Begins', 'Ends')]
		[string]$AddressMethod,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet('Any', 'Privileged', 'NonPrivileged')]
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
		Assert-VersionRequirement -RequiredVersion 10.5
	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/api/AutomaticOnboardingRules/$Id/"

		#request parameters
		$BoundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove Id

		$OnboardingRule = Get-PASOnboardingRule | Where-Object { $PSItem.RuleId -eq $Id }
		if ($null -ne $OnboardingRule) {
			Format-PutRequestObject -InputObject $OnboardingRule -boundParameters $BoundParameters -ParametersToKeep SystemTypeFilter,
			TargetPlatformId, TargetSafeName, AccountCategoryFilter, AddressFilter, AddressMethod, IsAdminIDFilter, MachineTypeFilter,
			RuleDescription, RuleName, UserNameFilter, UserNameMethod
		}

		#create request body
		$body = $BoundParameters | ConvertTo-Json

		if ($PSCmdlet.ShouldProcess($TargetPlatformId, "Update On-Boarding Rule $ID")) {

			#send request to web service
			$result = Invoke-PASRestMethod -Uri $URI -Method PUT -Body $Body

			If ($null -ne $result) {

				$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.OnboardingRule

			}

		}

	}#process

	END { }#end

}