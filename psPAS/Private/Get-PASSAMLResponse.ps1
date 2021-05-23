Function Get-PASSAMLResponse {
	<#
.SYNOPSIS
Get SAML Token for PAS SAML Auth

.DESCRIPTION
Get SAML IdP URl using a request the /auth/saml/ PVWA resource
Authenticates to IdP and to obtain Saml Token

.PARAMETER URL
The PVWA URL

.EXAMPLE
Get-PASSAMLResponse -URL "https://pvwa.somecompany.com/PasswordVault"

.NOTES
https://gist.github.com/infamousjoeg/b44faa299ec3de65bdd1d3b8474b0649
#>
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		$URL
	)

	Process {

		Try {

			$Uri = "$URL/auth/saml/"

			if ($PSCmdlet.ShouldProcess($Uri, 'SAML Auth')) {

				$WebResponse = Invoke-WebRequest -Uri $Uri -MaximumRedirection 0 -ErrorAction SilentlyContinue -UseBasicParsing

				$SAMLResponse = Invoke-WebRequest -Uri $($WebResponse.links.href) -MaximumRedirection 1 -UseDefaultCredentials -UseBasicParsing

				If ($SAMLResponse.InputFields[0].name -eq 'SAMLResponse') {

					$SAMLResponse.InputFields[0].value

				} Else { Throw }

			}

		}

		Catch { Throw 'Failed to get SAMLResponse' }

	}

}