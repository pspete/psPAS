# .ExternalHelp psPAS-help.xml
function Add-PASUserAllowedAuthenticationMethod {
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

    Begin{
		Assert-VersionRequirement -RequiredVersion 14.6
	}

    Process{

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/API/Users/AddAllowedAuthenticationMethods/Bulk"

		$boundParameters = $PSBoundParameters | Get-PASParameter
		$body = @{'BulkItems' = @($boundParameters)} | ConvertTo-Json -Depth 4

		if ($PSCmdlet.ShouldProcess($($userIds -join ','), "Set Allowed Authentication Methods: $($allowedAuthenticationMethods -join ',')")) {

            #send request to web service
            $result = Invoke-PASRestMethod -Uri $URI -Method PATCH -Body $Body

			if ($null -ne $result) {

				$result

			}

        }

	}


    End{}

}