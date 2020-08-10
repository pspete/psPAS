function Remove-PASGroupMember {
	<#
.SYNOPSIS
Removes a vault user from a group

.DESCRIPTION
Removes an existing member from an existing group in the vault

.PARAMETER GroupID
The ID of the group

.PARAMETER Member
The name of the group member

.EXAMPLE
Remove-PASGroupMember -GroupID X1_Y2 -Member TargetUser

Removes TargetUser from group

.INPUTS
All parameters can be piped by property name

.LINK
https://pspas.pspete.dev/commands/Remove-PASGroupMember
#>
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias("ID")]
		[string]$GroupID,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias("UserName")]
		[string]$Member
	)

	BEGIN {
		Assert-VersionRequirement -RequiredVersion 10.5
	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/API/UserGroups/$GroupID/members/$Member"

		if ($PSCmdlet.ShouldProcess($GroupID, "Remove Group Member $Member")) {

			#send request to web service
			Invoke-PASRestMethod -Uri $URI -Method DELETE -WebSession $Script:WebSession

		}

	}#process

	END { }#end

}