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

		BeforeEach {

			Mock Invoke-PASRestMethod -MockWith {
				[PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' }

			}

			$InputObj = [pscustomobject]@{
				'category'       = 'KEYSTROKES'
				'regex'          = '(.*)Some Pattern(.*)'
				'score'          = 80
				'description'    = 'Some String'
				'response'       = 'NONE'
				'active'         = $true
				'vaultUsersMode' = 'INCLUDE'
				'vaultUsersList' = 'User1', 'User2'
				'machinesMode'   = 'EXCLUDE'
				'machinesList'   = 'Machine1'

			}

			$response = $InputObj | Add-PASPTARule

		}


		Context 'Mandatory Parameters' {

			$Parameters = @{Parameter = 'category' },
			@{Parameter = 'regex' },
			@{Parameter = 'score' },
			@{Parameter = 'description' },
			@{Parameter = 'response' },
			@{Parameter = 'active' }

			It 'specifies parameter <Parameter> as mandatory' -TestCases $Parameters {

				param($Parameter)

				(Get-Command Add-PASPTARule).Parameters["$Parameter"].Attributes.Mandatory | Should -Be $true

			}

		}

		Context 'Input' {

			It 'sends request' {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/API/pta/API/Settings/RiskyActivity/"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with expected body' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody) -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It 'has a request body with expected number of properties' {

				($Script:RequestBody | Get-Member -MemberType NoteProperty).length | Should -Be 7

			}

			It 'has a request body with expected scope properties' {

				$Script:RequestBody.scope.vaultUsers.mode | Should -Be 'INCLUDE'
				$Script:RequestBody.scope.machines.mode | Should -Be 'EXCLUDE'
				$Script:RequestBody.scope.vaultUsers.list | Should -HaveCount 2
				$Script:RequestBody.scope.vaultUsers.list | Should -Contain User1
				$Script:RequestBody.scope.vaultUsers.list | Should -Contain User2
				$Script:RequestBody.scope.machines.list | Should -HaveCount 1
				$Script:RequestBody.scope.machines.list | Should -Contain Machine1
			}

			It 'throws error if version requirement not met' {

				$psPASSession.ExternalVersion = '1.0'

				{ $InputObj | Add-PASPTARule } | Should -Throw

				$psPASSession.ExternalVersion = '0.0'
			}

		}

		Context 'Output' {

			It 'provides output' {

				$response | Should -Not -BeNullOrEmpty

			}

			It 'has output with expected number of properties' {

				($response | Get-Member -MemberType NoteProperty).length | Should -Be 2

			}

			It 'outputs object with expected typename' {

				$response | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.PTA.Rule

			}

		}

	}

}