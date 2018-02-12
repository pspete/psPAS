#---------------------------------#
# Header                          #
#---------------------------------#
Write-Host "Testing:" -ForegroundColor Yellow
Write-Host "Current working directory: $pwd"

#---------------------------------#
# Run Pester Tests                #
#---------------------------------#
$res = Invoke-Pester -Path ".\Tests" -OutputFormat NUnitXml -OutputFile TestsResults.xml -PassThru

Write-Host 'Uploading Test Results'
(New-Object 'System.Net.WebClient').UploadFile("https://ci.appveyor.com/api/testresults/nunit/$($env:APPVEYOR_JOB_ID)", (Resolve-Path .\TestsResults.xml))

#---------------------------------#
# Validate                        #
#---------------------------------#
if (($res.FailedCount -gt 0) -or ($res.PassedCount -eq 0)) {

	throw "$($res.FailedCount) tests failed."

} else {

	Write-Host 'All tests passed' -ForegroundColor Green

}