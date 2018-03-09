#---------------------------------#
# Header                          #
#---------------------------------#
Write-Host "Installing:" -ForegroundColor Yellow

#---------------------------------#
# Install NuGet                   #
#---------------------------------#
Write-Host "`tNuGet..."
$pkg = Install-PackageProvider -Name NuGet -Confirm:$false -Force -ErrorAction Stop
Write-Host "`t`tInstalled NuGet version '$($pkg.version)'"

#---------------------------------#
# Install Required Modules        #
#---------------------------------#
Write-Host "`tRequired Modules..."
Install-Module -Name Pester, PSScriptAnalyzer, coveralls -Repository PSGallery -Confirm:$false -Force -ErrorAction SilentlyContinue | Out-Null