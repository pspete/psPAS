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
				[PSCustomObject]@{"addsaferesult" = [PSCustomObject]@{"Prop1" = "Val1"; "Prop2" = "Val2"}}
			}

			$InputObj = [pscustomobject]@{
				"SafeName"     = "SomeName"

			}

			$response = $InputObj | Add-PASSafe -NumberOfDaysRetention 1

		}

		Context "Mandatory Parameters" {

			$Parameters = @{Parameter = 'SafeName'}

			It "specifies parameter <Parameter> as mandatory" -TestCases $Parameters {

				param($Parameter)

				(Get-Command Add-PASSafe).Parameters["$Parameter"].Attributes.Mandatory | Should -Be $true

			}

			It "specifies parameter NumberOfVersionsRetention as mandatory for ParameterSet Versions" {

				(Get-Command Add-PASSafe).Parameters["NumberOfVersionsRetention"].ParameterSets["Versions"].IsMandatory | Should -Be $true

			}

			It "specifies parameter NumberOfDaysRetention as mandatory for ParameterSet Days" {

				(Get-Command Add-PASSafe).Parameters["NumberOfDaysRetention"].ParameterSets["Days"].IsMandatory | Should -Be $true

			}

		}

		Context "Input" {

			It "sends request" {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:BaseURI)/WebServices/PIMServices.svc/Safes"

				} -Times 1 -Exactly -Scope It

			}

			It "uses expected method" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {$Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It "sends request with expected body" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody.safe) -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It "has a request body with expected number of properties" {

				($Script:RequestBody.safe | Get-Member -MemberType NoteProperty).length | Should -Be 2

			}

		}

		Context "Output" {

			it "provides output" {

				$response | Should -Not -BeNullOrEmpty

			}

			It "has output with expected number of properties" {

				($response | Get-Member -MemberType NoteProperty).length | Should -Be 2

			}

			it "outputs object with expected typename" {

				$response | get-member | select-object -expandproperty typename -Unique | Should -Be psPAS.CyberArk.Vault.Safe

			}



		}

	}

}