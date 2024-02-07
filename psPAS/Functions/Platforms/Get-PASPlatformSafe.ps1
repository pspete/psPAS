# .ExternalHelp psPAS-help.xml
function Get-PASPlatformSafe {
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$PlatformID
	)

	BEGIN {
		Assert-VersionRequirement -RequiredVersion 11.1
	}#begin

	PROCESS {

		#Create request URL
		$URI = "$($psPASSession.BaseURI)/API/Platforms/$($PlatformID | Get-EscapedString)/Safes/"

		#Send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		If ($result.count -gt 0) {

			#Return Results
			$result.value | ForEach-Object { [pscustomobject]@{'SafeName' = $PSItem } }

		}

	}#process

	END { }#end

}