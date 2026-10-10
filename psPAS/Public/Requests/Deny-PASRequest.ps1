# .ExternalHelp psPAS-help.xml
function Deny-PASRequest {
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

	begin {
		Assert-VersionRequirement -RequiredVersion 9.10

		# Variable to track if we are doing bulk confirmation
		$BulkConfirmation = $false

		$boundInput = $PSBoundParameters['RequestId']

		if (Test-IsMultiValue -Value $boundInput) {

			#Bulk Confirmations supported from 14.6
			Assert-VersionRequirement -RequiredVersion 14.6

			$BulkConfirmation = $true
		}

	}#begin

	process {

		#URL for Request
		$URI = "$($psPASSession.BaseURI)/API/IncomingRequests"

		if ($BulkConfirmation) {

			# Branch logic for bulk confirmation
			$URI = "$URI/Reject/Bulk"

			#Create body of request
			$Body = @{'BulkItems' = [System.Collections.Generic.List[object]]::new() }
			$RequestId | ForEach-Object {
				$Body.BulkItems.Add(
					@{
						RequestId = $PSItem
						Reason    = $Reason
					}
				)
			}

		} else {

			# Branch logic for single confirmation
			$URI = "$URI/$($boundInput)/Reject"

			#Create body of request
			$Body = $PSBoundParameters | Get-PASParameter -ParametersToRemove RequestId

		}

		#Format body as JSON
		$Body = $Body | ConvertTo-Json

		if ($PSCmdlet.ShouldProcess($RequestId, 'Reject Request for Account Access')) {

			#send request to PAS web service
			Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body

		}

	}#process

	end { }#end

}