# .ExternalHelp psPAS-help.xml
function Remove-PASUserAllowedAuthenticationMethod {
	[CmdletBinding(SupportsShouldProcess = $true)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[int[]]$userIds,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string[]]$allowedAuthenticationMethods
	)

	begin {
		Assert-VersionRequirement -RequiredVersion 14.6
	}

	process {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/API/Users/RemoveAllowedAuthenticationMethods/Bulk"
		$boundParameters = $PSBoundParameters | Get-PASParameter
		$body = @{'BulkItems' = @($boundParameters) } | ConvertTo-Json -Depth 4

		if ($PSCmdlet.ShouldProcess($($userIds -join ','), "Remove Allowed Authentication Methods: $($allowedAuthenticationMethods -join ',')")) {

			#send request to web service
			$result = Invoke-PASRestMethod -Uri $URI -Method PATCH -Body $Body

			if ($null -ne $result) {
				$result
			}

		}

	}


	end {}

}