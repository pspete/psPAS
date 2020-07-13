Function Get-PASPTAEvent {
	<#
.SYNOPSIS
Returns PTA security events

.DESCRIPTION
Returns PTA security events

.PARAMETER lastUpdatedEventDate
Starting date from which to get security events.

.PARAMETER status
The status of the security event (open or closed).
Requires 11.4

.PARAMETER accountID
The unique account identifier of the account relating to the Security Event.
Requires 11.4

.PARAMETER UseLegacyMethod
Specify to send lastUpdatedEventDate using legacy method
Requires 11.4

.EXAMPLE
Get-PASPTAEvent

Returns all PTA security events

.EXAMPLE
Get-PASPTAEvent -lastUpdatedEventDate $date

Returns all PTA security events since $date

.EXAMPLE
Get-PASPTAEvent -status OPEN

Returns all PTA security events with an Open status.

.EXAMPLE
Get-PASPTAEvent -lastUpdatedEventDate $date -UseLegacyMethod

Returns all PTA security events since $date

.NOTES
Minimum Version CyberArk 10.3

.LINK
https://pspas.pspete.dev/commands/Get-PASPTAEvent
#>
	[CmdletBinding(DefaultParameterSetName = "11_4")]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_4"
		)]

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10_3"
		)]
		[datetime]$lastUpdatedEventDate,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_4"
		)]
		[ValidateSet("OPEN", "CLOSED")]
		[string]$status,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "11_4"
		)]
		[string]$accountID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "10_3"
		)]
		[switch]$UseLegacyMethod

	)

	BEGIN {
		$MinimumVersion = [System.Version]"10.3"
		$RequiredVersion = [System.Version]"11.4"

	}#begin

	PROCESS {

		Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $MinimumVersion

		#Create request URL
		$URI = "$Script:BaseURI/API/pta/API/Events/"

		#Get Parameters to include in request
		$boundParameters = $PSBoundParameters | Get-PASParameter

		$ThisSession = $Script:WebSession

		if ($PSBoundParameters.ContainsKey("lastUpdatedEventDate")) {

			#add Unix Time Stamp of lastUpdatedEventDate to header as key=value pair
			$boundParameters["lastUpdatedEventDate"] = [math]::Round(($(Get-Date $(Get-Date $lastUpdatedEventDate) -UFormat %s)))

		}

		if ($PSCmdlet.ParameterSetName -eq "11_4") {

			Assert-VersionRequirement -ExternalVersion $Script:ExternalVersion -RequiredVersion $RequiredVersion

			#Create Query String, escaped for inclusion in request URL
			$queryString = $boundParameters | ConvertTo-QueryString

			if ($queryString) {

				#Build URL from base URL
				$URI = "$URI`?$queryString"

			}

		}
		Else {

			if ($PSBoundParameters.ContainsKey("lastUpdatedEventDate")) {

				#add Unix Time Stamp of lastUpdatedEventDate to header as key=value pair
				$ThisSession.Headers["lastUpdatedEventDate"] = $boundParameters["lastUpdatedEventDate"]

			}

		}

		#Send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $ThisSession

		If ($result) {

			#Return Results
			$result |

			Add-ObjectDetail -typename psPAS.CyberArk.Vault.PTA.Event

		}

	}#process

	END { }#end

}