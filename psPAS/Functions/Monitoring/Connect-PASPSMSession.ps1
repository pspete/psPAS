# .ExternalHelp psPAS-help.xml
function Connect-PASPSMSession {
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$SessionId,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet('RDP', 'PSMGW')]
		[string]$ConnectionMethod
	)

	BEGIN {
		Assert-VersionRequirement -RequiredVersion 10.5
	}#begin

	PROCESS {

		#Create URL for Request
		$URI = "$($($psPASSession.BaseURI))/API/LiveSessions/$($SessionId | Get-EscapedString)/monitor"

		$ThisSession = $psPASSession.WebSession

		#if a connection method is specified
		If ($PSBoundParameters.ContainsKey('ConnectionMethod')) {

			#The information needs to passed in the header
			if ($PSBoundParameters['ConnectionMethod'] -eq 'RDP') {

				#RDP accept "application/json" response
				$Accept = 'application/json'

			} elseif ($PSBoundParameters['ConnectionMethod'] -eq 'PSMGW') {

				#PSMGW accept * / * response
				$Accept = '* / *'

			}

			#add detail to header
			$ThisSession.Headers['Accept'] = $Accept

		}

		#send request to PAS web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $ThisSession

		If ($null -ne $result) {

			$result

		} #process

	}

	END { }#end

}