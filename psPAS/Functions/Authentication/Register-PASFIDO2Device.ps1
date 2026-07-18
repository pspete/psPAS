# .ExternalHelp psPAS-help.xml
function Register-PASFIDO2Device {

	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', 'OwnDevice', Justification = 'False Positive')]
	[CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'Default')]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Default'
		)]
		[int]$UserId,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'OwnDevice'
		)]
		[switch]$OwnDevice
	)

	begin {

		Assert-VersionRequirement -SelfHosted
		Assert-VersionRequirement -RequiredVersion 14.6

	}#begin

	process {

		switch ($PSCmdlet.ParameterSetName) {

			'OwnDevice' {

				#URL for current user's own registration
				#Note: docs show /api/fido2/registrationOptions for self-start, but that endpoint
				#validates UserId >= 1. The actual self-start endpoint mirrors the selfX naming
				#convention used elsewhere (selfKeys, selfRegistration).
				$optionsURI = "$($psPASSession.BaseURI)/api/fido2/selfRegistrationOptions"
				$registerURI = "$($psPASSession.BaseURI)/api/fido2/selfRegistration"

				#Self-start endpoint takes no documented body fields, but the server still
				#expects a JSON object payload (else: PASWS011E Missing mandatory parameter [request])
				$optionsBody = '{}'
				$shouldProcessTarget = 'Current User'
				$shouldProcessMessage = 'Register Own FIDO2 Device'

				break

			}

			default {

				#URL for admin-initiated registration on behalf of another user
				$optionsURI = "$($psPASSession.BaseURI)/api/fido2/registrationOptions"
				$registerURI = "$($psPASSession.BaseURI)/api/fido2/registration"

				$optionsBody = @{}
				if ($PSBoundParameters.ContainsKey('UserId')) {
					$optionsBody['UserId'] = $UserId
				}
				$optionsBody = $optionsBody | ConvertTo-Json

				$shouldProcessTarget = if ($PSBoundParameters.ContainsKey('UserId')) { "UserId $UserId" } else { 'Current User' }
				$shouldProcessMessage = 'Register FIDO2 Device'

			}

		}

		#1. Request registration options
		$optionsResponse = Invoke-PASRestMethod -Uri $optionsURI -Method POST -Body $optionsBody

		if ($null -eq $optionsResponse.createCredentialOptions) {
			throw 'No createCredentialOptions returned from /api/fido2/registrationOptions'
		}

		#2. Run WebAuthn MakeCredential ceremony locally against the FIDO2 authenticator
		$attestation = Invoke-FIDO2MakeCredential -Options $optionsResponse.createCredentialOptions

		#3. Submit attestation to register the new device
		$registerBody = [ordered]@{
			Attestation = [ordered]@{
				Id         = $attestation.CredentialId
				Type       = 'public-key'
				Response   = [ordered]@{
					AttestationObject = $attestation.AttestationObject
					ClientDataJson    = $attestation.ClientDataJson
				}
				Extensions = @{}
			}
		}

		#UserId only applies to the admin (Default) endpoint
		if ($PSCmdlet.ParameterSetName -eq 'Default' -and $PSBoundParameters.ContainsKey('UserId')) {
			$registerBody['UserId'] = $UserId
		}

		if ($PSCmdlet.ShouldProcess($shouldProcessTarget, $shouldProcessMessage)) {

			Invoke-PASRestMethod -Uri $registerURI -Method POST -Body ($registerBody | ConvertTo-Json -Depth 5)

		}

	}#process

	end { }#end

}
