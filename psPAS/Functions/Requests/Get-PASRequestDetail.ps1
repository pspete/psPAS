# .ExternalHelp psPAS-help.xml
function Get-PASRequestDetail {
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
		[string]$RequestID
	)

	begin {
		Assert-VersionRequirement -RequiredVersion 9.10
	}#begin

	process {

		#Create URL for Request
		$URI = "$($psPASSession.BaseURI)/API/$($RequestType)/$($RequestID)"

		#send request to PAS web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		if ($null -ne $result) {

			#Return Results
			$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Request.Extended

		}

	}#process

	end { }#end

}