Function Remove-PASGroup {
<#
.SYNOPSIS
Deletes a user group

.DESCRIPTION
Deletes a user group.

To delete a user group, the following authorizations are required:

- Add/Update Users

.PARAMETER GroupID
The unique ID of the group to delete.

.EXAMPLE
Delete-PASGroup -GroupID 3

Deletes Group with ID of 3
#>
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[int]$GroupID
	)

	BEGIN {

		$MinimumVersion = [System.Version]"11.5"

	}#begin

	Process {

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

		#Create URL for request
		$URI = "$Script:BaseURI/API/UserGroups/$GroupID"

		if ($PSCmdlet.ShouldProcess($GroupID, "Delete Group")) {

			#send request to web service
			Invoke-PASRestMethod -Uri $URI -Method DELETE -WebSession $Script:WebSession

		}

	}

	End { }

}