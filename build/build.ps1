#---------------------------------#
# Header                          #
#---------------------------------#
Write-Host 'Build Information:' -ForegroundColor Yellow
Write-Host "ModuleName    : $env:APPVEYOR_PROJECT_NAME"
Write-Host "Build version : $env:APPVEYOR_BUILD_VERSION"
Write-Host "Author        : $env:APPVEYOR_REPO_COMMIT_AUTHOR"
Write-Host "Branch        : $env:APPVEYOR_REPO_BRANCH"

#---------------------------------#
# BuildScript                     #
#---------------------------------#
Write-Host 'Nothing to build, skipping.....'