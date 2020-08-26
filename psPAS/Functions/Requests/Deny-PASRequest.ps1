# .ExternalHelp psPAS-help.xml
function Deny-PASRequest {
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
		$URI = "$Script:BaseURI/API/IncomingRequests/$($RequestID)/Reject"

		#Create body of request
		$body = $PSBoundParameters | Get-PASParameter -ParametersToRemove RequestId | ConvertTo-Json

		if ($PSCmdlet.ShouldProcess($RequestId, "Reject Request for Account Access")) {

			#send request to PAS web service
			Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -WebSession $Script:WebSession

		}

	}#process

	END { }#end

}