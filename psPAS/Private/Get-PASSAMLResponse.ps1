function Get-PASSAMLResponse {
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

	process {

		try {

			$Uri = "$URL/auth/saml/"

			if ($PSCmdlet.ShouldProcess($Uri, 'SAML Auth')) {

				#If Tls12 Security Protocol is available
				if (([Net.SecurityProtocolType].GetEnumNames() -contains 'Tls12') -and

					#And Tls12 is not already in use
					(-not ([System.Net.ServicePointManager]::SecurityProtocol -match 'Tls12'))) {

					[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

				}

				$Request = @{}

				#Use TLS 1.2
				if (Test-IsCoreCLR) {

					$Request.Add('SslProtocol', 'TLS12')

				}
				$Request['Uri'] = $Uri
				$Request['MaximumRedirection'] = 0
				$Request['ErrorAction'] = 'SilentlyContinue'
				$Request['UseBasicParsing'] = $true

				$WebResponse = Invoke-WebRequest @Request

				$Request = @{}

				#Use TLS 1.2
				if (Test-IsCoreCLR) {

					$Request.Add('SslProtocol', 'TLS12')

				}
				$Request['Uri'] = $($WebResponse.links.href)
				$Request['MaximumRedirection'] = 1
				$Request['UseDefaultCredentials'] = $true
				$Request['UseBasicParsing'] = $true

				$SAMLResponse = Invoke-WebRequest @Request

				if ($SAMLResponse.InputFields[0].name -eq 'SAMLResponse') {

					$SAMLResponse.InputFields[0].value

				} else { throw }

			}

		}

		catch { throw 'Failed to get SAMLResponse' }

	}

}