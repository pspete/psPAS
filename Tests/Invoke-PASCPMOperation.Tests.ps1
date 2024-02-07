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
				Mock Invoke-PASRestMethod -MockWith { }

				$AccountID = 'SomeID'
				$Password = 'SomePassword' | ConvertTo-SecureString -AsPlainText -Force

				$Script:RequestBody = $null
				$Script:psPASSession.BaseURI = 'https://SomeURL/SomeApp'
				$psPASSession.ExternalVersion = '0.0'
				$psPASSession.WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession
			}

			It 'sends verify request to expected api endpoint' {

				Invoke-PASCPMOperation -AccountID $AccountID -VerifyTask

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Scope It -ParameterFilter {

					$URI -eq 'https://SomeURL/SomeApp/API/Accounts/SomeID/Verify'
				}

			}

			It 'sends verify request using expected method' {

				Invoke-PASCPMOperation -AccountID $AccountID -VerifyTask

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Scope It -ParameterFilter {

					$Method -eq 'POST'
				}

			}

			It 'sends verify request to expected classic api endpoint' {

				Invoke-PASCPMOperation -AccountID $AccountID -VerifyTask -UseClassicAPI

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Scope It -ParameterFilter {

					$URI -eq 'https://SomeURL/SomeApp/WebServices/PIMServices.svc/Accounts/SomeID/VerifyCredentials'
				}

			}

			It 'sends change request to expected api endpoint' {

				Invoke-PASCPMOperation -AccountID $AccountID -ChangeTask

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Scope It -ParameterFilter {

					$URI -eq 'https://SomeURL/SomeApp/API/Accounts/SomeID/Change'
				}

			}

			It 'sends change request using expected method' {

				Invoke-PASCPMOperation -AccountID $AccountID -ChangeTask

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Scope It -ParameterFilter {

					$Method -eq 'POST'
				}

			}

			It 'sends change request to expected classic api endpoint' {
				Invoke-PASCPMOperation -AccountID $AccountID -ChangeTask -ImmediateChangeByCPM 'Yes' -ChangeCredsForGroup 'No'

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Scope It -ParameterFilter {

					$URI -eq 'https://SomeURL/SomeApp/WebServices/PIMServices.svc/Accounts/SomeID/ChangeCredentials'
				}

			}

			It 'sends change request to classic api using expected method' {

				Invoke-PASCPMOperation -AccountID $AccountID -ChangeTask -ImmediateChangeByCPM 'Yes' -ChangeCredsForGroup 'No'

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Scope It -ParameterFilter {

					$Method -eq 'PUT'
				}

			}

			It 'sends change request, when specifying value, to expected api endpoint' {

				Invoke-PASCPMOperation -AccountID $AccountID -ChangeTask -ChangeImmediately $true -NewCredentials $Password

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Scope It -ParameterFilter {

					$URI -eq 'https://SomeURL/SomeApp/API/Accounts/SomeID/SetNextPassword'
				}

			}

			It 'sends change request, when specifying value, with expected method' {

				Invoke-PASCPMOperation -AccountID $AccountID -ChangeTask -ChangeImmediately $true -NewCredentials $Password

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Scope It -ParameterFilter {

					$Method -eq 'POST'
				}

			}

			It 'sends change request, when updating only the vault, to expected api endpoint' {

				Invoke-PASCPMOperation -AccountID $AccountID -ChangeTask -NewCredentials $Password

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Scope It -ParameterFilter {

					$URI -eq 'https://SomeURL/SomeApp/API/Accounts/SomeID/Password/Update'
				}

			}

			It 'sends change request, when updating only the vault, with expected method' {

				Invoke-PASCPMOperation -AccountID $AccountID -ChangeTask -NewCredentials $Password

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Scope It -ParameterFilter {

					$Method -eq 'POST'
				}

			}

			It 'sends reconcile request to expected api endpoint' {
				Invoke-PASCPMOperation -AccountID $AccountID -ReconcileTask

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Scope It -ParameterFilter {

					$URI -eq 'https://SomeURL/SomeApp/API/Accounts/SomeID/Reconcile'
				}

			}

			It 'sends reconcile request using expected method' {

				Invoke-PASCPMOperation -AccountID $AccountID -ReconcileTask

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Scope It -ParameterFilter {

					$Method -eq 'POST'
				}

			}

		}

	}

}