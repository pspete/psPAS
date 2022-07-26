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

		Context 'Mandatory Parameters' {

			$Parameters = @{Parameter = 'Path' }

			It 'specifies parameter <Parameter> as mandatory' -TestCases $Parameters {

				param($Parameter)

				(Get-Command Get-ByteArray).Parameters["$Parameter"].Attributes.Mandatory | Should -Be $true

			}

		}

		Context 'General' {

			It 'outputs byte array of expected size' {

				if ($IsCoreCLR) {

					$(Get-ByteArray -Path "$PSCommandPath").Count | Should -Be (Get-Content "$PSCommandPath" -ReadCount 0 -AsByteStream).Count
				} Else { Set-ItResult -Inconclusive }
			}

		}

	}

}