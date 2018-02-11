#---------------------------------#
# Header                          #
#---------------------------------#
Write-Host "Deploying" -ForegroundColor Yellow

#---------------------------------#
# Update module manifest          #
#---------------------------------#
Write-Host "Update Module Version"
$ManifestPath = Join-Path "$pwd" $(Join-Path "$env:APPVEYOR_PROJECT_NAME" "$env:APPVEYOR_PROJECT_NAME.psd1")
$CurrentVersion = (Import-PowerShellDataFile $ManifestPath).ModuleVersion
Write-Host "`tCurrent Version: `t$CurrentVersion"
Write-Host "`tBuild Version: `t$env:APPVEYOR_BUILD_VERSION"
((Get-Content $ManifestPath).replace("= '$($currentVersion)'", "= '$($env:APPVEYOR_BUILD_VERSION)'")) | Set-Content $ManifestPath
Write-Host "`tNew Version: `t$((Import-PowerShellDataFile $ManifestPath).ModuleVersion)"
Write-Host "PR: $ENV:APPVEYOR_PULL_REQUEST_NUMBER"
Write-Host "Branch: $ENV:APPVEYOR_REPO_BRANCH"

#---------------------------------#
# Publish to PS Gallery           #
#---------------------------------#
#if ($env:APPVEYOR_REPO_BRANCH -notmatch 'master') {
#	Write-Host "Finished testing of branch: $env:APPVEYOR_REPO_BRANCH - Exiting"
#	exit;
#}

#$ModulePath = Split-Path $pwd
#Write-Host "Adding $ModulePath to 'psmodulepath' PATH variable"
#$env:psmodulepath = $env:psmodulepath + ';' + $ModulePath

#Write-Host 'Publishing module to Powershell Gallery'
#Uncomment the below line, make sure you set the variables in appveyor.yml
#Publish-Module -Name $env:ModuleName -NuGetApiKey $env:NuGetApiKey

Write-Host "Version Update in GitHub" -ForegroundColor Yellow

git config --global core.safecrlf false

git config --global credential.helper store

Add-Content "$env:USERPROFILE\.git-credentials" "https://$($env:access_token):x-oauth-basic@github.com`n"

git config --global user.email "pete.maan+github@gmail.com"

git config --global user.name "Pete Maan"

git checkout issue-44

git add $(Join-Path "$env:APPVEYOR_PROJECT_NAME" "$env:APPVEYOR_PROJECT_NAME.psd1")

git status

git commit -s -m "Update Version"

git push origin issue-44
