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

		Context 'Output' {

			BeforeEach {
				$Credentials = New-Object System.Management.Automation.PSCredential ('SomeUser', $(ConvertTo-SecureString 'SomePassword' -AsPlainText -Force))
			}

			It 'returns password when no OTP is provided' {
				$result = Get-PASRadiusCredential -Credential $Credentials -OTPMode Append
				$result.Password | Should -Be 'SomePassword'
			}

			It 'appends OTP to password with comma by default' {
				$result = Get-PASRadiusCredential -Credential $Credentials -OTP 123456 -OTPMode Append
				$result.Password | Should -Be 'SomePassword,123456'
			}

			It 'appends OTP to password with specified delimiter' {
				$result = Get-PASRadiusCredential -Credential $Credentials -OTP 123456 -OTPMode Append -OTPDelimiter '#'
				$result.Password | Should -Be 'SomePassword#123456'
			}

			It 'appends OTP to password with empty delimiter' {
				$result = Get-PASRadiusCredential -Credential $Credentials -OTP 123456 -OTPMode Append -OTPDelimiter ''
				$result.Password | Should -Be 'SomePassword123456'
			}

			It 'returns password then OTP for Challenge mode' {
				$result = Get-PASRadiusCredential -Credential $Credentials -OTP 123456 -OTPMode Challenge
				$result.Password | Should -Be 'SomePassword'
				$result.OTP | Should -Be '123456'
			}

			It 'returns password then OTP for Challenge mode when RadiusChallenge is OTP' {
				$result = Get-PASRadiusCredential -Credential $Credentials -OTP 123456 -OTPMode Challenge -RadiusChallenge OTP
				$result.Password | Should -Be 'SomePassword'
				$result.OTP | Should -Be '123456'
			}

			It 'returns OTP then password for Challenge mode when RadiusChallenge is Password' {
				$result = Get-PASRadiusCredential -Credential $Credentials -OTP 123456 -OTPMode Challenge -RadiusChallenge Password
				$result.Password | Should -Be '123456'
				$result.OTP | Should -Be 'SomePassword'
			}

		}

	}

}
