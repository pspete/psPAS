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

				$Object = [PSCustomObject]@{
					First   = 'Cookie'
					Last    = 'Monster'
					Account = 'CMonster'
				}

			}

			It 'adds a typename' {

				Add-ObjectDetail -InputObject $Object -TypeName 'SomeTypeName'
				$Object | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be 'SomeTypeName'

			}

			It 'adds a property' {

				Add-ObjectDetail -InputObject $Object -PropertyToAdd @{AnotherProperty = 5 }
				$Object.AnotherProperty | Should -Be 5

			}

			It 'sets a default display property set' {

				Add-ObjectDetail -InputObject $Object -DefaultProperties Account, First
				($Object | Get-Member -Name PSStandardMembers) | Should -Not -BeNullOrEmpty

			}

			It 'does not output the object when Passthru is false' {

				Add-ObjectDetail -InputObject $Object -TypeName 'SomeTypeName' -Passthru $false | Should -BeNullOrEmpty

			}

			It 'outputs the object when Passthru is true' {

				Add-ObjectDetail -InputObject $Object -TypeName 'SomeTypeName' -Passthru $true | Should -Not -BeNullOrEmpty

			}

		}

	}

}
