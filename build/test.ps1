#---------------------------------#
# Header                          #
#---------------------------------#
Write-Host "Testing: PSVersion $($PSVersionTable.PSVersion)" -ForegroundColor Yellow
$ManifestPath = Join-Path "$pwd" $(Join-Path "$env:APPVEYOR_PROJECT_NAME" "$env:APPVEYOR_PROJECT_NAME.psd1")
Import-Module Pester -Force
Import-Module $ManifestPath -Force
#---------------------------------#
# Run Pester Tests                #
#---------------------------------#
#$files = Get-ChildItem $(Join-Path $ENV:APPVEYOR_BUILD_FOLDER $env:APPVEYOR_PROJECT_NAME) -Include *.ps1 -Recurse | Select-Object -ExpandProperty FullName

# get default from static property
$configuration = [PesterConfiguration]::Default
# assing properties & discover via intellisense
$configuration.Run.Path = '.\Tests'
$configuration.Run.PassThru = $true
#$configuration.CodeCoverage.Enabled = $true
#$configuration.CodeCoverage.Path = $files
$configuration.TestResult.Enabled = $true
$configuration.TestResult.OutputFormat = 'NUnitXml'
$configuration.TestResult.OutputPath = '.\TestResults.xml'
$configuration.Output.Verbosity = 'Minimal'

$result = Invoke-Pester -Configuration $configuration

$res = $result | ConvertTo-Pester4Result

Write-Host 'Uploading Test Results.'
$null = (New-Object 'System.Net.WebClient').UploadFile("https://ci.appveyor.com/api/testresults/nunit/$($env:APPVEYOR_JOB_ID)", $(Resolve-Path .\TestResults.xml))

Remove-Item -Path $(Resolve-Path .\TestResults.xml) -Force


if ($env:APPVEYOR_REPO_COMMIT_AUTHOR -eq 'Pete Maan') {

	#Write-Host 'Publishing Code Coverage'

	#$ProgressPreference = 'SilentlyContinue'
	#$null = Invoke-WebRequest -Uri https://uploader.codecov.io/latest/windows/codecov.exe -OutFile codecov.exe
	#.\codecov.exe -t ${env:CODECOV_TOKEN} | Out-Null

	#Remove-Item -Path $(Resolve-Path .\coverage.xml) -Force
	#Remove-Item -Path $(Resolve-Path .\codecov.exe) -Force

}

#---------------------------------#
# Validate                        #
#---------------------------------#
if (($res.FailedCount -gt 0) -or ($res.PassedCount -eq 0)) {

	throw "$($res.FailedCount) tests failed."

} else {

	Write-Host 'All tests passed' -ForegroundColor Green

}