# .ExternalHelp psPAS-help.xml
function Approve-PASRequest {
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$RequestId,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$Reason
	)

	BEGIN {
		Assert-VersionRequirement -RequiredVersion 9.10
	}#begin

	PROCESS {

		#Create URL for Request
		$URI = "$($psPASSession.BaseURI)/API/IncomingRequests/$($RequestID)/Confirm"

		#Create body of request
		$body = $PSBoundParameters | Get-PASParameter -ParametersToRemove RequestId | ConvertTo-Json

		if ($PSCmdlet.ShouldProcess($RequestId, 'Confirm Request for Account Access')) {

			#send request to PAS web service
			Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body

		}

	}#process

	END { }#end

}