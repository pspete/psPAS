# .ExternalHelp psPAS-help.xml
function Get-PASUser {
	[CmdletBinding(DefaultParameterSetName = 'Gen2')]
	param(

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2ID'
		)]
		[int]$id,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2-ExtendedDetails'
		)]
		[string]$Search,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2-ExtendedDetails'
		)]
		[string]$UserType,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2-ExtendedDetails'
		)]
		[ValidateSet('Active', 'Disabled', 'Suspended')]
		[string]$UserStatus,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2-ExtendedDetails'
		)]
		[ValidateSet('CyberArk', 'LDAP')]
		[string]$source,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2-ExtendedDetails'
		)]
		[boolean]$ComponentUser,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2-ExtendedDetails'
		)]
		[string[]]$sort,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2-ExtendedDetails'
		)]
		[boolean]$ExtendedDetails,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2-ExtendedDetails'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[string]$UserName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = 'Gen1'
		)]
		[switch]$UseGen1API
	)

	BEGIN { }#begin

	PROCESS {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/api/Users"

		switch ($PSCmdlet.ParameterSetName) {

			'Gen2ID' {

				Assert-VersionRequirement -RequiredVersion 10.10

				#Create URL for request
				$URI = "$URI/$id"

				break

			}

			'Gen2-ExtendedDetails' {

				Assert-VersionRequirement -RequiredVersion 12.1

			}

			( { $PSItem -match '^Gen2' } ) {

				switch ($PSBoundParameters.Keys) {

					{ $_ -match 'UserName|sort' } {

						#Gen2 UserName & Sort parameters require 12.2
						Assert-VersionRequirement -RequiredVersion 12.2

					}

					{ $_ -match 'UserStatus|source' } {

						#Gen2 UserName & Sort parameters require 13.2
						Assert-VersionRequirement -RequiredVersion 13.2

					}

				}

				Assert-VersionRequirement -RequiredVersion 10.9

				#Get Parameters to include in request
				$boundParameters = $PSBoundParameters | Get-PASParameter

				#Create Query String, escaped for inclusion in request URL
				$queryString = $boundParameters | ConvertTo-QueryString

				if ($null -ne $queryString) {

					#Build URL from base URL
					$URI = "$URI`?$queryString"

				}

				break

			}

			'Gen1' {

				Assert-VersionRequirement -MaximumVersion 12.3

				#Create URL for request
				$URI = "$($psPASSession.BaseURI)/WebServices/PIMServices.svc/Users/$($UserName | Get-EscapedString)"

				$TypeName = 'psPAS.CyberArk.Vault.User'

				break

			}

		}

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		#Handle return
		if ($PSCmdlet.ParameterSetName -match 'Gen2') {

			#All "V10" operations have the same output type
			$TypeName = 'psPAS.CyberArk.Vault.User.Extended'

			#User search will return an object with a Total property
			If ($result.Total -ge 1) {

				#Return only users property if Total indicates results
				$result = $result.Users

			} ElseIf ($result.Total -eq 0) {

				#Total indicates no results, return null
				$result = $null

			}

		}

		If ($null -ne $result) {

			$result | Add-ObjectDetail -typename $TypeName

		}

	}#process

	END { }#end

}