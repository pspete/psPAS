# .ExternalHelp psPAS-help.xml
function New-PASOnboardingRule {
	[CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'Gen2')]
	param(

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[ValidateLength(1, 99)]
		[string]$TargetPlatformId,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[ValidateLength(1, 28)]
		[string]$TargetSafeName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[boolean]$IsAdminIDFilter,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[ValidateLength(1, 28)]
		[string]$DecisionSafeName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[ValidateLength(1, 99)]
		[string]$DecisionPlatformId,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[ValidateSet('Yes', 'No')]
		[String]$IsAdminUIDFilter,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet('Workstation', 'Server')]
		[string]$MachineTypeFilter,

		[parameter(
			Mandatory = $true,
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
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
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
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[ValidateSet('Equals', 'Begins', 'Ends')]
		[string]$AddressMethod,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
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

	BEGIN { }#begin

	PROCESS {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/api/AutomaticOnboardingRules"

		#create request body
		$body = $PSBoundParameters | Get-PASParameter | ConvertTo-Json

		#Get Values for ShouldProcess Message
		switch ($PSCmdlet.ParameterSetName) {

			'Gen2' {
				Assert-VersionRequirement -RequiredVersion 10.2
				#version 10.2 parameters
				$SafeName = $TargetSafeName
				$PlatformID = $TargetPlatformId
			}

			'Gen1' {
				Assert-VersionRequirement -RequiredVersion 9.8
				#pre 10.2 parameters
				$SafeName = $DecisionSafeName
				$PlatformID = $DecisionPlatformId
			}

		}

		if ($PSCmdlet.ShouldProcess($SafeName, "Add On-Boarding Rule Using '$PlatformID'")) {

			#send request to web service
			$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body

			If ($null -ne $result) {

				$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.OnboardingRule

			}

		}

	}#process

	END { }#end

}