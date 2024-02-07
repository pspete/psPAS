# .ExternalHelp psPAS-help.xml
function Get-PASApplication {
	[CmdletBinding(DefaultParameterSetName = 'byQuery')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'byAppID'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'byQuery'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$AppID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = 'byAppID'
		)]
		[switch]$ExactMatch,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'byQuery'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$Location,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'byQuery'
		)]
		[boolean]$IncludeSublocations
	)

	BEGIN { }#begin

	PROCESS {

		#Base URL for Request
		$URI = "$($psPASSession.BaseURI)/WebServices/PIMServices.svc/Applications"

		#If AppID specified
		If ($($PSCmdlet.ParameterSetName) -eq 'byAppID') {

			#Build URL from base URL
			$URI = "$URI/$($AppID | Get-EscapedString)/"

		}

		#If search query specified
		ElseIf ($($PSCmdlet.ParameterSetName) -eq 'byQuery') {

			#Get Parameters to include in request
			$boundParameters = $PSBoundParameters | Get-PASParameter

			#Create query string
			$queryString = $boundParameters | ConvertTo-QueryString

			if ($null -ne $queryString) {

				#Build URL from base URL
				$URI = "$URI`?$queryString"

			}

		}

		#Send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		If ($null -ne $result) {

			#Return results
			$result.application | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Application

		}

	}#process

	END { }#end

}