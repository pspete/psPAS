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

		Context 'Standard Operation' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith { }

				$InputObj = [pscustomobject]@{
					'id'          = '12345'
					'NewPassword' = $('P_Password' | ConvertTo-SecureString -AsPlainText -Force)
				}

				$InputObj1 = [pscustomobject]@{
					'id'          = '12345'
					'NewPassword' = $('P_PasswordP_PasswordP_PasswordP_PasswordP_PasswordP_PasswordP_Password' | ConvertTo-SecureString -AsPlainText -Force)
				}
			}

			It 'does not throw' {
				{ $InputObj | Set-PASUserPassword } | Should -Not -Throw
			}

			It 'throws if NewPassword exceeds 39 characters' {
				{ $InputObj1 | Set-PASUserPassword } | Should -Throw -ExpectedMessage 'Password must not exceed 39 characters'
			}

			It 'sends request' {
				$InputObj | Set-PASUserPassword
				Assert-MockCalled -CommandName Invoke-PASRestMethod -Times 1 -Scope It
			}

		}

	}

}