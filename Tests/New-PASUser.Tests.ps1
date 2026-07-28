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

			It 'specifies parameter UserName as mandatory for ParameterSet Gen1' {

				(Get-Command New-PASUser).Parameters['UserName'].ParameterSets['Gen1'].IsMandatory | Should -Be $true

			}

			It 'specifies parameter UserName as mandatory for ParameterSet Gen2' {

				(Get-Command New-PASUser).Parameters['UserName'].ParameterSets['Gen2'].IsMandatory | Should -Be $true

			}

			It 'specifies parameter InitialPassword as mandatory for ParameterSet Gen1' {

				(Get-Command New-PASUser).Parameters['InitialPassword'].ParameterSets['Gen1'].IsMandatory | Should -Be $true

			}

		}

		Context 'Input - Gen1' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{'Detail1' = 'Detail'; 'Detail2' = 'Detail' }
				}

				$InputObj = [pscustomobject]@{
					'UserName'        = 'SomeUser'
					'InitialPassword' = $('P_Password' | ConvertTo-SecureString -AsPlainText -Force)
					'FirstName'       = 'Some'
					'LastName'        = 'User'
					'ExpiryDate'      = '10/31/2018'

				}

				$response = $InputObj | New-PASUser -UseClassicAPI

			}

			It 'sends request' {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/WebServices/PIMServices.svc/Users"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with expected body' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json

					($Script:RequestBody) -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It 'has a request body with expected number of properties' {

				($Script:RequestBody | Get-Member -MemberType NoteProperty).length | Should -Be 5

			}

		}

		Context 'Input - Gen2' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{'Detail1' = 'Detail'; 'Detail2' = 'Detail' }
				}

				$InputObj = [pscustomobject]@{
					'UserName'                     = 'SomeUser'
					'InitialPassword'              = $('P_Password' | ConvertTo-SecureString -AsPlainText -Force)
					'FirstName'                    = 'Some'
					'LastName'                     = 'User'
					'ExpiryDate'                   = '10/31/2018'
					'workStreet'                   = 'SomeStreet'
					'homePage'                     = 'www.geocities.com'
					'faxNumber'                    = '1979'
					'userActivityLogRetentionDays' = 30
					'loginFromHour'                = 8
					'loginToHour'                  = 18

				}

				$response = $InputObj | New-PASUser

			}

			It 'sends request' {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It 'sends request to expected endpoint' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:psPASSession.BaseURI)/api/Users"

				} -Times 1 -Exactly -Scope It

			}

			It 'uses expected method' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It 'sends request with expected body' {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = [System.Text.Encoding]::UTF8.GetString($Body) | ConvertFrom-Json

					($Script:RequestBody) -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It 'has a request body with expected number of properties' {

				($Script:RequestBody | Get-Member -MemberType NoteProperty).length | Should -Be 10

			}

			It 'throws error if version requirement not met' {
				$psPASSession.ExternalVersion = '1.0'

				{ $InputObj | New-PASUser } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'

			}

			It 'throws error if allowedAuthenticationMethods version requirement not met' {
				$psPASSession.ExternalVersion = '14.3'

				{ New-PASUser -UserName TestUser -allowedAuthenticationMethods SAML,PKI } | Should -Throw
				$psPASSession.ExternalVersion = '0.0'

			}


		}

		Context 'Output' {

			BeforeEach {

				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{'Detail1' = 'Detail'; 'Detail2' = 'Detail' }
				}

				$InputObj = [pscustomobject]@{
					'UserName'        = 'SomeUser'
					'InitialPassword' = $('P_Password' | ConvertTo-SecureString -AsPlainText -Force)
					'FirstName'       = 'Some'
					'LastName'        = 'User'
					'ExpiryDate'      = '10/31/2018'

				}

				$response = $InputObj | New-PASUser -UseClassicAPI

			}

			It 'provides output' {

				$response | Should -Not -BeNullOrEmpty

			}

			It 'has output with expected number of properties' {

				($response | Get-Member -MemberType NoteProperty).length | Should -Be 2

			}

			It 'outputs object with expected typename' {

				$response | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.User

			}

			It 'outputs object with expected typename - Gen2' {
				$response = $InputObj | New-PASUser
				$response | Get-Member | Select-Object -ExpandProperty typename -Unique | Should -Be psPAS.CyberArk.Vault.User.Extended

			}



		}

		Context 'userType ArgumentCompleter' {

			It 'provides ArgumentCompleter for userType parameter' {

				(Get-Command New-PASUser).Parameters['userType'].Attributes |
				Where-Object { $_ -is [System.Management.Automation.ArgumentCompleterAttribute] } |
				Should -Not -BeNullOrEmpty

			}

			It 'returns matching user types from Get-PASUserType' {

				Mock Get-PASUserType -MockWith {
					[pscustomobject]@{UserTypeName = 'EPVUser' },
					[pscustomobject]@{UserTypeName = 'BasicUser' }
				}

				$Completer = (Get-Command New-PASUser).Parameters['userType'].Attributes |
				Where-Object { $_ -is [System.Management.Automation.ArgumentCompleterAttribute] } |
				Select-Object -ExpandProperty ScriptBlock

				$Result = & $Completer -commandName 'New-PASUser' -parameterName 'userType' -wordToComplete 'E' -commandAst $null -fakeBoundParameters @{}

				$Result.CompletionText | Should -Be 'EPVUser'

			}

			It 'returns nothing if Get-PASUserType throws' {

				Mock Get-PASUserType -MockWith { throw 'Some Error' }

				$Completer = (Get-Command New-PASUser).Parameters['userType'].Attributes |
				Where-Object { $_ -is [System.Management.Automation.ArgumentCompleterAttribute] } |
				Select-Object -ExpandProperty ScriptBlock

				{ & $Completer -commandName 'New-PASUser' -parameterName 'userType' -wordToComplete '' -commandAst $null -fakeBoundParameters @{} } | Should -Not -Throw

			}

		}

		Context 'unAuthorizedInterfaces ArgumentCompleter' {

			It 'provides ArgumentCompleter for unAuthorizedInterfaces parameter' {

				(Get-Command New-PASUser).Parameters['unAuthorizedInterfaces'].Attributes |
				Where-Object { $_ -is [System.Management.Automation.ArgumentCompleterAttribute] } |
				Should -Not -BeNullOrEmpty

			}

			It 'returns matching client ids from Get-PASClientID' {

				Mock Get-PASClientID -MockWith { 'PVWA', 'PSM' }

				$Completer = (Get-Command New-PASUser).Parameters['unAuthorizedInterfaces'].Attributes |
				Where-Object { $_ -is [System.Management.Automation.ArgumentCompleterAttribute] } |
				Select-Object -ExpandProperty ScriptBlock

				$Result = & $Completer -commandName 'New-PASUser' -parameterName 'unAuthorizedInterfaces' -wordToComplete 'PV' -commandAst $null -fakeBoundParameters @{}

				$Result.CompletionText | Should -Be 'PVWA'

			}

			It 'returns nothing if Get-PASClientID throws' {

				Mock Get-PASClientID -MockWith { throw 'Some Error' }

				$Completer = (Get-Command New-PASUser).Parameters['unAuthorizedInterfaces'].Attributes |
				Where-Object { $_ -is [System.Management.Automation.ArgumentCompleterAttribute] } |
				Select-Object -ExpandProperty ScriptBlock

				{ & $Completer -commandName 'New-PASUser' -parameterName 'unAuthorizedInterfaces' -wordToComplete '' -commandAst $null -fakeBoundParameters @{} } | Should -Not -Throw

			}

		}

		Context 'UserTypeName ArgumentCompleter' {

			It 'provides ArgumentCompleter for UserTypeName parameter' {

				(Get-Command New-PASUser).Parameters['UserTypeName'].Attributes |
				Where-Object { $_ -is [System.Management.Automation.ArgumentCompleterAttribute] } |
				Should -Not -BeNullOrEmpty

			}

			It 'returns matching user types from Get-PASUserType' {

				Mock Get-PASUserType -MockWith {
					[pscustomobject]@{UserTypeName = 'EPVUser' },
					[pscustomobject]@{UserTypeName = 'BasicUser' }
				}

				$Completer = (Get-Command New-PASUser).Parameters['UserTypeName'].Attributes |
				Where-Object { $_ -is [System.Management.Automation.ArgumentCompleterAttribute] } |
				Select-Object -ExpandProperty ScriptBlock

				$Result = & $Completer -commandName 'New-PASUser' -parameterName 'UserTypeName' -wordToComplete 'Basic' -commandAst $null -fakeBoundParameters @{}

				$Result.CompletionText | Should -Be 'BasicUser'

			}

		}

	}

}