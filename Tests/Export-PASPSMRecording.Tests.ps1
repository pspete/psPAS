#Get Current Directory
$Here = Split-Path -Parent $MyInvocation.MyCommand.Path

#Get Function Name
$FunctionName = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -Replace ".Tests.ps1"

#Assume ModuleName from Repository Root folder
$ModuleName = Split-Path (Split-Path $Here -Parent) -Leaf

#Resolve Path to Module Directory
$ModulePath = Resolve-Path "$Here\..\$ModuleName"

#Define Path to Module Manifest
$ManifestPath = Join-Path "$ModulePath" "$ModuleName.psd1"

if ( -not (Get-Module -Name $ModuleName -All)) {

	Import-Module -Name "$ManifestPath" -ArgumentList $true -Force -ErrorAction Stop

}

BeforeAll {

	$Script:RequestBody = $null
	$Script:BaseURI = "https://SomeURL/SomeApp"
	$Script:ExternalVersion = "0.0"
	$Script:WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

}

AfterAll {

	$Script:RequestBody = $null

}

Describe $FunctionName {

	InModuleScope $ModuleName {

		Context "Mandatory Parameters" {

			$Parameters = @{Parameter = 'RecordingID' },
			@{Parameter = 'path' }

			It "specifies parameter <Parameter> as mandatory" -TestCases $Parameters {

				param($Parameter)

				(Get-Command Export-PASPSMRecording).Parameters["$Parameter"].Attributes.Mandatory | Should Be $true

			}

		}

		Context "Input" {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith { }

				$InputObj = [pscustomobject]@{
					"RecordingID" = "SomeID"
					"path"        = "$env:Temp\test.avi"

				}

			}

			It "throws if path is invalid" {
				{ $InputObj | Export-PASPlatform -PlatformID SomePlatform -path A:\test.avi } | Should throw
			}

			It "throws if InputFile resolves to a folder" {
				{ $InputObj | Export-PASPlatform -PlatformID SomePlatform -path $pwd } | Should throw
			}

			It "sends request" {
				$InputObj | Export-PASPSMRecording
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint" {
				$InputObj | Export-PASPSMRecording
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:BaseURI)/API/Recordings/SomeID/Play"

				} -Times 1 -Exactly -Scope It

			}

			It "uses expected method" {
				$InputObj | Export-PASPSMRecording
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It "sends request with no body" {
				$InputObj | Export-PASPSMRecording
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

			It "throws error if version requirement not met" {

				{ $InputObj | Export-PASPSMRecording -ExternalVersion 10.5 } | Should throw

			}

		}

		Context "Output" {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {

					New-Object Byte[] 512

				}

				$InputObj = [pscustomobject]@{
					"RecordingID" = "SomeID"
					"path"        = "$env:Temp\test.avi"
				}

			}

			it "saves output file" {
				$InputObj | Export-PASPSMRecording
				Test-Path "$env:Temp\test.avi" | should Be $true

			}

			it "reports error saving outputfile" {
				Mock Set-Content -MockWith { throw something }
				{ $InputObj | Export-PASPSMRecording } | should throw "Error Saving $env:Temp\test.avi"
			}



		}

	}

}