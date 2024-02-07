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
		#$psPASSession.ExternalVersion = '0.0'
	}

	InModuleScope $(Split-Path (Split-Path (Split-Path -Parent $PSCommandPath) -Parent) -Leaf ) {

		Context 'Standard Operation' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith { }

				Mock Get-PASAccount -MockWith {
					[PSCustomObject]@{
						UserName = 'SomeUser'
					}
				}

				$InputObject = [PSCustomObject]@{
					AccountID = 1234
				}

				$OctetStream = New-MockObject -Type Microsoft.PowerShell.Commands.WebResponseObject
				$OctetStream | Add-Member -MemberType NoteProperty -Name StatusCode -Value 200 -Force
				$OctetStream | Add-Member -MemberType NoteProperty -Name Headers -Value @{ 'Content-Type' = 'application/octet-stream' ; 'Content-Disposition' = 'attachment; filename=FILENAME.zip' } -Force
				$OctetStream | Add-Member -MemberType NoteProperty -Name Content -Value $([System.Text.Encoding]::Ascii.GetBytes('Expected')) -Force


			}

			It 'does not throw' {

				{ $InputObject | Get-PASAccountPassword } | Should -Not -Throw


			}

			It 'throws if version requirement not met' {
				$psPASSession.ExternalVersion = '1.1'

				{ $InputObject | Get-PASAccountPassword } | Should -Throw -ExpectedMessage 'CyberArk 1.1 does not meet the minimum version requirement of 10.1 for Get-PASAccountPassword (using ParameterSet: Gen2)'

				$psPASSession.ExternalVersion = '0.0'

			}

			It 'Returns expected response' {

				Mock Invoke-PASRestMethod -MockWith {
					Return '\\Expected' | ConvertTo-Json
				}

				$result = $InputObject | Get-PASAccountPassword

				$result.Password | Should -Be '\\Expected'

			}

			It 'Returns expected Classic API response' {

				Mock Invoke-PASRestMethod -MockWith {
					Return $OctetStream
				}

				$result = $InputObject | Get-PASAccountPassword -UseClassicAPI

				$result.Password | Should -Be 'Expected'

			}

		}

	}

}