function Close-PASSession {
	<#
	.SYNOPSIS
	Logoff from CyberArk Vault.

	.DESCRIPTION
	Performs Logoff and removes the Vault session.

	.PARAMETER UseClassicAPI
	Specify the UseClassicAPI switch to send the logoff request via the Classic (v9) API endpoint.
	Relevant for CyberArk versions earlier than 10.4

	.PARAMETER SharedAuthentication
	Specify the SharedAuthentication switch to logoff from a shared authentication session

	.PARAMETER SAMLAuthentication
	Specify the SAMLAuthentication switch to logoff from a session authenticated to with SAML

	.EXAMPLE
	Close-PASSession

	Logs off from the session related to the authorisation token.

	.EXAMPLE
	Close-PASSession -SAMLAuthentication

	Logs off from the session related to the authorisation token using the SAML Authentication API endpoint.

	.EXAMPLE
	Close-PASSession -SharedAuthentication

	Logs off from the session related to the authorisation token using the Shared Authentication API endpoint.

	.EXAMPLE
	Close-PASSession -UseClassicAPI

	Logs off from the session related to the authorisation token using the Classic API endpoint.

	#>
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