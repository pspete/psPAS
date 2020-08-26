# .ExternalHelp psPAS-help.xml
function Get-PASUser {
	[CmdletBinding(DefaultParameterSetName = "10.9")]
	param(

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10.10"
		)]
		[int]$id,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10.9"
		)]
		[string]$Search,


		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10.9"
		)]
		[string]$UserType,


		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "10.9"
		)]
		[boolean]$ComponentUser,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "legacy"
		)]
		[string]$UserName
	)

	BEGIN {
		If ($PSCmdlet.ParameterSetName -ne "legacy") {
			Assert-VersionRequirement -RequiredVersion $PSCmdlet.ParameterSetName
		}
	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/api/Users"

		switch ($PSCmdlet.ParameterSetName) {

			"10.10" {

				#Create URL for request
				$URI = "$URI/$id"

				break;

			}

			"10.9" {

				#Get Parameters to include in request
				$boundParameters = $PSBoundParameters | Get-PASParameter

				#Create Query String, escaped for inclusion in request URL
				$queryString = $boundParameters | ConvertTo-QueryString

				if ($null -ne $queryString) {

					#Build URL from base URL
					$URI = "$URI`?$queryString"

				}

				break;

			}

			"legacy" {

				#Create URL for request
				$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Users/$($UserName | Get-EscapedString)"

				$TypeName = "psPAS.CyberArk.Vault.User"

				break;

			}

		}

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		#Handle return
		if ($PSCmdlet.ParameterSetName -match "^10\.") {

			#All "V10" operations have the same output type
			$TypeName = "psPAS.CyberArk.Vault.User.Extended"

			#User search will return an object with a Total property
			If ($result.Total -ge 1) {

				#Return only users property if Total indicates results
				$result = $result.Users

			}
			ElseIf ($result.Total -eq 0) {

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