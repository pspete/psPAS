#---------------------------------#
# Header                          #
#---------------------------------#
Write-Host "Installing:" -ForegroundColor Yellow

#---------------------------------#
# Install NuGet                   #
#---------------------------------#
if(-not $IsCoreCLR) {
	Write-Host "`tNuGet..."
	$pkg = Install-PackageProvider -Name NuGet -Confirm:$false -Force -ErrorAction Stop
	Write-Host "`t`tInstalled NuGet version '$($pkg.version)'"
}
#---------------------------------#
# Install Required Modules        #
#---------------------------------#
Try {
	Write-Host "`tRequired Module: Pester..."
	Install-Module -Name Pester -Repository PSGallery -Confirm:$false -Force -ErrorAction Stop | Out-Null
	Write-Host "`tRequired Module: PSScriptAnalyzer..."
	Install-Module -Name PSScriptAnalyzer -Repository PSGallery -Confirm:$false -Force -SkipPublisherCheck -ErrorAction Stop | Out-Null
	Write-Host "`tRequired Module: coveralls..."
	Install-Module -Name coveralls -Repository PSGallery -Confirm:$false -Force -ErrorAction Stop | Out-Null
} Catch {throw "`t`tError Installing Module"}
