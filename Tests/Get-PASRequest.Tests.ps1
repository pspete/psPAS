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

		BeforeEach {
			Mock Invoke-PASRestMethod -MockWith {
				[PSCustomObject]@{
					"MyRequests"       = [PSCustomObject]@{"Prop1" = "Val1"; "Prop2" = "val2" }
					"IncomingRequests" = [PSCustomObject]@{"PropA" = "ValA"; "PropB" = "ValB"; "PropC" = "ValC" }
				}
			}
		}
		Context "Mandatory Parameters" {

			$Parameters = @{Parameter = 'RequestType' },
			@{Parameter = 'OnlyWaiting' },
			@{Parameter = 'Expired' }

			It "specifies parameter <Parameter> as mandatory" -TestCases $Parameters {

				param($Parameter)

				(Get-Command Get-PASRequest).Parameters["$Parameter"].Attributes.Mandatory | Should -Be $true

			}

		}

		Context "Input - MyRequests" {

			BeforeEach {
				Get-PASRequest -RequestType MyRequests -OnlyWaiting $true -Expired $true
			}
			It "sends request" {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -match ("$($Script:BaseURI)/API/MyRequests?OnlyWaiting=True&Expired=True" -or
						"$($Script:BaseURI)/API/MyRequests?Expired=True&OnlyWaiting=True")

				} -Times 1 -Exactly -Scope It

			}

			It "uses expected method" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

			}

			It "sends request with no body" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

			It "throws error if version requirement not met" {
				$Script:ExternalVersion = "1.0"
				{ Get-PASRequest -RequestType MyRequests -OnlyWaiting $true -Expired $true } | Should -Throw
				$Script:ExternalVersion = "0.0"
			}

		}

		Context "Input - IncomingRequests" {
			BeforeEach {
				Get-PASRequest -RequestType IncomingRequests -OnlyWaiting $true -Expired $true
			}
			It "sends request" {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -match ("$($Script:BaseURI)/API/IncomingRequests?OnlyWaiting=True&Expired=True" -or
						"$($Script:BaseURI)/API/IncomingRequests?Expired=True&OnlyWaiting=True")

				} -Times 1 -Exactly -Scope It

			}

			It "uses expected method" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It

			}

			It "sends request with no body" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Body -eq $null } -Times 1 -Exactly -Scope It

			}

		}

		Context "Output - MyRequests" {
			BeforeEach {
				$response = Get-PASRequest -RequestType MyRequests -OnlyWaiting $true -Expired $false
			}
			it "provides output" {

				$response | Should -Not -BeNullOrEmpty

			}

			It "has output with expected number of properties" {

				($response | Get-Member -MemberType NoteProperty).length | Should -Be 2

			}

			it "outputs object with expected typename" {

				$response | get-member | select-object -expandproperty typename -Unique | Should -Be psPAS.CyberArk.Vault.Request.Details

			}



		}

		Context "Output - IncomingRequests" {
			BeforeEach {
				$response = Get-PASRequest -RequestType IncomingRequests -OnlyWaiting $true -Expired $false
			}
			it "provides output" {

				$response | Should -Not -BeNullOrEmpty

			}

			It "has output with expected number of properties" {

				($response | Get-Member -MemberType NoteProperty).length | Should -Be 3

			}

			it "outputs object with expected typename" {

				$response | get-member | select-object -expandproperty typename -Unique | Should -Be psPAS.CyberArk.Vault.Request.Details

			}



		}

	}

}