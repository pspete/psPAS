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
		$Script:BaseURI = 'https://SomeURL/SomeApp'
		$Script:ExternalVersion = '0.0'
		$Script:WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

	}


	AfterAll {

		$Script:RequestBody = $null

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
				}

			}

			It 'invokes set-variable the expected number of times' {
				Mock Set-Variable -MockWith { }
				Use-PASSession -Session $InputObject
				Assert-MockCalled Set-Variable -Times 3 -Exactly -Scope It
			}

		}

	}

}