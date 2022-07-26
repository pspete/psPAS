# .ExternalHelp psPAS-help.xml
function Remove-PASPolicyACL {
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$PolicyID,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$Id

	)

	BEGIN { }#begin

	PROCESS {

		#Create base URL for request
		$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Policy/$($PolicyID |

            Get-EscapedString)/PrivilegedCommands/$($Id | Get-EscapedString)/"

		if ($PSCmdlet.ShouldProcess($PolicyID, "Delete Rule $Id")) {

			#send request to web service
			Invoke-PASRestMethod -Uri $URI -Method DELETE -WebSession $Script:WebSession

		}

	}#process

	END { }#end

}