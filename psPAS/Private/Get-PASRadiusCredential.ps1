function Get-PASRadiusCredential {
	<#
	.SYNOPSIS
	Returns the password and OTP values to send for RADIUS authentication

	.DESCRIPTION
	psPAS helper function.
	Returns the password value to include in the initial RADIUS logon request,
	and the OTP value to provide in response to any RADIUS challenge.

	OTPMode Append: OTP is appended to the password, separated by OTPDelimiter (comma by default).
	OTPMode Challenge with RadiusChallenge Password: OTP is sent in the initial request, password is sent as the challenge response.

	.PARAMETER Credential
	The logon credential.

	.PARAMETER OTP
	The One Time Passcode.

	.PARAMETER OTPMode
	Append or Challenge.

	.PARAMETER OTPDelimiter
	The character to use as a delimiter when appending the OTP to the password.

	.PARAMETER RadiusChallenge
	Whether the RADIUS challenge expects the Password or the OTP.

	.EXAMPLE
	Get-PASRadiusCredential -Credential $Cred -OTP 123456 -OTPMode Append

	Returns Password 'SomePassword,123456'
	#>
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true
		)]
		[PSCredential]$Credential,

		[parameter(
			Mandatory = $false
		)]
		[string]$OTP,

		[parameter(
			Mandatory = $false
		)]
		[ValidateSet('Append', 'Challenge')]
		[string]$OTPMode,

		[parameter(
			Mandatory = $false
		)]
		[AllowEmptyString()]
		[string]$OTPDelimiter = ',',

		[parameter(
			Mandatory = $false
		)]
		[ValidateSet('Password', 'OTP')]
		[string]$RadiusChallenge
	)

	process {

		$Password = $Credential.GetNetworkCredential().Password

		if ($PSBoundParameters.ContainsKey('OTP')) {

			switch ($OTPMode) {

				'Append' {

					$Password = "$Password$OTPDelimiter$OTP"
					break

				}

				'Challenge' {

					if ($RadiusChallenge -eq 'Password') {

						#Send OTP first, then Password as challenge response
						$Password, $OTP = $OTP, $Password

					}

				}

			}

		}

		[PSCustomObject]@{
			Password = $Password
			OTP      = $OTP
		}

	}

}
