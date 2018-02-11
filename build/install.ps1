#---------------------------------#
# Header                          #
#---------------------------------#
Write-Host 'Running Install Script $($MyInvocation.MyCommand.Name):' -ForegroundColor Yellow

#---------------------------------#
# Install NuGet                   #
#---------------------------------#
Write-Host 'Installing NuGet...'
$pkg = Install-PackageProvider -Name NuGet -Confirm:$false -Force -ErrorAction Stop
Write-Host "Installed NuGet version '$($pkg.version)'"

#---------------------------------#
# Install Required Modules        #
#---------------------------------#
Write-Host 'Installing Required Modules...'
Install-Module -Name Pester, PSScriptAnalyzer -Repository PSGallery -Confirm:$false -Force -ErrorAction SilentlyContinue | Out-Null