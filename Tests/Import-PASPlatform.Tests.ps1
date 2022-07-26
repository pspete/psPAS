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

		BeforeEach {
			Mock Invoke-PASRestMethod -MockWith {
				[PSCustomObject]@{'PlatformID' = 'SomePlatform' }
			}

			#Create a 512b file to test with
			$file = [System.IO.File]::Create("$env:Temp\testPlatform.zip")
			$file.SetLength(0.5kb)
			$file.Close()

			$response = Import-PASPlatform -ImportFile $($file.name)

		}

		Context 'Mandatory Parameters' {

			$Parameters = @{Parameter = 'ImportFile' }

			It 'specifies parameter <Parameter> as mandatory' -TestCases $Parameters {

				param($Parameter)

				(Get-Command Import-PASPlatform).Parameters["$Parameter"].Attributes.Mandatory | Should -Be $true

			}

		}



		Context 'Input' {

			It 'throws if InputFile does not exist' {
				{ Import-PASPlatform -ImportFile SomeFile.txt } | Should -Throw
			}

			It 'throws if InputFile resolves to a folder' {
				{ Import-PASPlatform -ImportFile $pwd } | Should -Throw
			}

			It 'throws if InputFile does not have a zip extention' {
				{ Import-PASPlatform -ImportFile README.MD } | Should -Throw
			}

			It 'sends request' {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:BaseURI)/API/Platforms/Import"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with expected body' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody.ImportFile) -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It 'has a request body with expected number of properties' {

				($Script:RequestBody | Get-Member -MemberType NoteProperty).length | Should -Be 1

			}

			It 'has body content of expected length' {

				($Script:RequestBody.ImportFile).length | Should -Be 512

			}

			It 'throws error if version requirement not met' {
				$Script:ExternalVersion = '1.0'
				{ Import-PASPlatform -ImportFile $($file.name) } | Should -Throw
				$Script:ExternalVersion = '0.0'
			}


		}

		Context 'Output' {

			It 'provides output' {

				$response | Should -Not -BeNullOrEmpty

			}

			It 'has output with expected number of properties' {

				($response | Get-Member -MemberType NoteProperty).length | Should -Be 1

			}

			It 'outputs object with expected typename' {

				$response | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be System.Management.Automation.PSCustomObject

			}



		}

	}

}