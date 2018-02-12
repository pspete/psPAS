#---------------------------------#
# Header                          #
#---------------------------------#
Write-Host "Deploy Process:" -ForegroundColor Yellow


if ((! $ENV:APPVEYOR_PULL_REQUEST_NUMBER) -and ($ENV:APPVEYOR_REPO_BRANCH -eq 'master')) {

	#---------------------------------#
	# Publish to PS Gallery           #
	#---------------------------------#

	#$ModulePath = Split-Path $pwd
	#Write-Host "Adding $ModulePath to 'psmodulepath' PATH variable"
	#$env:psmodulepath = $env:psmodulepath + ';' + $ModulePath

	#Write-Host 'Publishing module to Powershell Gallery'
	#Uncomment the below line, make sure you set the variables in appveyor.yml
	#Publish-Module -Name $env:ModuleName -NuGetApiKey $env:NuGetApiKey

	#---------------------------------#
	# Publish to Master Branch        #
	#---------------------------------#
	<#
	Try{

		Write-Host "Update Version on GitHub" -ForegroundColor Yellow

		git config --global core.safecrlf false

		git config --global credential.helper store

		Add-Content "$env:USERPROFILE\.git-credentials" "https://$($env:access_token):x-oauth-basic@github.com`n"

		git config --global user.email "pete.maan+github@gmail.com"

		git config --global user.name "Pete Maan"

		git checkout -q issue-44

		git add $(Join-Path "$env:APPVEYOR_PROJECT_NAME" "$env:APPVEYOR_PROJECT_NAME.psd1")

		git status

		git commit -s -m "Update Version"

		git push --porcelain origin issue-44

	}

	Catch{

		Write-Warning "Publishing update to GitHub failed."
		throw $_

	}
	#>

}

Else {

	Write-Host "Finished testing of branch: $env:APPVEYOR_REPO_BRANCH - Exiting"
	exit;

}