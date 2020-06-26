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
			#[pscustomobject]@{"AddAccountPrivilegedCommandResult" = [pscustomobject]@{"some" = "thing"}}

		}

		$InputObj = [pscustomobject]@{
			"AccountPolicyID" = "UNIXSSH"
			"AccountAddress"  = "ServerA.domain.com"
			"AccountUserName" = "root"
			"Id"              = 22
		}

			$response = $InputObj | Remove-PASAccountACL


	}
		Context "Mandatory Parameters" {

			$Parameters = @{Parameter = 'AccountPolicyId'},
			@{Parameter = 'AccountAddress'},
			@{Parameter = 'AccountUserName'},
			@{Parameter = 'Id'}

			It "specifies parameter <Parameter> as mandatory" -TestCases $Parameters {

				param($Parameter)

				(Get-Command Remove-PASAccountACL).Parameters["$Parameter"].Attributes.Mandatory | Should -Be $true

			}

		}



		Context "Input" {

			It "sends request" {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:BaseURI)/WebServices/PIMServices.svc/Account/ServerA.domain.com|root|UNIXSSH/PrivilegedCommands/22"
				} -Times 1 -Exactly -Scope It

			}

			It "uses expected method" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {$Method -match 'DELETE' } -Times 1 -Exactly -Scope It

			}

			It "sends request with expected body" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Body -eq @{}

				} -Times 1 -Exactly -Scope It

			}

		}

		Context "Output" {

			it "provides no output" {

				$response | Should -BeNullOrEmpty

			}

		}

	}

}
