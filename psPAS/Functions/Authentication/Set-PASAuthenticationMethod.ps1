# .ExternalHelp psPAS-help.xml
Function Set-PASAuthenticationMethod {
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '', Justification = 'passwordFieldLabel not related to password value')]
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUsernameAndPasswordParams', '', Justification = 'usernameFieldLabel & passwordFieldLabel not related to password value')]
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateLength(1, 50)]
		[string]$ID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateLength(0, 50)]
		[string]$displayName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$enabled,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$mobileEnabled,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$logoffUrl,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet('cyberark', 'radius', 'ldap')]
		[string]$secondFactorAuth,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateLength(0, 100)]
		[string]$signInLabel,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateLength(0, 50)]
		[string]$usernameFieldLabel,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateLength(0, 50)]
		[string]$passwordFieldLabel
	)

	BEGIN {

		Assert-VersionRequirement -RequiredVersion 11.5

	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/api/Configuration/AuthenticationMethods/$($ID | Get-EscapedString)"

		#Request body
		$Body = $PSBoundParameters | Get-PASParameter -ParametersToRemove ID | ConvertTo-Json

		if ($PSCmdlet.ShouldProcess($ID, 'Update Authentication Method')) {

			#send request to web service
			$result = Invoke-PASRestMethod -Uri $URI -Method PUT -Body $Body

		}

		If ($null -ne $result) {

			$result

		}

	}#process

	END { }#end

}