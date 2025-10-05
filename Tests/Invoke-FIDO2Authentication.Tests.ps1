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

		Context 'Mandatory Parameters' {

			$Parameters = @(
				@{Parameter = 'BaseURI' },
				@{Parameter = 'UserName' }
			)

			It 'specifies parameter as mandatory' -TestCases $Parameters {

				param($Parameter)

				(Get-Command Invoke-FIDO2Authentication).Parameters["$Parameter"].Attributes.Mandatory | Should -Be $true

			}

			It 'specifies parameter LogonRequest as optional' {

				(Get-Command Invoke-FIDO2Authentication).Parameters["LogonRequest"].Attributes.Mandatory | Should -Be $false

			}

		}

		Context 'Platform Requirements' {

			BeforeEach {
				$IsWindowsPlatform = (-not (Test-IsCoreCLR)) -or $IsWindows
			}

			It 'requires Windows platform' {
				if (-not $IsWindowsPlatform) {
					{ Invoke-FIDO2Authentication -BaseURI 'https://pvwa.example.com' -UserName 'testuser' -LogonRequest @{} } | Should -Throw '*Windows*'
				}
			}

		}

		Context 'Input Validation' {

			It 'accepts BaseURI parameter' {
				$params = (Get-Command Invoke-FIDO2Authentication).Parameters['BaseURI']
				$params | Should -Not -BeNullOrEmpty
				$params.ParameterType.Name | Should -Be 'String'
			}

			It 'accepts UserName parameter' {
				$params = (Get-Command Invoke-FIDO2Authentication).Parameters['UserName']
				$params | Should -Not -BeNullOrEmpty
				$params.ParameterType.Name | Should -Be 'String'
			}

			It 'accepts LogonRequest parameter' {
				$params = (Get-Command Invoke-FIDO2Authentication).Parameters['LogonRequest']
				$params | Should -Not -BeNullOrEmpty
				$params.ParameterType.Name | Should -Be 'Hashtable'
			}

		}

		Context 'Help Content' {

			It 'has a synopsis' {
				$help = Get-Help Invoke-FIDO2Authentication
				$help.Synopsis | Should -Not -BeNullOrEmpty
			}

			It 'has a description' {
				$help = Get-Help Invoke-FIDO2Authentication
				$help.Description | Should -Not -BeNullOrEmpty
			}

			It 'has examples' {
				$help = Get-Help Invoke-FIDO2Authentication
				$help.Examples | Should -Not -BeNullOrEmpty
			}

		}

	}

}
