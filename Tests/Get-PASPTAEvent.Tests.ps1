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

		Context "Input" {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{"addsaferesult" = [PSCustomObject]@{"Prop1" = "Val1"; "Prop2" = "Val2" } }
				}

				$Script:BaseURI = "https://SomeURL/SomeApp"
				$Script:ExternalVersion = "0.0"
				$Script:WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

			}

			It "sends request" {
				Get-PASPTAEvent -fromUpdateDate 1-1-1979
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint" {
				Get-PASPTAEvent -fromUpdateDate 1-1-1979
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -match "$($Script:BaseURI)/API/pta/API/Events/"

				} -Times 1 -Exactly -Scope It

			}

			It "uses expected method" {
				Get-PASPTAEvent -fromUpdateDate 1-1-1979
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

			}

			It "sends request with expected header" {
				Get-PASPTAEvent -lastUpdatedEventDate 1-1-1979
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$($Websession.headers["lastUpdatedEventDate"]) -eq "283996800"

				} -Times 1 -Exactly -Scope It

			}

			It "sends request with no body" {
				Get-PASPTAEvent -fromUpdateDate 1-1-1979
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Body -eq $null

				} -Times 1 -Exactly -Scope It

			}

			It "throws error if version requirement not met" {
				$Script:ExternalVersion = "1.0"
				{ Get-PASPTAEvent } | Should -Throw
				$Script:ExternalVersion = "0.0"
			}

		}

		Context "Output" {
			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{"addsaferesult" = [PSCustomObject]@{"Prop1" = "Val1"; "Prop2" = "Val2" } }
				}

				$Script:BaseURI = "https://SomeURL/SomeApp"
				$Script:ExternalVersion = "0.0"
				$Script:WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

			}
			it "provides output" {

				Get-PASPTAEvent -fromUpdateDate 1-1-1979 | Should -Not -BeNullOrEmpty

			}

			It "has output with expected number of properties" {

				(Get-PASPTAEvent -fromUpdateDate 1-1-1979 | Get-Member -MemberType NoteProperty).length | Should -Be 1

			}

			it "outputs object with expected typename" {

				Get-PASPTAEvent -fromUpdateDate 1-1-1979 | get-member | select-object -expandproperty typename -Unique | Should -Be psPAS.CyberArk.Vault.PTA.Event

			}



		}

	}

}