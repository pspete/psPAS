Function Get-PASPTAEvent {
	<#
.SYNOPSIS
Returns PTA security events

.DESCRIPTION
Returns PTA security events

.PARAMETER fromUpdateDate
Starting date from which to get security events.
Requires 11.3

.PARAMETER status
The status of the security event (open or closed).
Requires 11.3

.PARAMETER accountID
The unique account identifier of the account relating to the Security Event.
Requires 11.4

.PARAMETER lastUpdatedEventDate
Starting date from which to get security events.

.EXAMPLE
Get-PASPTAEvent

Returns all PTA security events

.EXAMPLE
Get-PASPTAEvent -fromUpdateDate $date

Returns all PTA security events since $date

.EXAMPLE
Get-PASPTAEvent -status OPEN

Returns all PTA security events with an Open status.

.EXAMPLE
Get-PASPTAEvent -lastUpdatedEventDate $date

Returns all PTA security events since $date

.NOTES
Minimum Version CyberArk 10.3

.LINK
https://pspas.pspete.dev/commands/Get-PASPTAEvent
#>
	[CmdletBinding(DefaultParameterSetName = "11.3")]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11.4"
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11.3"
		)]
		[datetime]$fromUpdateDate,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11.3"
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11.4"
		)]
		[ValidateSet("OPEN", "CLOSED")]
		[string]$status,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11.4"
		)]
		[string]$accountID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10.3"
		)]
		[datetime]$lastUpdatedEventDate

	)

	BEGIN {

	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $PSCmdlet.ParameterSetName

		#Create request URL
		$URI = "$Script:BaseURI/API/pta/API/Events/"

		#Get Parameters to include in request
		$boundParameters = $PSBoundParameters | Get-PASParameter

		$ThisSession = $Script:WebSession

		if ($PSCmdlet.ParameterSetName -eq "10.3") {

			if ($PSBoundParameters.ContainsKey("lastUpdatedEventDate")) {

				#add Unix Time Stamp of lastUpdatedEventDate to header as key=value pair
				$boundParameters["lastUpdatedEventDate"] = $lastUpdatedEventDate | ConvertTo-UnixTime

				$ThisSession.Headers["lastUpdatedEventDate"] = $boundParameters["lastUpdatedEventDate"]

			}

		}
		Else {

			if ($PSBoundParameters.ContainsKey("fromUpdateDate")) {

				#Include time as unixtimestamp in milliseconds
				$boundParameters["fromUpdateDate"] = $fromUpdateDate | ConvertTo-UnixTime -Milliseconds

			}

			#Create Query String, escaped for inclusion in request URL
			$queryString = $boundParameters | ConvertTo-QueryString

			if ($null -ne $queryString) {

				#Build URL from base URL
				$URI = "$URI`?$queryString"

			}

		}

		#Send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $ThisSession

		If ($null -ne $result) {

			#Return Results
			$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.PTA.Event

		}

	}#process

	END { }#end

}