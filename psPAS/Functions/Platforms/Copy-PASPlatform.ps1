# .ExternalHelp psPAS-help.xml
Function Copy-PASPlatform {
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'targets'
		)]
		[switch]$TargetPlatform,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'dependents'
		)]
		[switch]$DependentPlatform,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'groups'
		)]
		[switch]$GroupPlatform,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'rotationalGroups'
		)]
		[switch]$RotationalGroup,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[int]$ID,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$name,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$description
	)

	BEGIN {

		Assert-VersionRequirement -RequiredVersion 11.4

	}#begin

	Process {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/API/Platforms/$($PSCmdLet.ParameterSetName)/$ID/duplicate"

		#Get request parameters
		$boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove ID, TargetPlatform,
		DependentPlatform, GroupPlatform, RotationalGroup

		$body = $boundParameters | ConvertTo-Json

		if ($PSCmdlet.ShouldProcess($ID, "Duplicate $($PSCmdLet.ParameterSetName) Platform")) {

			#send request
			$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $body

			If ($null -ne $result) {

				$result

			}

		}

	}

	End { }

}