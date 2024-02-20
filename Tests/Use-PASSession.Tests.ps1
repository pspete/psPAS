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
		$Script:psPASSession.ExternalVersion = [System.Version]'0.0'

	}

	InModuleScope $(Split-Path (Split-Path (Split-Path -Parent $PSCommandPath) -Parent) -Leaf ) {

		Context 'Standard Operation' {

			BeforeEach {
				$session = New-Object Microsoft.PowerShell.Commands.WebRequestSession
				$session.Headers['Test'] = 'SomeValue'

				$InputObject = [PSCustomObject]@{
					PSTypeName      = 'psPAS.CyberArk.Vault.Session'
					User            = 'SomeUser'
					BaseURI         = 'SomeURL'
					ExternalVersion = '6.6'
					WebSession      = $session
					#NewProp         = "New Property"
				}
				Use-PASSession -Session $InputObject
			}

			It 'sets expected User' {
				$psPASSession.User | Should -Be 'SomeUser'
			}

			It 'sets expected BaseURI' {
				$psPASSession.BaseURI | Should -Be 'SomeURL'
			}

			It 'sets expected ExternalVersion' {
				$psPASSession.ExternalVersion | Should -Be '6.6'
			}

			It 'sets expected WebSession' {
				$psPASSession.WebSession.Headers['Test'] | Should -Be 'SomeValue'
			}

			It 'sets expected Other property' -Skip {

			}

		}

	}

}