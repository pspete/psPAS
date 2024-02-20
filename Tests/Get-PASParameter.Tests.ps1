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

		Context 'General Tests' {

			BeforeEach {

				[array]$CommonParameters = [System.Management.Automation.PSCmdlet]::CommonParameters
				[array]$CommonParameters += [System.Management.Automation.PSCmdlet]::OptionalCommonParameters
				[array]$CommonParameters = $CommonParameters | Select-Object -Unique
				[hashtable]$InputParams = @{'KeepThis' = 'Kept'; 'RemoveThis' = 'Removed' }
				$CommonParameters | ForEach-Object { $InputParams.Add($PSItem, 'something') }
				$ReturnData = $InputParams | Get-PASParameter -ParametersToRemove RemoveThis

			}

			It 'returns a hashtable' {

				$ReturnData | Should -BeOfType System.Collections.Hashtable

			}

			$CommonParameters | ForEach-Object {

				It "does not include $_ in return data" {

					$ReturnData.keys | Should -Not -Contain $_
				}

			}

			It 'does not return additional specified parameters' {
				$ReturnData['RemoveThis'] | Should -BeNullOrEmpty
			}

			It 'returns expected value' {
				$ReturnData['KeepThis'] | Should -Be 'Kept'
			}

		}
	}
}