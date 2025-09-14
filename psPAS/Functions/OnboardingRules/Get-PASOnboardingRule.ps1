# .ExternalHelp psPAS-help.xml
function Get-PASOnboardingRule {
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Names'
		)]
		[ValidateNotNullOrEmpty()]
		[string]$Names
	)

	begin {

	}#begin

	process {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/api/AutomaticOnboardingRules"

		if ($PSBoundParameters.ContainsKey('Names')) {

			Assert-VersionRequirement -RequiredVersion 10.2

			#Get Parameters to include in request
			$boundParameters = $PSBoundParameters | Get-PASParameter

			#Create Query String, escaped for inclusion in request URL
			#!This must be unescaped - send a comma separated string for the value of `Names`
			$queryString = $boundParameters | ConvertTo-QueryString -NoEscape

			if ($null -ne $queryString) {

				#Build URL from base URL
				$URI = "$URI`?$queryString"

			}

		}

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		if ($null -ne $result) {

			$result.AutomaticOnboardingRules | Add-ObjectDetail -typename psPAS.CyberArk.Vault.OnboardingRule

		}

	}#process

	end { }#end

}