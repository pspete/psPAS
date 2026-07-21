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

				$PrimaryObjects = @(
					[pscustomobject]@{'PlatformID' = 'Platform1'; 'Active' = $true },
					[pscustomobject]@{'PlatformID' = 'Platform2'; 'Active' = $false }
				)

				$SecondaryObjects = @(
					[pscustomobject]@{
						'general'  = [pscustomobject]@{'id' = 'Platform1'; 'name' = 'Platform One' }
						'nested'   = [pscustomobject]@{'ExtraProp' = 'ExtraValue1' }
					},
					[pscustomobject]@{
						'general'  = [pscustomobject]@{'id' = 'Platform2'; 'name' = 'Platform Two' }
						'nested'   = [pscustomobject]@{'ExtraProp' = 'ExtraValue2' }
					}
				)

			}

			It 'does not throw' {

				{ Join-ObjectByProperty -PrimaryObjects $PrimaryObjects -SecondaryObjects $SecondaryObjects -PrimaryKey 'PlatformID' -SecondaryKey 'general.id' } | Should -Not -Throw

			}

			It 'merges matching secondary objects using the secondary key' {

				$Result = Join-ObjectByProperty -PrimaryObjects $PrimaryObjects -SecondaryObjects $SecondaryObjects -PrimaryKey 'PlatformID' -SecondaryKey 'general.id'

				($Result | Where-Object { $_.PlatformID -eq 'Platform1' }).general.name | Should -Be 'Platform One'
				($Result | Where-Object { $_.PlatformID -eq 'Platform2' }).general.name | Should -Be 'Platform Two'

			}

			It 'does not merge secondary objects when the secondary key does not match' {

				$SecondaryObjects[0].general.id = 'NoMatch'

				$Result = Join-ObjectByProperty -PrimaryObjects $PrimaryObjects -SecondaryObjects $SecondaryObjects -PrimaryKey 'PlatformID' -SecondaryKey 'general.id'

				($Result | Where-Object { $_.PlatformID -eq 'Platform1' }).PSObject.Properties.Name | Should -Not -Contain 'nested'

			}

			It 'expands nested properties named in ExpandNested' {

				$Result = Join-ObjectByProperty -PrimaryObjects $PrimaryObjects -SecondaryObjects $SecondaryObjects -PrimaryKey 'PlatformID' -SecondaryKey 'general.id' -ExpandNested 'nested'

				($Result | Where-Object { $_.PlatformID -eq 'Platform1' }).ExtraProp | Should -Be 'ExtraValue1'
				($Result | Where-Object { $_.PlatformID -eq 'Platform1' }).PSObject.Properties.Name | Should -Not -Contain 'nested'

			}

			It 'preserves primary object property values over secondary object values' {

				$SecondaryObjects[0] | Add-Member -NotePropertyName 'PlatformID' -NotePropertyValue 'ShouldNotOverwrite'

				$Result = Join-ObjectByProperty -PrimaryObjects $PrimaryObjects -SecondaryObjects $SecondaryObjects -PrimaryKey 'PlatformID' -SecondaryKey 'general.id'

				($Result | Where-Object { $_.general.id -eq 'Platform1' }).PlatformID | Should -Be 'Platform1'

			}

			It 'returns flattened secondary objects when there are no primary objects' {

				$Result = Join-ObjectByProperty -PrimaryObjects $null -SecondaryObjects $SecondaryObjects -PrimaryKey 'PlatformID' -SecondaryKey 'general.id'

				$Result.Count | Should -Be 2
				($Result | Where-Object { $_.general.id -eq 'Platform1' }) | Should -Not -BeNullOrEmpty

			}

			It 'returns flattened secondary objects when PrimaryObjects.Total is 0' {

				$Result = Join-ObjectByProperty -PrimaryObjects $([pscustomobject]@{'Total' = 0 }) -SecondaryObjects $SecondaryObjects -PrimaryKey 'PlatformID' -SecondaryKey 'general.id'

				$Result.Count | Should -Be 2

			}

			It 'expands nested properties in the fallback path when there are no primary objects' {

				$Result = Join-ObjectByProperty -PrimaryObjects $null -SecondaryObjects $SecondaryObjects -PrimaryKey 'PlatformID' -SecondaryKey 'general.id' -ExpandNested 'nested'

				($Result | Where-Object { $_.general.id -eq 'Platform1' }).ExtraProp | Should -Be 'ExtraValue1'

			}

			It 'handles no secondary objects without throwing' {

				{ Join-ObjectByProperty -PrimaryObjects $PrimaryObjects -SecondaryObjects @() -PrimaryKey 'PlatformID' -SecondaryKey 'general.id' } | Should -Not -Throw

			}

			It 'returns primary objects unchanged when there are no secondary objects' {

				$Result = Join-ObjectByProperty -PrimaryObjects $PrimaryObjects -SecondaryObjects @() -PrimaryKey 'PlatformID' -SecondaryKey 'general.id'

				$Result.Count | Should -Be 2
				($Result | Where-Object { $_.PlatformID -eq 'Platform1' }).Active | Should -Be $true

			}

		}

	}

}
