#---------------------------------#
# Header                          #
#---------------------------------#
Write-Host "Deploy Process:" -ForegroundColor Yellow

if ((! $ENV:APPVEYOR_PULL_REQUEST_NUMBER) -and ($ENV:APPVEYOR_REPO_BRANCH -eq 'master')) {

	#---------------------------------#
	# Publish to PS Gallery           #
	#---------------------------------#

	Try {

		Write-Host 'Publish to Powershell Gallery...'

		$ModulePath = Join-Path $env:APPVEYOR_BUILD_FOLDER $env:APPVEYOR_PROJECT_NAME

		Publish-Module -Path $ModulePath -NuGetApiKey $($env:psgallery_key) -Confirm:$false -ErrorAction Stop

		Write-Host "$($env:APPVEYOR_PROJECT_NAME) published." -ForegroundColor Cyan

	} Catch {

		Write-Warning "Publish Failed."
		throw $_

	}

	#---------------------------------#
	# Push to Master Branch        #
	#---------------------------------#

	Try {

		Write-Host "Push Version update to GitHub..."

		git config --global core.safecrlf false

		git config --global credential.helper store

		Add-Content "$env:USERPROFILE\.git-credentials" "https://$($env:access_token):x-oauth-basic@github.com`n"

		git config --global user.email "pete.maan+github@gmail.com"

		git config --global user.name "Pete Maan"

		git checkout -q master

		git add $(Join-Path "$env:APPVEYOR_PROJECT_NAME" "$env:APPVEYOR_PROJECT_NAME.psd1")

		git status

		git commit -s -m "Update Version"

		git push --porcelain origin master

		Write-Host "$($env:APPVEYOR_PROJECT_NAME) updated version pushed to GitHub." -ForegroundColor Cyan

	}

	Catch {

		Write-Warning "Push to GitHub failed."
		throw $_

	}

}

Else {

	Write-Host "Finished testing of branch: $env:APPVEYOR_REPO_BRANCH - Exiting"
	exit;

}