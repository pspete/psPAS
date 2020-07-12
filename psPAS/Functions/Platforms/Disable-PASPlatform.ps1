Function Disable-PASPlatform {
	<#
.SYNOPSIS
Deactivates a platform.

.DESCRIPTION
Disables, target, group or rotational group platform.

.PARAMETER TargetPlatform
Specify if ID relates to Target platform

.PARAMETER GroupPlatform
Specify if ID relates to Group platform

.PARAMETER RotationalGroup
Specify if ID relates to Rotational Group platform

.PARAMETER ID
The unique ID number of the platofrm to disable.

.EXAMPLE
Disable-PASPlatform -TargetPlatform -ID 53

Disables Target Platform with ID of 53

.EXAMPLE
Disable-PASPlatform -GroupPlatform -id 64

Disables Group Platform with ID of 64

.EXAMPLE
Disable-PASPlatform -RotationalGroup -id 65

Disables Rotational Group Platform with ID of 65

.NOTES
PAS 11.4 minimum
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
		[int]$ID
	)

	BEGIN {

		$MinimumVersion = [System.Version]"11.4"

	}#begin

	Process {

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

		#Create URL for request
		$URI = "$Script:BaseURI/api/platforms/$($PSCmdLet.ParameterSetName)/$ID/deactivate"

		if ($PSCmdlet.ShouldProcess($ID, "Deactivate $($PSCmdLet.ParameterSetName) Platform")) {

			#send request to web service
			Invoke-PASRestMethod -Uri $URI -Method POST -WebSession $Script:WebSession

		}

	}

}