# .ExternalHelp psPAS-help.xml
function Approve-PASRequest {
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string[]]$RequestId,

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

		#URL for Request
		$URI = "$($psPASSession.BaseURI)/API/IncomingRequests/"

		Test-IsMultiValue -Input $RequestId

		if ($?) {

			#Bulk Confirmations supported from 14.6
			Assert-VersionRequirement -RequiredVersion 14.6

			#Create URL for Bulk Request Confirmation
			$URI = "$URI/Confirm/Bulk"

			#Create body of request
			$Body = @{"BulkItems" = [System.Collections.Generic.List[object]]::new()}
			$RequestId | ForEach-Object {
				$Body.BulkItems.Add(
					@{
						RequestId = $PSItem
						Reason   = $Reason
					}
				)
			}

		} Else{

			#Create URL for Single Request Confirmation
			$URI = "$URI/$($RequestID)/Confirm"

			#Create body of request
			$Body = $PSBoundParameters | Get-PASParameter -ParametersToRemove RequestId

		}

		#Format body as JSON
		$Body = $Body | ConvertTo-Json

		if ($PSCmdlet.ShouldProcess($RequestId, 'Confirm Request for Account Access')) {

			#send request to PAS web service
			Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body

		}

	}#process

	END { }#end

}