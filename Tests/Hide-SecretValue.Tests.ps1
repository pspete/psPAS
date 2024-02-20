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

		Context	'General Tests' {
			BeforeEach {

				[array]$Secrets = @(
					'Secret',
					'Password',
					'NewCredentials',
					'NewPassword',
					'BindPassword',
					'InitialPassword'
				)

				$String = [pscustomobject]@{
					'Property'         = 'Value'
					'Password'         = 'SecretValue'
					'Secret'           = 'DontShareThis'
					'NewCredentials'   = 'S3cr3t'
					'NewPassword'      = 'Password123!'
					'BindPassword'     = 'ABCDE123!'
					'InitialPassword'  = '123456'
					'InnocentProperty' = 'SomeValue'
				} | ConvertTo-Json
			}

			It 'returns a string' {
				$ReturnData = Hide-SecretValue -InputValue $String -SecretsToRemove Property
				$ReturnData | Should -BeOfType System.String

			}


			It 'does not include <Parameter> value in return data' -TestCases @{Parameter = 'Secret' },
			@{Parameter = 'Password' },
			@{Parameter = 'NewCredentials' },
			@{Parameter = 'NewPassword' },
			@{Parameter = 'BindPassword' },
			@{Parameter = 'InitialPassword' } {
				$ReturnData = Hide-SecretValue -InputValue $String -SecretsToRemove Property
				$ReturnData | ConvertFrom-Json | Select-Object -ExpandProperty $Parameter | Should -Be '******'

			}

			It 'does not return additional specified parameters' {
				$ReturnData = Hide-SecretValue -InputValue $String -SecretsToRemove Property
				$ReturnData | ConvertFrom-Json | Select-Object -ExpandProperty Property | Should -Be '******'
			}

			It 'returns expected value' {
				$ReturnData = Hide-SecretValue -InputValue $String -SecretsToRemove Property
				$ReturnData | ConvertFrom-Json | Select-Object -ExpandProperty InnocentProperty | Should -Be 'SomeValue'
			}

		}
	}
}