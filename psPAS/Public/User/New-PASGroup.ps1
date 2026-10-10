# .ExternalHelp psPAS-help.xml
function New-PASGroup {
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateLength(1, 128)]
		[string]$groupName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateLength(1, 100)]
		[string]$description,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateLength(1, 128)]
		[string]$location
	)

	begin {
		Assert-VersionRequirement -RequiredVersion 11.1
	}#begin

	process {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/API/UserGroups"

		#Construct Request Body
		$Body = $PSBoundParameters | Get-PASParameter | ConvertTo-Json

		if ($PSCmdlet.ShouldProcess($groupName, 'Create Group')) {

			#send request to web service
			$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body

		}

		if ($null -ne $result) {

			$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Group

		}

	}#process

	end { }#end

}