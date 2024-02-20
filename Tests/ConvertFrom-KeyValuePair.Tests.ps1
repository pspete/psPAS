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

				$InputObj = [pscustomobject]@{ }

				$Permissions = @(
					[pscustomobject]@{
						'Key'   = 'Key1'
						'Value' = $true
					},
					[pscustomobject]@{
						'Key'   = 'Key2'
						'Value' = $true
					},
					[pscustomobject]@{
						'Key'   = 'TrueKey'
						'Value' = $true
					},
					[pscustomobject]@{
						'Key'   = 'FalseKey'
						'Value' = $false
					},
					[pscustomobject]@{
						'Key'   = 'AnotherKey'
						'Value' = 1
					},
					[pscustomobject]@{
						'Key'   = 'AnotherFalseKey'
						'Value' = $false
					}

				)
			}

			It 'does not throw' {

				{ $InputObj | ConvertFrom-KeyValuePair } | Should -Not -Throw

			}

			It 'produces no output if given no input' {

				$InputObj | ConvertFrom-KeyValuePair | Should -BeNullOrEmpty

			}

			It 'outputs expected properties' {

				$Result = $Permissions | ConvertFrom-KeyValuePair
				$Result.Key1 | Should -Be $true
				$Result.Key2 | Should -Be $true
				$Result.TrueKey | Should -Be $true
				$Result.FalseKey | Should -Be $false
				$Result.AnotherKey | Should -Be 1
				$Result.AnotherFalseKey | Should -Be $false

			}

		}

	}

}