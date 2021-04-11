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
#$files = Get-Item 'pspas/**/*/*.ps1', 'pspas/**/*.ps1' | Select-Object -ExpandProperty FullName
#$paths = @(
#	'.\psPAS\Functions\*\*.ps1',
#	'.\psPAS\Private\*.ps1'
#)

# get default from static property
$configuration = [PesterConfiguration]::Default
# assing properties & discover via intellisense
$configuration.Run.Path = '.\Tests'
$configuration.Run.PassThru = $true
$configuration.CodeCoverage.Enabled = $false
#$configuration.CodeCoverage.Path = $paths
#$configuration.CodeCoverage.OutputEncoding = 'ascii'
#$configuration.CodeCoverage.OutputFormat = 'JaCoCo'
#$configuration.CodeCoverage.OutputPath = '.\JaCoCo_coverage.xml'
$configuration.TestResult.Enabled = $true
$configuration.TestResult.OutputFormat = 'NUnitXml'
$configuration.TestResult.OutputPath = '.\TestResults.xml'
$configuration.Output.Verbosity = 'Minimal'

$result = Invoke-Pester -Configuration $configuration

$res = $result | ConvertTo-Pester4Result

Write-Host 'Uploading Test Results'
$null = (New-Object 'System.Net.WebClient').UploadFile("https://ci.appveyor.com/api/testresults/nunit/$($env:APPVEYOR_JOB_ID)", $(Resolve-Path .\TestResults.xml))

Remove-Item -Path $(Resolve-Path .\TestResults.xml) -Force


if ($env:APPVEYOR_REPO_COMMIT_AUTHOR -eq 'Pete Maan') {

	#Write-Host 'Formating Code Coverage'
	#$coverage = Format-Coverage -PesterResults $res -CoverallsApiToken $($env:coveralls_key) -BranchName $($env:APPVEYOR_REPO_BRANCH)

	#$null = Export-CodeCovIoJson -CodeCoverage $res.CodeCoverage -RepoRoot $pwd -Path coverage.json

	#Write-Host 'Publishing Code Coverage'
	#$null = Publish-Coverage -Coverage $coverage

	#$null = Invoke-WebRequest -Uri 'https://codecov.io/bash' -OutFile codecov.sh

	#$null = bash codecov.sh -f .\JaCoCo_coverage.xml

	#Remove-Item -Path $(Resolve-Path .\JaCoCo_coverage.xml) -Force
	#Remove-Item -Path $(Resolve-Path .\codecov.sh) -Force

}

#---------------------------------#
# Validate                        #
#---------------------------------#
if (($res.FailedCount -gt 0) -or ($res.PassedCount -eq 0)) {

	throw "$($res.FailedCount) tests failed."

} else {

	Write-Host 'All tests passed' -ForegroundColor Green

}