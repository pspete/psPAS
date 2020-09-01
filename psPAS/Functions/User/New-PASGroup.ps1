# .ExternalHelp psPAS-help.xml
function New-PASGroup {
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$groupName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$description,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$location
	)

	BEGIN {
		Assert-VersionRequirement -RequiredVersion 11.1
	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/API/UserGroups"

		#Construct Request Body
		$Body = $PSBoundParameters | Get-PASParameter | ConvertTo-Json

		if ($PSCmdlet.ShouldProcess($groupName, "Create Group")) {

			#send request to web service
			$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -WebSession $Script:WebSession

		}

		If ($null -ne $result) {

			$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Group

		}

	}#process

	END { }#end

}