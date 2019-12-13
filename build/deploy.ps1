#---------------------------------#
# Header                          #
#---------------------------------#
Write-Host "Deploy Process:" -ForegroundColor Yellow

if ((! $ENV:APPVEYOR_PULL_REQUEST_NUMBER) -and ($ENV:APPVEYOR_REPO_BRANCH -eq 'master')) {

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

	#---------------------------------#
	# Publish to PS Gallery           #
	#---------------------------------#

	if ($ENV:psgallery_deploy -eq "automatic_deploy") {

		Try {

			Write-Host 'Publish to Powershell Gallery...'

			$ModulePath = Join-Path $env:APPVEYOR_BUILD_FOLDER $env:APPVEYOR_PROJECT_NAME

			Write-Host "Publishing: $ModulePath"
		
			Publish-Module -Path $ModulePath -NuGetApiKey $($env:psgallery_key) -SkipAutomaticTags -Confirm:$false -ErrorAction Stop -Force

			Write-Host "$($env:APPVEYOR_PROJECT_NAME) published." -ForegroundColor Cyan

		}
		Catch {

			Write-Warning "Publish Failed."
			throw $_

		}
	
	}

	Elseif ($ENV:psgallery_deploy -eq "manual_deploy") { 

		Write-Host "Finished testing of branch: $env:APPVEYOR_REPO_BRANCH"
		Write-Host "Manual Deployment to PSGallery Required"
		Write-Host "Exiting"
		exit;

	}

}

Else {

	Write-Host "Finished testing of branch: $env:APPVEYOR_REPO_BRANCH - Exiting"
	exit;

}