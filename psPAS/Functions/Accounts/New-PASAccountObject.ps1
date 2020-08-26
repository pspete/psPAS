# .ExternalHelp psPAS-help.xml
Function New-PASAccountObject {
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', 'remoteMachinesAccess', Justification = "False Positive")]
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', 'secretManagement', Justification = "False Positive")]
	[CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = "V10")]
	param(

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V10"
		)]
		[int]$uploadIndex,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V10"
		)]
		[string]$userName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V10"
		)]
		[string]$name,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V10"
		)]
		[string]$address,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V10"
		)]
		[Alias("PolicyID")]
		[string]$platformID,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V10"
		)]
		[ValidateNotNullOrEmpty()]
		[Alias("safe")]
		[string]$SafeName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V10"
		)]
		[ValidateSet("Password", "Key")]
		[string]$secretType,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V10"
		)]
		[securestring]$secret,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V10"
		)]
		[hashtable]$platformAccountProperties,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V10"
		)]
		[boolean]$automaticManagementEnabled,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V10"
		)]
		[string]$manualManagementReason,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V10"
		)]
		[string]$remoteMachines,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V10"
		)]
		[boolean]$accessRestrictedToRemoteMachines,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "V10"
		)]
		[string]$groupName

	)

	Begin {

		#V10 parameters are nested under JSON object properties
		$remoteMachine = [Collections.Generic.List[String]]@("remoteMachines", "accessRestrictedToRemoteMachines")
		$SecretMgmt = [Collections.Generic.List[String]]@("automaticManagementEnabled", "manualManagementReason")

	}

	Process {

		#Get all parameters that will be sent in the request
		$boundParameters = $PSBoundParameters | Get-PASParameter

		switch ($PSCmdlet.ParameterSetName) {

			"V10" {

				#deal with "secret" SecureString
				If ($PSBoundParameters.ContainsKey("secret")) {

					#Include decoded password in request
					$boundParameters["secret"] = $(ConvertTo-InsecureString -SecureString $secret)

				}

				$boundParameters.keys | Where-Object { $remoteMachine -contains $PSItem } | ForEach-Object {

					$remoteMachinesAccess = @{ }

				} {

					#add key=value to hashtable
					$remoteMachinesAccess[$PSItem] = $boundParameters[$PSItem]


				} {

					$boundParameters["remoteMachinesAccess"] = $remoteMachinesAccess

				}

				$boundParameters.keys | Where-Object { $SecretMgmt -contains $PSItem } | ForEach-Object {

					$secretManagement = @{ }

				} {

					#add key=value to hashtable
					$secretManagement[$PSItem] = $boundParameters[$PSItem]

				} {

					$boundParameters["secretManagement"] = $secretManagement

				}

				if ($PSCmdlet.ShouldProcess($userName, "Create Account Object Definition")) {

					$boundParameters | Get-PASParameter -ParametersToRemove @($remoteMachine + $SecretMgmt)

				}

				break

			}

		}

	}

	End {}

}