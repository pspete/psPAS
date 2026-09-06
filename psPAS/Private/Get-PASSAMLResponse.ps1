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

				#A SecurityProtocol of SystemDefault (0) lets Schannel negotiate the strongest
				#protocol both ends support and is left untouched. Only a process pinned to explicit
				#legacy protocols needs TLS 1.2 adding, combined with those already permitted.
				if (-not (Test-IsCoreCLR)) {

					$SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol

					if (([int]$SecurityProtocol -ne 0) -and
						([Net.SecurityProtocolType].GetEnumNames() -contains 'Tls12') -and
						(-not ($SecurityProtocol.HasFlag([Net.SecurityProtocolType]::Tls12)))) {

						[Net.ServicePointManager]::SecurityProtocol = $SecurityProtocol -bor [Net.SecurityProtocolType]::Tls12

					}

				}

				$Request = @{}

				$Request['Uri'] = $Uri
				$Request['MaximumRedirection'] = 0
				$Request['ErrorAction'] = 'SilentlyContinue'
				$Request['UseBasicParsing'] = $true

				$WebResponse = Invoke-WebRequest @Request

				$Request = @{}

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