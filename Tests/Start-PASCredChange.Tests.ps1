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

			$Parameters = @{Parameter = 'AccountID' }

			It "specifies parameter <Parameter> as mandatory" -TestCases $Parameters {

				param($Parameter)

				(Get-Command Start-PASCredChange).Parameters["$Parameter"].Attributes.Mandatory | Should Be $true

			}

		}

		Context "Input" {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {

				}

				$InputObj = [pscustomobject]@{

					"AccountID" = "55_5"

				}

				$Script:BaseURI = "https://SomeURL/SomeApp"
				$Script:ExternalVersion = "0.0"
				$Script:WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

			}

			It "sends request" {
				Start-PASCredChange -AccountID 55_5 -ImmediateChangeByCPM Yes -ChangeCredsForGroup Yes
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint" {
				Start-PASCredChange -AccountID 55_5 -ImmediateChangeByCPM Yes -ChangeCredsForGroup Yes
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:BaseURI)/WebServices/PIMServices.svc/Accounts/55_5/ChangeCredentials"

				} -Times 1 -Exactly -Scope It

			}

			It "uses expected method" {
				Start-PASCredChange -AccountID 55_5 -ImmediateChangeByCPM Yes -ChangeCredsForGroup Yes
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'PUT' } -Times 1 -Exactly -Scope It

			}

			It "sends request with expected header" {
				Start-PASCredChange -AccountID 55_5 -ImmediateChangeByCPM Yes -ChangeCredsForGroup Yes
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$headers = $WebSession.headers
					$($headers["ImmediateChangeByCPM"]) -eq "Yes"

				} -Times 1 -Exactly -Scope It

			}

			It "sends request with expected body" {
				Start-PASCredChange -AccountID 55_5 -ImmediateChangeByCPM Yes -ChangeCredsForGroup Yes
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody) -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It "has a request body with expected number of properties" {

				($Script:RequestBody | Get-Member -MemberType NoteProperty).length | Should Be 1

			}

		}

		Context "Output" {
			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {

				}

				$InputObj = [pscustomobject]@{

					"AccountID" = "55_5"

				}

				$Script:BaseURI = "https://SomeURL/SomeApp"
				$Script:ExternalVersion = "0.0"
				$Script:WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

			}
			it "provides no output" {

				Start-PASCredChange -AccountID 55_5 -ImmediateChangeByCPM Yes -ChangeCredsForGroup Yes | Should BeNullOrEmpty

			}

		}

	}

}