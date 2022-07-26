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

		Context 'Standard Operation' {

			BeforeEach {

				$Script:BaseURI = 'https://SomeURL/SomeApp'
				$Script:ExternalVersion = '0.0'
				$Script:WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{'Detail1' = 'Detail'; 'Detail2' = 'Detail' }
				}
			}

			It 'sends request to V10' {
				Unblock-PASUser -id 123
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It -ParameterFilter {
					$URI -eq 'https://SomeURL/SomeApp/api/Users/123/Activate'
				}

			}

			It 'sends request to Classic API' {
				Unblock-PASUser -UserName MrFatFingers -Suspended $false
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It -ParameterFilter {
					$URI -eq 'https://SomeURL/SomeApp/WebServices/PIMServices.svc/Users/MrFatFingers/'
				}

			}


		}

	}

}