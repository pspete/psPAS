# .ExternalHelp psPAS-help.xml
function Get-PASRequest {
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[ValidateSet('MyRequests', 'IncomingRequests')]
		[string]$RequestType,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$OnlyWaiting,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$Expired
	)

	BEGIN {
		Assert-VersionRequirement -RequiredVersion 9.10
	}#begin

	PROCESS {

		$QueryString = $PSBoundParameters | Get-PASParameter -ParametersToRemove RequestType | ConvertTo-QueryString

		#Create URL for Request
		$URI = "$Script:BaseURI/API/$($RequestType)?$QueryString"

		#send request to PAS web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		If ($null -ne $result) {

			#Return Results
			$result.$RequestType | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Request.Details

		}

	}#process

	END { }#end

}