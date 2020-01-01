function Disable-PASCPMAutoManagement {
	<#
.SYNOPSIS
Disables an account for Automatic CPM Management.

.DESCRIPTION
Disables an account for CPM management by setting automaticManagementEnabled to $false, 
and optionally sets a value for manualManagementReason.

.PARAMETER AccountID
The ID of the account to disable automaic CPM management.

.PARAMETER Reason
The value to set for manualManagementReason

.EXAMPLE
Disables-PASCPMAutoManagement -AccountID 543_2

Sets automaticManagementEnabled to $false on account with ID 543_2

.EXAMPLE
Disables-PASCPMAutoManagement -AccountID 543_2 -Reason "Some Reason"

Sets automaticManagementEnabled to $false & sets manualManagementReason on account with ID 543_2

.NOTES
Applicable to and requires 10.4+

.LINK
https://pspas.pspete.dev/commands/Disable-PASCPMAutoManagement
#>
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias("id")]
		[string]$AccountID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "manualManagementReason"
		)]
		[string]$Reason

	)

	BEGIN { 

		$MinimumVersion = [System.Version]"10.4"

		$ops = [Collections.Generic.List[Object]]@(
			@{
				"path"  = "/secretManagement/automaticManagementEnabled"
				"op"    = "replace"
				"value" = $false
			}
		)

	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

		if ($PSCmdlet.ParameterSetName -eq "manualManagementReason") {
			
			$null = $ops.Add(@{
				"path"  = "/secretManagement/manualManagementReason"
				"op"    = "replace"
				"value" = $Reason
			})
		}

		Set-PASAccount -AccountID $AccountID -operations $ops

	}#process

	END { }#end

}