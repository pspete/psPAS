# .ExternalHelp psPAS-help.xml
function Get-PASDiscoveryScan {
	[CmdletBinding(DefaultParameterSetName = 'byQuery')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'byID'
		)]
		[Alias('id')]
		[int]$taskId
	)

	begin {

		Assert-VersionRequirement -SelfHosted
		Assert-VersionRequirement -RequiredVersion 12.2

	}#begin

	process {

		#Create URL for Request
		$URI = "$($psPASSession.BaseURI)/api/DiscoveryScans"

		switch ($PSCmdlet.ParameterSetName) {

			'byID' {

				$URI = "$URI/$($taskId | Get-EscapedString)"

				break

			}

		}

		#Send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		if ($null -ne $result) {

			$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.DiscoveryScan

		}

	}#process

	end { }#end

}
