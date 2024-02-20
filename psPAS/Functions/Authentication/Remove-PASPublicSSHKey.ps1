# .ExternalHelp psPAS-help.xml
function Remove-PASPublicSSHKey {
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateScript( { $_ -notmatch '.*(%|\&|\+).*' })]
		[string]$UserName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$KeyID

	)

	BEGIN { }#begin

	PROCESS {

		#Create URL string for request
		$URI = "$($psPASSession.BaseURI)/WebServices/PIMServices.svc/Users/$($UserName |

            Get-EscapedString)/AuthenticationMethods/SSHKeyAuthentication/AuthorizedKeys/$KeyID/"

		if ($PSCmdlet.ShouldProcess($KeyID, 'Delete Public SSH Key')) {

			#Send Request to web service
			Invoke-PASRestMethod -Uri $URI -Method DELETE

		}

	}#process

	END { }#end

}