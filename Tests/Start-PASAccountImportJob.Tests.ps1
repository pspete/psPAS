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

				Mock Invoke-PASRestMethod -MockWith { '11' }
				Mock Get-PASAccountImportJob -MockWith {}
				$Accounts = @(
					New-PASAccountObject -uploadIndex 1 -userName SomeAccount1 -address domain.com -platformID WinDomain -SafeName SomeSafe
					New-PASAccountObject -uploadIndex 2 -userName SomeAccount2 -address domain.com -platformID WinDomain -SafeName SomeSafe
					New-PASAccountObject -uploadIndex 3 -userName SomeAccount3 -address domain.com -platformID WinDomain -SafeName SomeSafe
					New-PASAccountObject -uploadIndex 4 -userName SomeAccount4 -address domain.com -platformID WinDomain -SafeName SomeSafe
				)

			}

			It 'does not throw' {

				{ Start-PASAccountImportJob -Accounts $Accounts } | Should -Not -Throw

			}

			It 'sends request' {
				Start-PASAccountImportJob -Accounts $Accounts
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {
				Start-PASAccountImportJob -Accounts $Accounts
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/api/bulkactions/accounts"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {
				Start-PASAccountImportJob -Accounts $Accounts
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with expected body' {
				Start-PASAccountImportJob -Accounts $Accounts
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody.accountsList) -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It 'invokes Get-PASAccountImportJob' {

				Start-PASAccountImportJob -Accounts $Accounts
				Assert-MockCalled Get-PASAccountImportJob -ParameterFilter {

					$id -eq '11'

				} -Times 1 -Exactly -Scope It

			}

			It 'returns ID value if Get-PASAccountImportJob throws' {
				Mock Get-PASAccountImportJob -MockWith { throw }
				$result = Start-PASAccountImportJob -Accounts $Accounts
				$result.id | Should -Be 11
			}

			It 'throws error if version requirement not met' {
				$psPASSession.ExternalVersion = '11.5'

				{ $InputObj | Start-PASAccountImportJob } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

		}

	}

}