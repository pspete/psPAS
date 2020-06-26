Describe $($PSCommandPath -Replace ".Tests.ps1") {

	BeforeAll {
		#Get Current Directory
		$Here = Split-Path -Parent $PSCommandPath

		#Assume ModuleName from Repository Root folder
		$ModuleName = Split-Path (Split-Path $Here -Parent) -Leaf

		#Resolve Path to Module Directory
		$ModulePath = Resolve-Path "$Here\..\$ModuleName"

		#Define Path to Module Manifest
		$ManifestPath = Join-Path "$ModulePath" "$ModuleName.psd1"

		if ( -not (Get-Module -Name $ModuleName -All)) {

			Import-Module -Name "$ManifestPath" -ArgumentList $true -Force -ErrorAction Stop

		}

		$Script:RequestBody = $null
		$Script:BaseURI = "https://SomeURL/SomeApp"
		$Script:ExternalVersion = "0.0"
		$Script:WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

	}


	AfterAll {

		$Script:RequestBody = $null

	}

	InModuleScope $(Split-Path (Split-Path (Split-Path -Parent $PSCommandPath) -Parent) -Leaf ) {

		BeforeEach{
			Mock Invoke-PASRestMethod -MockWith {

			}

			$InputObj = [pscustomobject]@{

				"AppID"        = "SomeApplication"
				"Location"     = "\SomeLocation\"

			}


			$response = $InputObj | Add-PASApplication -ExpirationDate 04-20-2019

		}

		Context "Mandatory Parameters" {

			$Parameters = @{Parameter = 'AppID'},
			@{Parameter = 'Location'}

			It "specifies parameter <Parameter> as mandatory" -TestCases $Parameters {

				param($Parameter)

				(Get-Command Add-PASApplication).Parameters["$Parameter"].Attributes.Mandatory | Should -Be $true

			}

		}



		Context "Input" {

			It "validates expiration date pattern" {

				{$InputObj | Add-PASApplication -ExpirationDate 20-04-2019} | Should -Throw

			}

			It "sends request" {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:BaseURI)/WebServices/PIMServices.svc/Applications"

				} -Times 1 -Exactly -Scope It

			}

			It "uses expected method" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {$Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It "sends request with expected body" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody.application) -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It "has a request body with expected number of properties" {

				($Script:RequestBody.application | Get-Member -MemberType NoteProperty).length | Should -Be 3

			}

		}

		Context "Output" {

			it "provides no output" {

				$response | Should -BeNullOrEmpty

			}

		}

	}

}