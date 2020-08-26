# .ExternalHelp psPAS-help.xml
function Add-PASSafe {
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[ValidateScript( { $_ -notmatch ".*(\\|\/|:|\*|<|>|`"|\.|\||^\s).*" })]
		[ValidateLength(0, 28)]
		[string]$SafeName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateLength(0, 100)]
		[string]$Description,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$OLACEnabled,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$ManagingCPM,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "Versions"
		)]
		[ValidateRange(1, 999)]
		[int]$NumberOfVersionsRetention,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "Days"
		)]
		[ValidateRange(1, 3650)]
		[int]$NumberOfDaysRetention
	)

	BEGIN { }#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Safes"

		#create request body
		$body = @{

			#add parameters to safe node
			"safe" = $PSBoundParameters | Get-PASParameter

		} | ConvertTo-Json

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -WebSession $Script:WebSession


		If ($null -ne $result) {

			$result.AddSafeResult | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Safe

		}

	}#process

	END { }#end

}