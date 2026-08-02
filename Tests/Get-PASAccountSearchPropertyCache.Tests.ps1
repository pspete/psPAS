Describe $($PSCommandPath -replace '.Tests.ps1') {

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

		$psPASSession = [ordered]@{
			BaseURI                 = 'https://SomeURL/SomeApp'
			User                    = $null
			ExternalVersion         = [System.Version]'14.4'
			WebSession              = New-Object Microsoft.PowerShell.Commands.WebRequestSession
			StartTime               = $null
			ElapsedTime             = $null
			LastCommand             = $null
			LastCommandTime         = $null
			LastCommandResults      = $null
			AccountSearchProperties = $null
		}

		New-Variable -Name psPASSession -Value $psPASSession -Scope Script -Force

	}

	InModuleScope $(Split-Path (Split-Path (Split-Path -Parent $PSCommandPath) -Parent) -Leaf ) {

		BeforeEach {

			$psPASSession.AccountSearchProperties = $null
			$psPASSession.BaseURI = 'https://SomeURL/SomeApp'
			$psPASSession.ExternalVersion = [System.Version]'14.4'

			Mock Get-PASAccountSearchProperty -MockWith {
				[pscustomobject]@{ PropertyName = 'safeName' }
			}

		}

		Context 'Cache Population' {

			It 'calls Get-PASAccountSearchProperty when no cache exists' {

				Get-PASAccountSearchPropertyCache

				Assert-MockCalled Get-PASAccountSearchProperty -Times 1 -Exactly -Scope It

			}

			It 'returns the properties from Get-PASAccountSearchProperty' {

				$response = Get-PASAccountSearchPropertyCache

				$response.PropertyName | Should -Be 'safeName'

			}

		}

		Context 'Cache Reuse' {

			It 'does not call Get-PASAccountSearchProperty again for a repeat call against the same session' {

				Get-PASAccountSearchPropertyCache
				Get-PASAccountSearchPropertyCache

				Assert-MockCalled Get-PASAccountSearchProperty -Times 1 -Exactly

			}

		}

		Context 'Cache Invalidation' {

			It 'calls Get-PASAccountSearchProperty again if BaseURI has changed' {

				Get-PASAccountSearchPropertyCache
				$psPASSession.BaseURI = 'https://SomeOtherURL/SomeApp'
				Get-PASAccountSearchPropertyCache

				Assert-MockCalled Get-PASAccountSearchProperty -Times 2 -Exactly

			}

			It 'calls Get-PASAccountSearchProperty again if ExternalVersion has changed' {

				Get-PASAccountSearchPropertyCache
				$psPASSession.ExternalVersion = [System.Version]'14.6'
				Get-PASAccountSearchPropertyCache

				Assert-MockCalled Get-PASAccountSearchProperty -Times 2 -Exactly

			}

		}

	}

}
