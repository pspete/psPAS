# .ExternalHelp psPAS-help.xml
function Close-PASSession {
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', 'UseGen1API', Justification = 'False Positive')]
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', 'SharedAuthentication', Justification = 'False Positive')]
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', 'SAMLAuthentication', Justification = 'False Positive')]
	[CmdletBinding(DefaultParameterSetName = 'Gen2')]
	param(

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = 'Gen1'
		)]
		[Alias('UseClassicAPI')]
		[switch]$UseGen1API,

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'shared'
		)]
		[switch]$SharedAuthentication,

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'saml'
		)]
		[switch]$SAMLAuthentication

	)

	BEGIN {

		Switch ($PSCmdlet.ParameterSetName) {

			'Gen1' {

				$URI = "$($psPASSession.BaseURI)/WebServices/auth/Cyberark/CyberArkAuthenticationService.svc/Logoff"
				break

			}

			'saml' {

				$URI = "$($psPASSession.BaseURI)/WebServices/auth/SAML/SAMLAuthenticationService.svc/Logoff"
				break

			}

			'shared' {

				Assert-VersionRequirement -SelfHosted

				$URI = "$($psPASSession.BaseURI)/WebServices/auth/Shared/RestfulAuthenticationService.svc/Logoff"
				break

			}

			'Gen2' {

				$URI = "$($psPASSession.BaseURI)/API/Auth/Logoff"
				break

			}

		}

	}#begin

	PROCESS {

		#Send Logoff Request
		Invoke-PASRestMethod -Uri $URI -Method POST | Out-Null

	}#process

	END {

		#Set ExternalVersion to 0.0
		$psPASSession.ExternalVersion = [System.Version]'0.0'

		#Clear Module scope variables on logoff
		$psPASSession.BaseURI = $null
		$psPASSession.ApiURI = $null
		$psPASSession.WebSession = $null
		$psPASSession.User = $null
		$psPASSession.StartTime = $null


	}#end
}