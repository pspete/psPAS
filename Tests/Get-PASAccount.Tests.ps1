#Get Current Directory
$Here = Split-Path -Parent $MyInvocation.MyCommand.Path

#Get Function Name
$FunctionName = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -Replace ".Tests.ps1"

#Assume ModuleName from Repo Root folder
$ModuleName = Split-Path (Split-Path $Here -Parent) -Leaf

#Resolve Path to Module Directory
$ModulePath = Resolve-Path "$Here\..\$ModuleName"

#Define Path to Module Manifest
$ManifestPath = Join-Path "$ModulePath" "$ModuleName.psd1"

if( -not (Get-Module -Name $ModuleName -All)) {

	Import-Module -Name "$ManifestPath" -Force -ErrorAction Stop

}

BeforeAll {

	$Script:RequestBody = $null

}

AfterAll {

	$Script:RequestBody = $null

}

Describe $FunctionName {

	InModuleScope $ModuleName {

		Mock Invoke-PASRestMethod -MockWith {

			$result = [pscustomobject]@{
				"Count"    = 30
				"Accounts" = [pscustomobject]@{
					"AccountID"          = "66_6"
					"Properties"         = @(
						[pscustomobject]@{
							"Key"   = "Safe"
							"Value" = "zzTestSafe1"
						},
						[pscustomobject]@{
							"Key"   = "Folder"
							"Value" = "Root"
						},
						[pscustomobject]@{
							"Key"   = "Name"
							"Value" = "Operating System-_Test_WinDomain-VIRTUALREAL.IT-user01"
						},
						[pscustomobject]@{
							"Key"   = "UserName"
							"Value" = "user01"
						},
						[pscustomobject]@{
							"Key"   = "PolicyID"
							"Value" = "_Test_WinDomain"
						},
						[pscustomobject]@{
							"Key"   = "LogonDomain"
							"Value" = "VIRTUALREAL"
						},
						[pscustomobject]@{
							"Key"   = "LastSuccessVerification"
							"Value" = "1511973510"
						},
						[pscustomobject]@{
							"Key"   = "Address"
							"Value" = "VIRTUALREAL.IT"
						},
						[pscustomobject]@{
							"Key"   = "DeviceType"
							"Value" = "Operating System"
						}
					)
					"InternalProperties" = @(
						[pscustomobject]@{
							"Key"   = "CPMStatus"
							"Value" = "success"
						},
						[pscustomobject]@{
							"Key"   = "SequenceID"
							"Value" = "1"
						},
						[pscustomobject]@{
							"Key"   = "CreationMethod"
							"Value" = "PVWA"
						},
						[pscustomobject]@{
							"Key"   = "RetriesCount"
							"Value" = "-1"
						},
						[pscustomobject]@{
							"Key"   = "LastSuccessChange"
							"Value" = "1516127648"
						},
						[pscustomobject]@{
							"Key"   = "LastTask"
							"Value" = "ChangeTask"
						}
					)
				}
			}
			return $result

		}

		$InputObj = [pscustomobject]@{
			"sessionToken" = @{"Authorization" = "P_AuthValue"}
			"WebSession"   = New-Object Microsoft.PowerShell.Commands.WebRequestSession
			"BaseURI"      = "https://P_URI"
			"PVWAAppName"  = "P_App"
			"Keywords"     = "SomeValue"
			"Safe"         = "SomeSafe"
		}

		Context "Mandatory Parameters" {
			$Parameters = @{Parameter = 'BaseURI'},
			@{Parameter = 'SessionToken'}

			It "specifies parameter <Parameter> as mandatory" -TestCases $Parameters {
				param($Parameter)

				{((Get-Command $FunctionName).Parameters["$Parameter"].Attributes).Mandatory} |
					Should Be $true

			}

		}

		$response = $InputObj | Get-PASAccount -WarningVariable warning -WarningAction SilentlyContinue

		Context "Request Input" {

			It "sends request" {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope Describe

			}

			It "sends request to expected endpoint" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($InputObj.BaseURI)/$($InputObj.PVWAAppName)/WebServices/PIMServices.svc/Accounts?Keywords=SomeValue&Safe=SomeSafe"

				} -Times 1 -Exactly -Scope Describe

			}

			It "sends request using expected method" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {$Method -match 'GET' } -Times 1 -Exactly -Scope Describe

			}

			It "sends request with no body" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {$Body -eq $null} -Times 1 -Exactly -Scope Describe

			}

		}

		Context "Response Output" {

			it "provides output" {

				$response | Should not be null

			}

			It "has output with expected number of properties" {

				($response | Get-Member -MemberType NoteProperty).length | Should Be 14

			}

			it "outputs object with expected typename" {

				$response | get-member | select-object -expandproperty typename -Unique | Should Be psPAS.CyberArk.Vault.Account

			}

			it "writes warning that more than 1 account returned from the search" {

				$warning | Should be "30 matching accounts found. Only the first result will be returned"

			}

			$DefaultProps = @{Property = 'sessionToken'},
			@{Property = 'WebSession'},
			@{Property = 'BaseURI'},
			@{Property = 'PVWAAppName'}

			It "returns default property <Property> in response" -TestCases $DefaultProps {
				param($Property)

				$response.$Property | Should Not BeNullOrEmpty

			}

		}

	}

}