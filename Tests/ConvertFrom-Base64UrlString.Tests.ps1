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

			$Parameters = @{Parameter = 'InputString' }

			It 'specifies parameter <Parameter> as mandatory' -TestCases $Parameters {

				param($Parameter)

				(Get-Command ConvertFrom-Base64UrlString).Parameters["$Parameter"].Attributes.Mandatory | Should -Be $true

			}

		}

		Context 'Base64Url Decoding' {

			It 'decodes Base64Url string without padding' {
				$base64Url = 'SGVsbG8gV29ybGQ'
				$result = ConvertFrom-Base64UrlString -InputString $base64Url
				$resultString = [System.Text.Encoding]::UTF8.GetString($result)
				$resultString | Should -Be 'Hello World'
			}

			It 'decodes Base64Url with URL-safe characters (dash and underscore)' {
				$base64Url = 'PDw_Pz8-Pg'
				$result = ConvertFrom-Base64UrlString -InputString $base64Url
				$result | Should -Not -BeNullOrEmpty
			}

			It 'handles padding correctly' {
				$base64Url = 'YWJj'
				$result = ConvertFrom-Base64UrlString -InputString $base64Url
				$resultString = [System.Text.Encoding]::UTF8.GetString($result)
				$resultString | Should -Be 'abc'
			}

			It 'converts Base64Url to byte array' {
				$base64Url = 'VGVzdA'
				$result = ConvertFrom-Base64UrlString -InputString $base64Url
				$result.GetType().BaseType.Name | Should -Be 'Array'
			}

		}

	}

}
