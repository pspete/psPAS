# .ExternalHelp psPAS-help.xml
Function Set-PASOpenIDConnectProvider {

	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateLength(1, 50)]
		[ValidateNotNullOrEmpty()]
		[string]$id,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet('Code', 'Implicit')]
		[ValidateNotNullOrEmpty()]
		[string]$authenticationFlow,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$authenticationEndpointUrl,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$issuer,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateLength(1, 255)]
		[ValidateNotNullOrEmpty()]
		[string]$description,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$discoveryEndpointUrl,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$jwkSet,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateLength(1, 100)]
		[ValidateNotNullOrEmpty()]
		[string]$clientId,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[securestring]$clientSecret,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet('Basic', 'Post')]
		[ValidateLength(1, 50)]
		[ValidateNotNullOrEmpty()]
		[string]$clientSecretMethod,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidatePattern('^[A-Za-z_]+$')]
		[ValidateLength(1, 50)]
		[ValidateNotNullOrEmpty()]
		[string]$userNameClaim

	)

	BEGIN {

		Assert-VersionRequirement -RequiredVersion 11.7

	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/api/Configuration/OIDC/Providers/$($id | Get-EscapedString)"

		#Get request parameters
		$boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove id

		#deal with clientSecret SecureString
		If ($PSBoundParameters.ContainsKey('clientSecret')) {

			#Include decoded clientSecret in request
			$boundParameters['clientSecret'] = $(ConvertTo-InsecureString -SecureString $clientSecret)

		}

		$OIDCProvider = Get-PASOpenIDConnectProvider -id $id
		if ($null -ne $OIDCProvider) {
			Format-PutRequestObject -InputObject $OIDCProvider -boundParameters $BoundParameters -ParametersToRemove id
		}

		#Create body of request
		$body = $boundParameters | ConvertTo-Json

		if ($PSCmdlet.ShouldProcess($id, 'Update OIDC Provider')) {

			#send request to web service
			$result = Invoke-PASRestMethod -Uri $URI -Method PUT -Body $body

			If ($null -ne $result) {

				$result

			}

		}

	}#process

	END { }#end

}