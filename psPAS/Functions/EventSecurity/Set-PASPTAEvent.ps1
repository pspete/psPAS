Function Set-PASPTAEvent {
	<#
.SYNOPSIS
Updates the status of a security event

.DESCRIPTION
Updates the status of a security event to open or closed

.PARAMETER EventID
The event ID.

.PARAMETER mStatus
The status to update (open or closed).

.EXAMPLE
Set-PASPTAEvent -EventID $id

.NOTES
Minimum Version CyberArk 11.3

.LINK
https://pspas.pspete.dev/commands/Set-PASPTAEvent
#>
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$EventID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet("OPEN", "CLOSED")]
		[string]$mStatus

	)

	BEGIN {
		$MinimumVersion = [System.Version]"11.3"

	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

		#Create request URL
		$URI = "$Script:BaseURI/API/pta/API/Events/$EventID"

		#Get Parameters to include in request
		$body = $PSBoundParameters | Get-PASParameter -ParametersToRemove EventID | ConvertTo-Json

		#Send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method PATCH -Body $body

		If ($result) {

			#Return Results
			$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.PTA.Event

		}

	}#process

	END { }#end

}