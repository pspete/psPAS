# .ExternalHelp psPAS-help.xml
function Close-PASSession {
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', 'UseClassicAPI', Justification = "False Positive")]
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', 'SharedAuthentication', Justification = "False Positive")]
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', 'SAMLAuthentication', Justification = "False Positive")]
	[CmdletBinding(DefaultParameterSetName = "V10")]
	param(

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "v9"
		)]
		[switch]$UseClassicAPI,

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "shared"
		)]
		[switch]$SharedAuthentication,

		[Parameter(
			Mandatory = $false,
			ValueFromPipeline = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "saml"
		)]
		[switch]$SAMLAuthentication

	)

	BEGIN {

		Switch ($PSCmdlet.ParameterSetName) {

			"v9" {

				$URI = "$Script:BaseURI/WebServices/auth/Cyberark/CyberArkAuthenticationService.svc/Logoff"
				break

			}

			"saml" {

				$URI = "$Script:BaseURI/WebServices/auth/SAML/SAMLAuthenticationService.svc/Logoff"
				break

			}

			"shared" {

				$URI = "$Script:BaseURI/WebServices/auth/Shared/RestfulAuthenticationService.svc/Logoff"
				break

			}

			"V10" {

				$URI = "$Script:BaseURI/API/Auth/Logoff"
				break

			}

		}

	}#begin

	PROCESS {

		#Send Logoff Request
		Invoke-PASRestMethod -Uri $URI -Method POST -WebSession $Script:WebSession | Out-Null

	}#process

	END {

		#Set ExternalVersion to 0.0
		[System.Version]$Version = "0.0"
		Set-Variable -Name ExternalVersion -Value $Version -Scope Script -ErrorAction SilentlyContinue

		#Clear Module scope variables on logoff
		Clear-Variable -Name BaseURI -Scope Script -ErrorAction SilentlyContinue
		Clear-Variable -Name WebSession -Scope Script -ErrorAction SilentlyContinue

	}#end
}