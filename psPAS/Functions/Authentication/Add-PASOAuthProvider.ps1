# .ExternalHelp psPAS-help.xml
function Add-PASOAuthProvider {
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateLength(1, 50)]
		[ValidatePattern('^[a-zA-Z0-9]+$')]
		[string]$id,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet(1, 2)]
		[int]$accessTokenValidationMode,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateLength(0, 2048)]
		[string]$introspectionUrl,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateLength(0, 2048)]
		[string]$issuerUrl,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateLength(0, 8192)]
		[string]$publicKey,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet(1, 2)]
		[int]$signatureValidationMode,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[psobject[]]$allowedUsers,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateLength(0, 2048)]
		[string]$audience,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateLength(0, 2048)]
		[string]$jwksUrl,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[psobject]$clientCredentials,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateLength(0, 32)]
		[string]$clientIdClaimType
	)

	begin {

		Assert-VersionRequirement -SelfHosted
		Assert-VersionRequirement -RequiredVersion 15.0

	}#begin

	process {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/api/Configuration/OAuth/Providers"

		#Get request parameters
		$boundParameters = $PSBoundParameters | Get-PASParameter

		#Create body of request
		#Send as raw UTF8 bytes rather than a String so ParameterBinding/module logging of this
		#call records a non-revealing type name instead of the literal request content.
		$body = [System.Text.Encoding]::UTF8.GetBytes($($boundParameters | ConvertTo-Json -Depth 5))

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $body

		if ($null -ne $result) {

			$result | Add-ObjectDetail -TypeName psPAS.CyberArk.Vault.OAuthProvider

		}

	}#process

	end { }#end

}
