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

		BeforeEach {
			Mock Invoke-PASRestMethod -MockWith {

			}

			$InputObj = [pscustomobject]@{

				'AppID' = 'SomeApplication'

			}
		}
		Context 'Mandatory Parameters' {

			$Parameters = @{Parameter = 'AppID' },
			@{Parameter = 'path' },
			@{Parameter = 'hash' },
			@{Parameter = 'osUser' },
			@{Parameter = 'machineAddress' },
			@{Parameter = 'certificateserialnumber' }

			It 'specifies parameter <Parameter> as mandatory' -TestCases $Parameters {

				param($Parameter)

				(Get-Command Add-PASApplicationAuthenticationMethod).Parameters["$Parameter"].Attributes.Mandatory | Select-Object -Unique | Should -Be $true

			}

		}

		Context 'Input' {

			It 'sends request' {
				$InputObj | Add-PASApplicationAuthenticationMethod -path 'SomePath' -IsFolder $true -AllowInternalScripts $true
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				$InputObj | Add-PASApplicationAuthenticationMethod -path 'SomePath' -IsFolder $true -AllowInternalScripts $true

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/WebServices/PIMServices.svc/Applications/SomeApplication/Authentications/"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				$InputObj | Add-PASApplicationAuthenticationMethod -path 'SomePath' -IsFolder $true -AllowInternalScripts $true

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with expected AuthType for path authentication' {

				$InputObj | Add-PASApplicationAuthenticationMethod -path 'SomePath' -IsFolder $true -AllowInternalScripts $true

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody.authentication.AuthType) -eq 'path'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request with expected AuthType for hash authentication' {

				$InputObj | Add-PASApplicationAuthenticationMethod -hash 'SomeHash'

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody.authentication.AuthType) -eq 'hash'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request with expected AuthType for osUser authentication' {

				$InputObj | Add-PASApplicationAuthenticationMethod -osUser 'SomeUser'

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody.authentication.AuthType) -eq 'osUser'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request with expected AuthType for machineAddress authentication' {

				$InputObj | Add-PASApplicationAuthenticationMethod -machineAddress 'machineAddress'

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody.authentication.AuthType) -eq 'machineAddress'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request with expected AuthType for certificateserialnumber authentication' {

				$InputObj | Add-PASApplicationAuthenticationMethod -certificateserialnumber 'certificateserialnumber'

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody.authentication.AuthType) -eq 'certificateserialnumber'

				} -Times 1 -Exactly -Scope It

			}

			It 'sends request with expected AuthType for certificateattr authentication' {

				Add-PASApplicationAuthenticationMethod -AppID AppWebService -SubjectAlternativeName 'DNS Name=application.service'

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody.authentication.AuthType) -eq 'certificateattr'

				} -Times 1 -Exactly -Scope It

			}

		}

		Context 'Output' {

			It 'provides no output' {

				$response = $InputObj | Add-PASApplicationAuthenticationMethod -path 'SomePath' -IsFolder $true -AllowInternalScripts $true

				$response | Should -BeNullOrEmpty

			}

		}

	}

}