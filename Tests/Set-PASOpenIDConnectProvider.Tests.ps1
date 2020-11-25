Describe $($PSCommandPath -Replace ".Tests.ps1") {

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
		$Script:BaseURI = "https://SomeURL/SomeApp"
		$Script:ExternalVersion = "0.0"
		$Script:WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

	}


	AfterAll {

		$Script:RequestBody = $null

	}

	InModuleScope $(Split-Path (Split-Path (Split-Path -Parent $PSCommandPath) -Parent) -Leaf ) {

		BeforeEach {
			$Script:ExternalVersion = "0.0"

			Mock Invoke-PASRestMethod -MockWith {
				[PSCustomObject]@{"Prop1" = "Val1"; "Prop2" = "Val2" }
			}

			$clientSecret = $("SomeClientSecret" | ConvertTo-SecureString -AsPlainText -Force)

			$InputObject = [PSCustomObject]@{

				id                   = "idValue"
				authenticationFlow   = "Code"
				discoveryEndpointUrl = "https://SomeValue"
				clientId             = "00000159875dgjut02f5"
				clientSecretMethod   = "Post"
				clientSecret         = $clientSecret
			}

			$response = $InputObject | Set-PASOpenIDConnectProvider

		}

		Context "Input" {

			It "sends request" {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:BaseURI)/api/Configuration/OIDC/Providers/idValue"

				} -Times 1 -Exactly -Scope It

			}

			It "uses expected method" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'PUT' } -Times 1 -Exactly -Scope It

			}

			It "sends request with expected body" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {
					$($Body | ConvertFrom-Json) -ne $null
				} -Times 1 -Exactly -Scope It

			}

			It "throws error if userNameClaim contains invalid characters" {
				{ $InputObject | Add-PASOpenIDConnectProvider -userNameClaim "abc_123-456" } | Should -Throw
			}

			It "throws error if version requirement not met" {
				$Script:ExternalVersion = "1.0"
				{ $InputObject | Set-PASOpenIDConnectProvider } | Should -Throw
				$Script:ExternalVersion = "0.0"
			}

		}

		Context "Output" {

			It "provides output" {

				$response | Should -Not -BeNullOrEmpty

			}

			It "has output with expected number of properties" {

				($response | Get-Member -MemberType NoteProperty).length | Should -Be 2

			}

		}

	}

}