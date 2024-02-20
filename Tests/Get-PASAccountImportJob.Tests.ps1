Describe $($PSCommandPath -Replace '.Tests.ps1') {

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
		$psPASSession = [ordered]@{
			BaseURI            = 'https://SomeURL/SomeApp'
			User               = $null
			ExternalVersion    = [System.Version]'0.0'
			WebSession         = New-Object Microsoft.PowerShell.Commands.WebRequestSession
			StartTime          = $null
			ElapsedTime        = $null
			LastCommand        = $null
			LastCommandTime    = $null
			LastCommandResults = $null
		}

		New-Variable -Name psPASSession -Value $psPASSession -Scope Script -Force

	}


	AfterAll {

		$Script:RequestBody = $null

	}

	InModuleScope $(Split-Path (Split-Path (Split-Path -Parent $PSCommandPath) -Parent) -Leaf ) {

		Context 'General' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {  }


			}

			It 'does not throw' {

				{ Get-PASAccountImportJob } | Should -Not -Throw

			}

			It 'sends request' {
				Get-PASAccountImportJob
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It
			}

			It 'sends request to expected endpoint' {
				Get-PASAccountImportJob
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/api/bulkactions/accounts"

				} -Times 1 -Exactly -Scope It
			}

			It 'sends request to expected endpoint - byID' {
				Get-PASAccountImportJob -id 1234
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/api/bulkactions/accounts/1234"

				} -Times 1 -Exactly -Scope It
			}

			It 'uses expected method' {
				Get-PASAccountImportJob
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'GET' } -Times 1 -Exactly -Scope It
			}

			It 'throws error if version requirement not met' {
				$psPASSession.ExternalVersion = '11.5'

				{ $InputObj | Get-PASAccountImportJob } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

		}

	}

}