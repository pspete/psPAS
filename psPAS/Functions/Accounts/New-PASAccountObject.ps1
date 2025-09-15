# .ExternalHelp psPAS-help.xml
function New-PASAccountObject {
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', 'remoteMachinesAccess', Justification = 'False Positive')]
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', 'secretManagement', Justification = 'False Positive')]
	[CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'AccountObject')]
	param(

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'AccountObject'
		)]
		[int]$uploadIndex,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'PersonalAdminAccount'
		)]

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'AccountObject'
		)]
		[string]$userName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'AccountObject'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'DependentAccountObject'
		)]
		[string]$name,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'PersonalAdminAccount'
		)]

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'AccountObject'
		)]
		[string]$address,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'AccountObject'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'DependentAccountObject'
		)]
		[Alias('PolicyID')]
		[string]$platformID,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'AccountObject'
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('safe')]
		[string]$SafeName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'AccountObject'
		)]
		[ValidateSet('Password', 'Key')]
		[string]$secretType,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'PersonalAdminAccount'
		)]

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'AccountObject'
		)]
		[securestring]$secret,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'AccountObject'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'DependentAccountObject'
		)]
		[hashtable]$platformAccountProperties,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'AccountObject'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'DependentAccountObject'
		)]
		[boolean]$automaticManagementEnabled,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'AccountObject'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'DependentAccountObject'
		)]
		[string]$manualManagementReason,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'AccountObject'
		)]
		[string]$remoteMachines,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'AccountObject'
		)]
		[boolean]$accessRestrictedToRemoteMachines,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'AccountObject'
		)]
		[string]$groupName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'PersonalAdminAccount'
		)]
		[switch]$PersonalAdminAccount,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'DependentAccountObject'
		)]
		[switch]$DependentAccount

	)

	begin {

		#V10 parameters are nested under JSON object properties
		$remoteMachine = [Collections.Generic.List[String]]@('remoteMachines', 'accessRestrictedToRemoteMachines')
		$SecretMgmt = [Collections.Generic.List[String]]@('automaticManagementEnabled', 'manualManagementReason')

	}

	process {

		#Get all parameters that will be sent in the request
		$boundParameters = $PSBoundParameters | Get-PASParameter

		#deal with "secret" SecureString
		if ($PSBoundParameters.ContainsKey('secret')) {

			#Include decoded password in request
			$boundParameters['secret'] = $(ConvertTo-InsecureString -SecureString $secret)

		}

		switch ($PSCmdlet.ParameterSetName) {

			'AccountObject' {

				$boundParameters.keys | Where-Object { $remoteMachine -contains $PSItem } | ForEach-Object {

					$remoteMachinesAccess = @{ }

				} {

					#add key=value to hashtable
					$remoteMachinesAccess[$PSItem] = $boundParameters[$PSItem]


				} {

					$boundParameters['remoteMachinesAccess'] = $remoteMachinesAccess

				}

				$boundParameters.keys | Where-Object { $SecretMgmt -contains $PSItem } | ForEach-Object {

					$secretManagement = @{ }

				} {

					#add key=value to hashtable
					$secretManagement[$PSItem] = $boundParameters[$PSItem]

				} {

					$boundParameters['secretManagement'] = $secretManagement

				}

				break

			}

			'DependentAccountObject' {

				$boundParameters.keys | Where-Object { $SecretMgmt -contains $PSItem } | ForEach-Object {

					$secretManagement = @{ }

				} {

					#add key=value to hashtable
					$secretManagement[$PSItem] = $boundParameters[$PSItem]

				} {

					$boundParameters['secretManagement'] = $secretManagement

				}

				break

			}

		}

		if ($PSCmdlet.ShouldProcess($userName, 'Create Account Object Definition')) {

			$boundParameters | Get-PASParameter -ParametersToRemove @($remoteMachine + $SecretMgmt + 'PersonalAdminAccount' + 'DependentAccount')

		}

	}

	end {}

}