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

		Context 'Standard Operation' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{'Prop1' = 'Val1'; 'Prop2' = 'Val2' }
				}

				$InputObj = [pscustomobject]@{
					'DirectoryName' = 'SomeDirectory'
					'MappingID'     = 'SomeMappingID'
					'MappingName'   = 'SomeName'
					'LDAPBranch'    = 'SomeBranch'

				}

			}

			It 'sends request' {
				$InputObj | Set-PASDirectoryMapping -MappingAuthorizations AddUpdateUsers ActivateUsers
				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Scope It

			}

			It 'sends request to expected endpoint' {
				$InputObj | Set-PASDirectoryMapping -MappingAuthorizations AddUpdateUsers, ActivateUsers
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/api/Configuration/LDAP/Directories/SomeDirectory/Mappings/SomeMappingID/"

				} -Times 1 -Scope It

			}

			It 'uses expected method' {
				$InputObj | Set-PASDirectoryMapping -MappingAuthorizations AddUpdateUsers, ActivateUsers
				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'PUT' } -Times 1 -Exactly -Scope It

			}

			It 'throws error if version requirement not met' {
				$psPASSession.ExternalVersion = '1.0'
				{ $InputObj | Set-PASDirectoryMapping } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

			It 'throws error if version requirement not met' {
				$psPASSession.ExternalVersion = '10.9'
				{ $InputObj | Set-PASDirectoryMapping -UserActivityLogPeriod 10 } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

			It 'throws error if version requirement not met' {
				$psPASSession.ExternalVersion = '13.9'
				{ $InputObj | Set-PASDirectoryMapping -UsedQuota 10 } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

			It 'throws error if version requirement not met' {
				$psPASSession.ExternalVersion = '14.3'
				{ $InputObj | Set-PASDirectoryMapping -allowedAuthenticationMethods 'FIDO' } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'
			}

		}

		Context 'AuthorizedInterfaces ArgumentCompleter' {

			It 'provides ArgumentCompleter for AuthorizedInterfaces parameter' {

				(Get-Command Set-PASDirectoryMapping).Parameters['AuthorizedInterfaces'].Attributes |
				Where-Object { $_ -is [System.Management.Automation.ArgumentCompleterAttribute] } |
				Should -Not -BeNullOrEmpty

			}

			It 'returns matching client ids from Get-PASClientID' {

				Mock Get-PASClientID -MockWith { 'PVWA', 'PSM' }

				$Completer = (Get-Command Set-PASDirectoryMapping).Parameters['AuthorizedInterfaces'].Attributes |
				Where-Object { $_ -is [System.Management.Automation.ArgumentCompleterAttribute] } |
				Select-Object -ExpandProperty ScriptBlock

				$Result = & $Completer -commandName 'Set-PASDirectoryMapping' -parameterName 'AuthorizedInterfaces' -wordToComplete 'PV' -commandAst $null -fakeBoundParameters @{}

				$Result.CompletionText | Should -Be 'PVWA'

			}

			It 'returns nothing if Get-PASClientID throws' {

				Mock Get-PASClientID -MockWith { throw 'Some Error' }

				$Completer = (Get-Command Set-PASDirectoryMapping).Parameters['AuthorizedInterfaces'].Attributes |
				Where-Object { $_ -is [System.Management.Automation.ArgumentCompleterAttribute] } |
				Select-Object -ExpandProperty ScriptBlock

				{ & $Completer -commandName 'Set-PASDirectoryMapping' -parameterName 'AuthorizedInterfaces' -wordToComplete '' -commandAst $null -fakeBoundParameters @{} } | Should -Not -Throw

			}

		}

	}

}