#---------------------------------#
# Header                          #
#---------------------------------#
Write-Host "Installing Required Modules:" -ForegroundColor Yellow

$RequiredModules = @(
	@{ Name = "PowerShellGet" }
	@{ Name = "Pester"; RequiredVersion = "5.7.1" }
	@{ Name = "PSScriptAnalyzer" }<#,
	@{ Name = "coveralls" },
	@{ Name = "PSCodeCovIo" }#>
)

#---------------------------------#
# Install NuGet                   #
<#---------------------------------#
if(-not $IsCoreCLR) {
	Write-Host "`tNuGet..."
	$pkg = Install-PackageProvider -Name NuGet -Confirm:$false -Force -ErrorAction Stop
	Write-Host "`t`tInstalled NuGet version '$($pkg.version)'"
}
#>
#---------------------------------#
# Install Required Modules        #
#---------------------------------#
foreach ($Module in $RequiredModules) {

	Try {
		Write-Host "`tInstalling: $($Module.Name)..." -NoNewline
		$InstallParams = @{
			Name               = $Module.Name
			Repository         = "PSGallery"
			Confirm            = $false
			Force              = $true
			SkipPublisherCheck = $true
			ErrorAction        = "Stop"
		}
		if ($Module.RequiredVersion) {
			$InstallParams.RequiredVersion = $Module.RequiredVersion
		}
		Install-Module @InstallParams | Out-Null
		Write-Host " OK" -ForegroundColor Green
	}Catch {
		Write-Host "Error" -ForegroundColor Red
		throw $_
	}

}