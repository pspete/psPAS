function Enable-PASCPMAutoManagement {
	<#
.SYNOPSIS
Enables an account for Automatic CPM Management.

.DESCRIPTION
Enables an account for CPM management by setting automaticManagementEnabled to $true, 
and clearing any value set for manualManagementReason.

Attempting to set automaticManagementEnabled to $true without clearing manualManagementReason
at the same time results in an error.

This function requests the API to perform both operations with a single command.

.PARAMETER AccountID
The ID of the account to enable for automatic management by CPM.

.EXAMPLE
Enable-PASCPMAutoManagement -AccountID 543_2

Sets automaticManagementEnabled to $true & clears any value set for manualManagementReason
on account with ID 543_2

.NOTES
Applicable to and requires 10.4+

.LINK
https://pspas.pspete.dev/commands/Enable-PASCPMAutoManagement
#>
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias("id")]
		[string]$AccountID

	)

	BEGIN { 

		$MinimumVersion = [System.Version]"10.4"

		$ops = @(
			@{
				"path"  = "/secretManagement/automaticManagementEnabled"
				"op"    = "replace"
				"value" = $true
			},
			@{
				"path"  = "/secretManagement/manualManagementReason"
				"op"    = "replace"
				"value" = ""
			}
		)

	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

		Set-PASAccount -AccountID $AccountID -operations $ops

	}#process

	END { }#end

}