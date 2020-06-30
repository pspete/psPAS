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
"id"           = 99
			"category"     = "KEYSTROKES"
			"regex"        = "(.*)Some Pattern(.*)"
			"score"        = 80
			"description"  = "Some String"
			"response"     = "NONE"
			"active"       = $true

		}

			$response = $InputObj | Set-PASPTARule

}
		Context "Mandatory Parameters" {

			$Parameters = @{Parameter = 'id'},
			@{Parameter = 'category'},
			@{Parameter = 'regex'},
			@{Parameter = 'score'},
			@{Parameter = 'description'},
			@{Parameter = 'response'},
			@{Parameter = 'active'}

			It "specifies parameter <Parameter> as mandatory" -TestCases $Parameters {

				param($Parameter)

				(Get-Command Set-PASPTARule).Parameters["$Parameter"].Attributes.Mandatory | Should -Be $true

			}

		}



		Context "Input" {

			It "sends request" {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:BaseURI)/API/pta/API/Settings/RiskyActivity/"

				} -Times 1 -Exactly -Scope It

			}

			It "uses expected method" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {$Method -match 'PUT' } -Times 1 -Exactly -Scope It

			}

			It "sends request with expected body" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody) -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It "has a request body with expected number of properties" {

				($Script:RequestBody | Get-Member -MemberType NoteProperty).length | Should -Be 7

			}

			It "throws error if version requirement not met" {
$Script:ExternalVersion = "1.0"
				{$InputObj | Set-PASPTARule } | Should -Throw
$Script:ExternalVersion = "0.0"
			}

		}

		Context "Output" {

			it "provides no output" {

				$response | Should -BeNullOrEmpty

			}

		}

	}

}