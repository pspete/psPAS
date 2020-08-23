Function New-PASAccountObject {
	<#
	.SYNOPSIS
	Creates hashtable structured to be used as input for add account operations

	.DESCRIPTION
	Provide parameter values to return hashtable structured to be used as input for add account operations.

	.PARAMETER uploadIndex
	The numeric identifier for the account.

	.PARAMETER userName
	Username on the target machine

	.PARAMETER name
	The name of the account.

	.PARAMETER address
	The Address of the machine where the account will be used

	.PARAMETER platformID
	The CyberArk platform to assign to the account

	.PARAMETER SafeName
	The safe where the account will be created

	.PARAMETER secretType
	The type of password.

	.PARAMETER secret
	The password value

	.PARAMETER platformAccountProperties
	key-value pairs to associate with the account, as defined by the account platform.
	These properties are validated against the mandatory and optional properties of the specified platform's definition.

	.PARAMETER automaticManagementEnabled
	Whether CPM Password Management should be enabled

	.PARAMETER manualManagementReason
	A reason for disabling CPM Password Management

	.PARAMETER remoteMachines
	For supported platforms, a list of remote machines the account can connect to.

	.PARAMETER accessRestrictedToRemoteMachines
	Whether access is restricted to the defined remote machines.

	.PARAMETER groupName
	Group to associate the account with

	.EXAMPLE
	New-PASAccountObject -userName SomeAccount1 -address domain.com -platformID WinDomain -SafeName SomeSafe

	Returns hashtable structured to be used as input for add account operations

	.LINK
	https://pspas.pspete.dev/commands/New-PASAccountObject

	#>
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