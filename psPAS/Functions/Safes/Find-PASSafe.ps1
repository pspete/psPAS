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

	begin {

		Assert-VersionRequirement -RequiredVersion 10.1 -MaximumVersion 11.7

		#Create base URL for request
		$URI = "$($psPASSession.BaseURI)/api/Safes"
		$SearchQuery = $null
		$Limit = 25   #default if you call the API with no value

	}#begin

	process {

		if ( -not [string]::IsNullOrEmpty($search) ) {

			$SearchQuery = "&$($PSBoundParameters | Get-PASParameter | ConvertTo-QueryString)"

		}

		$InitialResponse = Invoke-PASRestMethod -Uri "$URI`?limit=$Limit$SearchQuery" -Method GET -TimeoutSec $TimeoutSec

		$Total = $InitialResponse.Total

		if ($Total -gt 0) {

			$Safes = [Collections.Generic.List[Object]]::New(($InitialResponse.Safes))

			for ( $Offset = $Limit ; $Offset -lt $Total ; $Offset += $Limit ) {

				$Null = $Safes.AddRange((Invoke-PASRestMethod -Uri "$URI`?limit=$Limit&OffSet=$Offset$searchQuery" -Method GET -TimeoutSec $TimeoutSec).Safes)

			}

			$Safes

		}

	}#process

	end { }#end

}