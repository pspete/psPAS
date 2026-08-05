# .ExternalHelp psPAS-help.xml
function Find-PASSafe {
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false
		)]
		[ValidateLength(1, 500)]
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

		$RequestUri = "$URI`?limit=$Limit$SearchQuery"

		$InitialResponse = Invoke-PASRestMethod -Uri $RequestUri -Method GET -TimeoutSec $TimeoutSec

		if ($null -ne $InitialResponse) {

			#API only provides a Total value; page via Get-NextLink's offset support
			$InitialResponse | Get-NextLink -RequestUri $RequestUri -TimeoutSec $TimeoutSec

		}

	}#process

	end { }#end

}