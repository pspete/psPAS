#---------------------------------#
# Header                          #
#---------------------------------#
Write-Host "Installing Required Modules:" -ForegroundColor Yellow

$RequiredModules = @(
	"PowerShellGet"
	"Pester",
	"PSScriptAnalyzer"<#,
	"coveralls",
	"PSCodeCovIo"#>
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
		Write-Host "`tInstalling: $Module..." -NoNewline
		Install-Module -Name $Module -Repository PSGallery -Confirm:$false -Force -SkipPublisherCheck -ErrorAction Stop | Out-Null
		Write-Host " OK" -ForegroundColor Green
	}Catch {
		Write-Host "Error" -ForegroundColor Red
		throw $_
	}

}