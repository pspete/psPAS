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
					Property1        = 'Value'
					Property2        = 'Another Value'
					modificationTime = $(Get-Date 1/1/2020)
				}

			}

			It 'does not throw' {

				{ ConvertTo-FilterString } | Should -Not -Throw

			}

			It 'produces no output if given no input' {

				ConvertTo-FilterString | Should -BeNullOrEmpty

			}

			It 'converts hashtable to expected filter string' {

				$Value = $InputObj | ConvertTo-FilterString

				$Value['filter'] | Should -Match ' AND '
				$Value['filter'] | Should -Match 'Property1 eq Value'
				$Value['filter'] | Should -Match 'Property2 eq Another Value'
				$Value['filter'] | Should -Match 'modificationTime gte 1577836800'

			}

			It 'converts hashtable to expected filter string with quoted values' {

				$Value = $InputObj | ConvertTo-FilterString -QuoteValue

				$Value['filter'] | Should -Match ' AND '
				$Value['filter'] | Should -Match 'Property1 eq "Value"'
				$Value['filter'] | Should -Match 'Property2 eq "Another Value"'
				$Value['filter'] | Should -Match 'modificationTime gte 1577836800'

			}

		}

	}

}