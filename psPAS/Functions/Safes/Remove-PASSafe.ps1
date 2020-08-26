# .ExternalHelp psPAS-help.xml
function Remove-PASSafe {
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$SafeName

	)

	BEGIN { }#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Safes/$($SafeName |

            Get-EscapedString)"

		if ($PSCmdlet.ShouldProcess($SafeName, "Delete Safe")) {

			#Send request to web service
			Invoke-PASRestMethod -Uri $URI -Method DELETE -WebSession $Script:WebSession

		}

	}#process

	END { }#end
}