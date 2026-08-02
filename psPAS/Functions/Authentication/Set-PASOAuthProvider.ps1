# .ExternalHelp psPAS-help.xml
function Set-PASOAuthProvider {

	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
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
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[psobject[]]$allowedUsers,

		[parameter(
			Mandatory = $false,
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
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[psobject]$clientCredentials,

		[parameter(
			Mandatory = $false,
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
		$URI = "$($psPASSession.BaseURI)/api/Configuration/OAuth/Providers/$($id | Get-EscapedString)"

		#Get request parameters
		$boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove id

		#Get current provider configuration to merge any properties not supplied in the request
		$OAuthProvider = Get-PASOAuthProvider | Where-Object { $_.id -eq $id }
		if ($null -ne $OAuthProvider) {
			$OAuthProvider.psobject.Properties | Where-Object {
				$PSItem.Name -ne 'id' -and -not $boundParameters.ContainsKey($PSItem.Name)
			} | ForEach-Object {
				$boundParameters[$PSItem.Name] = $PSItem.Value
			}
		}

		#Create body of request
		#Send as raw UTF8 bytes rather than a String so ParameterBinding/module logging of this
		#call records a non-revealing type name instead of the literal request content.
		$body = [System.Text.Encoding]::UTF8.GetBytes($($boundParameters | ConvertTo-Json -Depth 5))

		if ($PSCmdlet.ShouldProcess($id, 'Update OAuth Provider')) {

			#send request to web service
			$result = Invoke-PASRestMethod -Uri $URI -Method PUT -Body $body

			if ($null -ne $result) {

				$result

			}

		}

	}#process

	end { }#end

}
