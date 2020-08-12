Function Get-PASSAMLResponse {
	<#
.SYNOPSIS
Get SAML Token for PAS SAML Auth

.DESCRIPTION
Get SAML Token from pvwa webresponse

.PARAMETER URL
The PVWA URL

.EXAMPLE
Get-PASSAMLResponse -URL "https://pvwa.somecompany.com/PasswordVault"

.NOTES
https://gist.github.com/infamousjoeg/b44faa299ec3de65bdd1d3b8474b0649
#>
	[CmdletBinding()]
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

			$WebResponse = Invoke-WebRequest -Uri "$URL/auth/saml/" -MaximumRedirection 0 -ErrorAction SilentlyContinue -UseBasicParsing

			$SAMLResponse = Invoke-WebRequest -Uri ($WebResponse.links.href) -MaximumRedirection 1 -UseDefaultCredentials -UseBasicParsing

			If ($SAMLResponse.InputFields[0].name -eq "SAMLResponse") {
				$SAMLResponse.InputFields[0].value
			}
			Else { Throw }

		}

		Catch { Throw "Failed to get SAMLResponse" }
	}
}