# .ExternalHelp psPAS-help.xml
function Add-PASOpenIDConnectProvider {

	[CmdletBinding()]
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
			Mandatory = $true,
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
			Mandatory = $true,
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
			Mandatory = $true,
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

	begin {

		Assert-VersionRequirement -RequiredVersion 11.7

	}#begin

	process {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/api/Configuration/OIDC/Providers"

		#Get request parameters
		$boundParameters = $PSBoundParameters | Get-PASParameter

		#deal with clientSecret SecureString
		if ($PSBoundParameters.ContainsKey('clientSecret')) {

			#Include decoded clientSecret in request
			$boundParameters['clientSecret'] = $(ConvertTo-InsecureString -SecureString $clientSecret)

		}

		#Create body of request
		$body = $boundParameters | ConvertTo-Json

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $body

		if ($null -ne $result) {

			$result

		}

	}#process

	end { }#end

}