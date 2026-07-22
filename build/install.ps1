#---------------------------------#
# Header                          #
#---------------------------------#
Write-Host 'Installing Required Modules:' -ForegroundColor Yellow

$RequiredModules = @(
	@{ Name = 'PowerShellGet' }
	@{ Name = 'Pester'; RequiredVersion = '5.7.1' }
	@{ Name = 'PSScriptAnalyzer' }
)

#---------------------------------#
# Install Required Modules        #
#---------------------------------#
foreach ($Module in $RequiredModules) {

	try {
		Write-Host "`tInstalling: $($Module.Name)..." -NoNewline
		$InstallParams = @{
			Name               = $Module.Name
			Repository         = 'PSGallery'
			Confirm            = $false
			Force              = $true
			SkipPublisherCheck = $true
			ErrorAction        = 'Stop'
		}
		if ($Module.RequiredVersion) {
			$InstallParams.RequiredVersion = $Module.RequiredVersion
		}
		Install-Module @InstallParams | Out-Null
		Write-Host ' OK' -ForegroundColor Green
	} catch {
		Write-Host 'Error' -ForegroundColor Red
		throw $_
	}

}