Function Copy-PASPlatform{
<#
.SYNOPSIS
Duplicates a platform

.DESCRIPTION
Duplicates target, dependent, group or rotational group platform to a new platform.

.PARAMETER TargetPlatform
Specify if ID relates to Target platform

.PARAMETER DependentPlatform
Specify if ID relates to Dependent platform

.PARAMETER GroupPlatform
Specify if ID relates to Group platform

.PARAMETER RotationalGroup
Specify if ID relates to Rotational Group platform

.PARAMETER ID
The unique ID number of the platofrm to duplicate

.PARAMETER name
The name for the duplicate platform

.PARAMETER description
A description for the duplicate platform

.EXAMPLE
Copy-PASPlatform -TargetPlatform -ID 9 -name SomeNewPlatform -description "Some Description"

Duplicates Target Platform with ID of 9 to SomeNewPlatform

.EXAMPLE
Copy-PASPlatform -DependentPlatform -ID 9 -name SomeNewPlatform -description "Some Description"

Duplicates Dependent Platform with ID of 9 to SomeNewPlatform

.EXAMPLE
Copy-PASPlatform -GroupPlatform -ID 39 -name SomeNewPlatform -description "Some Description"

Duplicates Group Platform with ID of 39 to SomeNewPlatform

.EXAMPLE
Copy-PASPlatform -RotationalGroup -ID 59 -name SomeNewPlatform -description "Some Description"

Duplicates Rotational Group Platform with ID of 59 to SomeNewPlatform

.NOTES
General notes
#>
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "targets"
		)]
		[switch]$TargetPlatform,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "dependents"
		)]
		[switch]$DependentPlatform,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "groups"
		)]
		[switch]$GroupPlatform,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "rotationalGroups"
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

		$MinimumVersion = [System.Version]"11.4"

	}#begin

	Process{

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

		#Create URL for request
		$URI = "$Script:BaseURI/API/Platforms/$($PSCmdLet.ParameterSetName)/$ID/duplicate"

		#Get request parameters
		$boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove ID, TargetPlatform,
		DependentPlatform, GroupPlatform, RotationalGroup

		$body = $boundParameters | ConvertTo-Json

		if ($PSCmdlet.ShouldProcess($ID, "Duplicate $($PSCmdLet.ParameterSetName) Platform")) {

			#send request
			$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $body -WebSession $Script:WebSession

			if ($result) {

				$result

			}

		}

	}

	End{}

}