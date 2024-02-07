# .ExternalHelp psPAS-help.xml
function Remove-PASApplicationAuthenticationMethod {
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$AppID,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$AuthID
	)

	BEGIN { }#begin

	PROCESS {

		#request URL
		$URI = "$($psPASSession.BaseURI)/WebServices/PIMServices.svc/Applications/$($AppID |

            Get-EscapedString)/Authentications/$($AuthID | Get-EscapedString)"

		if ($PSCmdlet.ShouldProcess($AppID, "Delete Authentication Method '$AuthID'")) {

			#Send Request
			Invoke-PASRestMethod -Uri $URI -Method DELETE

		}

	}#process

	END { }#end

}