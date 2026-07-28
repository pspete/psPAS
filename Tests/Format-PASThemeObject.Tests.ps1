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

			It 'nests an images property under images.main' {

				$Result = @{'mainBackgroundImage' = 'SomeImage' } | Format-PASThemeObject
				$Result['images']['main']['mainBackgroundImage'] | Should -Be 'SomeImage'

			}

			It 'nests a colorsStyle property under colors' {

				$Result = @{'colorsStyle' = 'SomeStyle' } | Format-PASThemeObject
				$Result['colors']['colorsStyle'] | Should -Be 'SomeStyle'

			}

			It 'nests a dark colour definition property, removing the _Dark suffix' {

				$Result = @{'backgroundMain_Dark' = 'SomeColor' } | Format-PASThemeObject
				$Result['colors']['definitionByType']['dark']['backgroundMain'] | Should -Be 'SomeColor'

			}

			It 'nests a bright colour definition property, removing the _Bright suffix' {

				$Result = @{'backgroundMain_Bright' = 'SomeColor' } | Format-PASThemeObject
				$Result['colors']['definitionByType']['bright']['backgroundMain'] | Should -Be 'SomeColor'

			}

			It 'nests a main colour property under colors.main' {

				$Result = @{'mainColor' = 'SomeColor' } | Format-PASThemeObject
				$Result['colors']['main']['mainColor'] | Should -Be 'SomeColor'

			}

			It 'nests a menu colour property under colors.menu' {

				$Result = @{'menuBackground' = 'SomeColor' } | Format-PASThemeObject
				$Result['colors']['menu']['menuBackground'] | Should -Be 'SomeColor'

			}

			It 'nests an advanced colour property under colors.advanced' {

				$Result = @{'borderMain' = 'SomeColor' } | Format-PASThemeObject
				$Result['colors']['advanced']['borderMain'] | Should -Be 'SomeColor'

			}

			It 'adds an unrecognised property at the top level' {

				$Result = @{'name' = 'SomeThemeName' } | Format-PASThemeObject
				$Result['name'] | Should -Be 'SomeThemeName'

			}

		}

	}

}
