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

		Context 'Mandatory Parameters' {

			$Parameters = @{Parameter = 'Date' }

			It 'specifies parameter <Parameter> as mandatory' -TestCases $Parameters {

				param($Parameter)

				(Get-Command ConvertTo-UnixTime).Parameters["$Parameter"].Attributes.Mandatory | Should -Be $true

			}

		}

		Context 'General' {

			It 'Converts date from pipeline' {
				$(Get-Date -Year 2020 -Month 01 -Day 01 -Hour 0 -Minute 0 -Second 0 -Millisecond 0) | ConvertTo-UnixTime | Should -Be 1577836800
			}

			It 'Converts date' {
				$date = $(Get-Date -Year 2020 -Month 01 -Day 01 -Hour 0 -Minute 0 -Second 0 -Millisecond 0)
				ConvertTo-UnixTime -Date $date | Should -Be 1577836800
			}

			It 'converts date to expected unixtime' {

				ConvertTo-UnixTime -Date $(Get-Date 1/1/2020) | Should -Be 1577836800

			}

			It 'converts date to expected unixtime in milliseconds' {

				ConvertTo-UnixTime -Date $(Get-Date 1/1/2020) -Milliseconds | Should -Be 1577836800000

			}

			It 'converts date to expected unixtime in milliseconds, even when locale is not en-US' {
				$currentCulture = [System.Threading.Thread]::CurrentThread.CurrentCulture
				[System.Threading.Thread]::CurrentThread.CurrentCulture = 'nl-NL'
				ConvertTo-UnixTime -Date $(Get-Date 1/1/2020) -Milliseconds | Should -Be 1577836800000
				[System.Threading.Thread]::CurrentThread.CurrentCulture = $currentCulture
			}

			It 'converts date to expected unixtime in milliseconds, even when locale is "SomeLocale"' {
				$currentCulture = [System.Threading.Thread]::CurrentThread.CurrentCulture
				[System.Threading.Thread]::CurrentThread.CurrentCulture = $(Get-Culture -ListAvailable |
						Select-Object -Index (Get-Random -Maximum $((Get-Culture -ListAvailable).Count)) |
						Select-Object -ExpandProperty Name)
				ConvertTo-UnixTime -Date $(Get-Date 1/1/2020) -Milliseconds | Should -Be 1577836800000
				[System.Threading.Thread]::CurrentThread.CurrentCulture = $currentCulture
			}

		}

	}

}