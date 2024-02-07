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

				$InputObj = @{
					Property1 = 'Value'
					Property2 = 'Another Value'
				}

			}

			It 'does not throw' {

				{ ConvertTo-QueryString } | Should -Not -Throw

			}

			It 'produces no output if given no input' {

				ConvertTo-QueryString | Should -BeNullOrEmpty

			}

			It 'converts hashtable to expected query string' {

				$InputObj | ConvertTo-QueryString | Should -Match 'Value&Property'
				$InputObj | ConvertTo-QueryString | Should -Match 'Property1=Value'
				$InputObj | ConvertTo-QueryString | Should -Match 'Property2=Another%20Value'

			}

			It 'returns expected unescaped string' {
				$InputObj = @{
					Property1 = 'Value,Value,Value,Value'
				}
				$InputObj | ConvertTo-QueryString -NoEscape | Should -Match 'Property1=Value,Value,Value,Value'
			}

		}

	}

}