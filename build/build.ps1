#---------------------------------#
# Header                          #
#---------------------------------#
Write-Host 'Build Information:' -ForegroundColor Yellow

#Get current module version from manifest
$ManifestPath = Join-Path "$pwd" $(Join-Path "$env:APPVEYOR_PROJECT_NAME" "$env:APPVEYOR_PROJECT_NAME.psd1")
$CurrentVersion = (Import-PowerShellDataFile $ManifestPath).ModuleVersion

#display module information
Write-Host "ModuleName       : $env:APPVEYOR_PROJECT_NAME"
Write-Host "Build version    : $env:APPVEYOR_BUILD_VERSION"
Write-Host "Manifest version : $CurrentVersion"
Write-Host "Author           : $env:APPVEYOR_REPO_COMMIT_AUTHOR"
Write-Host "Branch           : $env:APPVEYOR_REPO_BRANCH"

#---------------------------------#
# BuildScript                     #
#---------------------------------#
#---------------------------------#
# Update module manifest          #
#---------------------------------#
if($CurrentVersion -eq $env:APPVEYOR_BUILD_VERSION) {

	Write-Host "No build tasks required... skipping"

}

else {

	Write-Host "Updating Manifest Version to $env:APPVEYOR_BUILD_VERSION"

	Try {

		#Replace version in manifest with build version from appveyor
		((Get-Content $ManifestPath).replace("= '$($currentVersion)'", "= '$($env:APPVEYOR_BUILD_VERSION)'")) |
			Set-Content $ManifestPath -ErrorAction Stop

	}

	Catch {

		Write-Warning "Manifest Update failed."
		throw $_

	}

}