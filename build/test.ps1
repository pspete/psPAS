#---------------------------------#
# Header                          #
#---------------------------------#
Write-Host "Testing:" -ForegroundColor Yellow
Write-Host "Current working directory: $pwd"

#---------------------------------#
# Run Pester Tests                #
#---------------------------------#
$files = Get-ChildItem ".\psPAS" -Include *.ps1 -Recurse

$res = Invoke-Pester -Path ".\Tests" -OutputFormat NUnitXml -OutputFile TestsResults.xml -CodeCoverage $files -PassThru

Write-Host 'Uploading Test Results'
(New-Object 'System.Net.WebClient').UploadFile("https://ci.appveyor.com/api/testresults/nunit/$($env:APPVEYOR_JOB_ID)", (Resolve-Path .\TestsResults.xml))

Write-Host 'Formating Code Coverage'
$coverage = Format-Coverage -PesterResults $res -CoverallsApiToken $($env:coveralls_key) -BranchName $($env:APPVEYOR_REPO_BRANCH)
Write-Host 'Publishing Code Coverage'
Publish-Coverage -Coverage $coverage

#---------------------------------#
# Validate                        #
#---------------------------------#
if (($res.FailedCount -gt 0) -or ($res.PassedCount -eq 0)) {

	throw "$($res.FailedCount) tests failed."

} else {

	Write-Host 'All tests passed.' -ForegroundColor Green

}