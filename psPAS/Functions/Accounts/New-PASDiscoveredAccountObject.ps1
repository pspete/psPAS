# .ExternalHelp psPAS-help.xml
function New-PASDiscoveredAccountObject {
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', 'identifiers', Justification = 'False Positive')]
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$type,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$subType,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$address,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$username,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$externalId
	)

	begin {

		$identifierProperties = [Collections.Generic.List[String]]@('address', 'username')

	}#begin

	process {

		#Get all parameters that will be used to build the object
		$boundParameters = $PSBoundParameters | Get-PASParameter

		$boundParameters.keys | Where-Object { $identifierProperties -contains $PSItem } | ForEach-Object {

			$identifiers = @{ }

		} {

			#add key=value to hashtable
			$identifiers[$PSItem] = $boundParameters[$PSItem]

		} {

			$boundParameters['identifiers'] = $identifiers

		}

		if ($PSCmdlet.ShouldProcess($externalId, 'Create Discovered Account Object Definition')) {

			$boundParameters | Get-PASParameter -ParametersToRemove $identifierProperties

		}

	}#process

	end {}

}
