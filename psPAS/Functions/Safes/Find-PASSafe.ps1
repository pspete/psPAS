# .ExternalHelp psPAS-help.xml
function Find-PASSafe {
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false
		)]
		[string]$search,

		[parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $false
		)]
		[int]$TimeoutSec

	)

	BEGIN {

		Assert-VersionRequirement -RequiredVersion 10.1 -MaximumVersion 11.7

		#Create base URL for request
		$URI = "$Script:BaseURI/api/Safes"
		$SearchQuery = $null
		$Limit = 25   #default if you call the API with no value

	}#begin

	PROCESS {

		If ( -Not [string]::IsNullOrEmpty($search) ) {

			$SearchQuery = "&$($PSBoundParameters | Get-PASParameter | ConvertTo-QueryString)"

		}

		$InitialResponse = Invoke-PASRestMethod -Uri "$URI`?limit=$Limit$SearchQuery" -Method GET -WebSession $Script:WebSession -TimeoutSec $TimeoutSec

		$Total = $InitialResponse.Total

		If ($Total -gt 0) {

			$Safes = [Collections.Generic.List[Object]]::New(($InitialResponse.Safes))

			For ( $Offset = $Limit ; $Offset -lt $Total ; $Offset += $Limit ) {

				$Null = $Safes.AddRange((Invoke-PASRestMethod -Uri "$URI`?limit=$Limit&OffSet=$Offset$searchQuery" -Method GET -WebSession $Script:WebSession -TimeoutSec $TimeoutSec).Safes)

			}

			$Safes

		}

	}#process

	END { }#end

}