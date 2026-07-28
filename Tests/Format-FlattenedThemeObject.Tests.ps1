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

				$NestedTheme = [PSCustomObject]@{
					name    = 'SomeTheme'
					isDraft = $true
					images  = [PSCustomObject]@{
						main = [PSCustomObject]@{
							mainBackgroundImage = 'SomeImage'
						}
					}
					colors  = [PSCustomObject]@{
						colorsStyle      = 'SomeStyle'
						definitionByType = [PSCustomObject]@{
							dark   = [PSCustomObject]@{ backgroundMain = 'DarkColor' }
							bright = [PSCustomObject]@{ backgroundMain = 'BrightColor' }
						}
						main             = [PSCustomObject]@{ mainColor = 'SomeMainColor' }
						menu             = [PSCustomObject]@{ menuBackground = 'SomeMenuColor' }
						advanced         = [PSCustomObject]@{ borderMain = 'SomeAdvancedColor' }
					}
				}

			}

			It 'flattens top level properties' {

				$Result = $NestedTheme | Format-FlattenedThemeObject
				$Result.name | Should -Be 'SomeTheme'
				$Result.isDraft | Should -Be $true
				$Result.colorsStyle | Should -Be 'SomeStyle'

			}

			It 'flattens image properties' {

				$Result = $NestedTheme | Format-FlattenedThemeObject
				$Result.mainBackgroundImage | Should -Be 'SomeImage'

			}

			It 'flattens dark colour definitions with a _Dark suffix' {

				$Result = $NestedTheme | Format-FlattenedThemeObject
				$Result.backgroundMain_Dark | Should -Be 'DarkColor'

			}

			It 'flattens bright colour definitions with a _Bright suffix' {

				$Result = $NestedTheme | Format-FlattenedThemeObject
				$Result.backgroundMain_Bright | Should -Be 'BrightColor'

			}

			It 'flattens main, menu and advanced colour sections' {

				$Result = $NestedTheme | Format-FlattenedThemeObject
				$Result.mainColor | Should -Be 'SomeMainColor'
				$Result.menuBackground | Should -Be 'SomeMenuColor'
				$Result.borderMain | Should -Be 'SomeAdvancedColor'

			}

			It 'returns a PSCustomObject by default' {

				$Result = $NestedTheme | Format-FlattenedThemeObject
				$Result | Should -BeOfType [PSCustomObject]

			}

			It 'returns a hashtable when AsHashtable is specified' {

				$Result = $NestedTheme | Format-FlattenedThemeObject -AsHashtable
				$Result | Should -BeOfType [hashtable]
				$Result.name | Should -Be 'SomeTheme'

			}

		}

	}

}
