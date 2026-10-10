# .ExternalHelp psPAS-help.xml
function Export-PASPlatform {
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'PlatformID'
		)]
		[string]$PlatformID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'RotationalGroupID'
		)]
		[string]$RotationalGroupID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'DependentID'
		)]
		[int]$DependentID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'GroupPlatformID'
		)]
		[string]$GroupPlatformID,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'PlatformID'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'RotationalGroupID'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'DependentID'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'GroupPlatformID'
		)]
		[ValidateScript( { Test-Path -Path $_ -IsValid })]
		[string]$path
	)

	begin {
		Assert-VersionRequirement -RequiredVersion 10.4
	}#begin

	process {

		switch ($PSCmdlet.ParameterSetName) {

			'PlatformID' {

				#Create URL for request
				$URI = "$($psPASSession.BaseURI)/API/Platforms/$PlatformID/Export?platformID=$PlatformID"

			}

			'RotationalGroupID' {

				#Create URL for request
				$URI = "$($psPASSession.BaseURI)/api/Platforms/RotationalGroups/$RotationalGroupID/Export"

			}

			'DependentID' {

				#Create URL for request
				$URI = "$($psPASSession.BaseURI)/api/Platforms/Dependents/$DependentID/Export"

			}

			'GroupPlatformID' {

				#Not sure when this API was added....
				Assert-VersionRequirement -RequiredVersion 12.2

				#Create URL for request
				$URI = "$($psPASSession.BaseURI)/API/Platforms/Groups/$GroupPlatformID/Export"

				break

			}

		}

		if ($PSCmdlet.ShouldProcess($PlatformID, 'Exports Platform Package')) {

			#send request to web service
			$result = Invoke-PASRestMethod -Uri $URI -Method POST -Debug:$false

			#if we get a platform byte array
			if ($null -ne $result) {

				Out-PASFile -InputObject $result -Path $path

			}

		}

	}#process

	end { }#end

}