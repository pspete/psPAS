#Get Current Directory
$Here = Split-Path -Parent $MyInvocation.MyCommand.Path

#Get Function Name
$FunctionName = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -Replace ".Tests.ps1"

#Assume ModuleName from Repository Root folder
$ModuleName = Split-Path (Split-Path $Here -Parent) -Leaf

#Resolve Path to Module Directory
$ModulePath = Resolve-Path "$Here\..\$ModuleName"

#Define Path to Module Manifest
$ManifestPath = Join-Path "$ModulePath" "$ModuleName.psd1"

if( -not (Get-Module -Name $ModuleName -All)) {

	Import-Module -Name "$ManifestPath" -ArgumentList $true -Force -ErrorAction Stop

}

BeforeAll {

	$Script:RequestBody = $null

}

AfterAll {

	$Script:RequestBody = $null

}

Describe $FunctionName {

	InModuleScope $ModuleName {

		Context "Mandatory Parameters" {

			$Parameters = @{Parameter = 'BaseURI'},
			@{Parameter = 'SessionToken'},
			@{Parameter = 'password'}

			It "specifies parameter <Parameter> as mandatory" -TestCases $Parameters {

				param($Parameter)

				(Get-Command Add-PASAccount).Parameters["$Parameter"].Attributes.Mandatory | Should Be $true

			}

			It "specifies parameter userName as mandatory for ParameterSet V9" {

				(Get-Command Add-PASAccount).Parameters["UserName"].ParameterSets["V9"].IsMandatory | Should be $true

			}
			It "specifies parameter SafeName as mandatory for ParameterSet V9" {

				(Get-Command Add-PASAccount).Parameters["SafeName"].ParameterSets["V9"].IsMandatory | Should be $true

			}
			It "specifies parameter SafeName as mandatory for ParameterSet V10" {

				(Get-Command Add-PASAccount).Parameters["SafeName"].ParameterSets["V10"].IsMandatory | Should be $true

			}
			It "specifies parameter platformID as mandatory for ParameterSet V9" {

				(Get-Command Add-PASAccount).Parameters["platformID"].ParameterSets["V9"].IsMandatory | Should be $true

			}
			It "specifies parameter platformID as mandatory for ParameterSet V10" {

				(Get-Command Add-PASAccount).Parameters["platformID"].ParameterSets["V10"].IsMandatory | Should be $true

			}

		}

		Context "Input" {

			BeforeEach {

				$secureString = $("P_Password" | ConvertTo-SecureString -AsPlainText -Force)
				Mock Invoke-PASRestMethod -MockWith {
					Write-Output @{}
				}

				$InputObj = [pscustomobject]@{
					"safeName"              = "P_Safe"
					"platformID"            = "P_Platform"
					"password"              = $secureString
					"userName"              = "P_UserName"
					"sessionToken"          = @{"Authorization" = "P_AuthValue"}
					"WebSession"            = New-Object Microsoft.PowerShell.Commands.WebRequestSession
					"BaseURI"               = "https://P_URI"
					"PVWAAppName"           = "P_App"
					"Port"                  = 1234
					"ExtraPass1Name"        = "P_ExtP1"
					"DynamicProperties"     = @{"TestKey" = "TestVal"; "TestKey1" = "TestVal"; "TestKey2" = "TestVal"}
					"address"               = "10.10.10.10"
					"accountName"           = "SomeName"
					"disableAutoMgmt"       = $true
					"disableAutoMgmtReason" = "SomeReason"
					"groupName"             = "SomeGroup"
					"groupPlatformID"       = "GPlatform"
					"ExtraPass1Folder"      = "Root"
					"ExtraPass1Safe"        = "Safe1"
					"ExtraPass3Name"        = "SomeName"
					"ExtraPass3Folder"      = "Root"
					"ExtraPass3Safe"        = "SomeSafe"
				}

				$InputObjV10 = [pscustomobject]@{
					"address"                          = "someaddress"
					"SafeName"                         = "SomeSafe"
					"PlatformID"                       = "SomePlatform"
					"userName"                         = "SomeUser"
					"secret"                           = $secureString
					"sessionToken"                     = @{"Authorization" = "P_AuthValue"}
					"WebSession"                       = New-Object Microsoft.PowerShell.Commands.WebRequestSession
					"BaseURI"                          = "https://P_URI"
					"PVWAAppName"                      = "P_App"
					"automaticManagementEnabled"       = $true
					"remoteMachines"                   = "someMachine"
					"accessRestrictedToRemoteMachines" = $false
				}

			}

			It "sends request" {

				$InputObj | Add-PASAccount

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint - V9 ParameterSet" {

				$InputObj | Add-PASAccount

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($InputObj.BaseURI)/$($InputObj.PVWAAppName)/WebServices/PIMServices.svc/Account"

				} -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint - V10 ParameterSet" {

				$InputObjV10 | Add-PASAccount

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($InputObj.BaseURI)/$($InputObj.PVWAAppName)/api/Accounts"

				} -Times 1 -Exactly -Scope It

			}

			It "uses expected method" {

				$InputObj | Add-PASAccount

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {$Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It "sends request with expected body - V9 ParameterSet" {

				$InputObj | Add-PASAccount

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					($Body | ConvertFrom-Json | Select-Object -ExpandProperty Account) -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It "has a request body with expected number of properties - V9 ParameterSet" {

				$InputObj | Add-PASAccount

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {
					($Body | ConvertFrom-Json | Select-Object -ExpandProperty Account | Get-Member -MemberType NoteProperty).length -eq 11
				} -Times 1 -Exactly -Scope It
			}

			It "has expected number of nested properties - V9 ParameterSet" {
				$InputObj | Add-PASAccount

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					($Body | ConvertFrom-Json | Select-Object -ExpandProperty Account | Select-Object -ExpandProperty Properties).count -eq 10

				} -Times 1 -Exactly -Scope It
			}

			It "sends request with expected body - V10 ParameterSet" {

				$InputObjV10 | Add-PASAccount

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					($Body | ConvertFrom-Json) -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It "has a request body with expected number of properties - V10 ParameterSet" {

				$InputObjV10 | Add-PASAccount

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {
					($Body | ConvertFrom-Json | Get-Member -MemberType NoteProperty).length -eq 7
				} -Times 1 -Exactly -Scope It

			}

			It "has expected number of RemoteMachine nested properties - V10 ParameterSet" {
				$InputObjV10 | Add-PASAccount

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					($Body | ConvertFrom-Json | Select-Object -ExpandProperty remoteMachinesAccess | Get-Member -MemberType NoteProperty).length -eq 2

				} -Times 1 -Exactly -Scope It

			}

			It "has expected number of secretManagement nested properties - V10 ParameterSet" {

				$InputObjV10 | Add-PASAccount

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					($Body | ConvertFrom-Json | Select-Object -ExpandProperty secretManagement | Get-Member -MemberType NoteProperty).length -eq 1

				} -Times 1 -Exactly -Scope It

			}

			It "throws error if version requirement not met" {

				{$InputObjV10 | Add-PASAccount -ExternalVersion "1.0"} | Should Throw

			}

		}

		Context "Output" {

			BeforeEach {

				$secureString = $("P_Password" | ConvertTo-SecureString -AsPlainText -Force)
				Mock Invoke-PASRestMethod -MockWith {
					$result = [pscustomobject]@{
						"Prop1" = "Val1"
						"Prop2" = "Val2"
						"Prop3" = "Val3"
					}

					$result
				}

				$InputObj = [pscustomobject]@{
					"address"                    = "someaddress"
					"SafeName"                   = "SomeSafe"
					"PlatformID"                 = "SomePlatform"
					"userName"                   = "SomeUser"
					"secret"                     = $secureString
					"sessionToken"               = @{"Authorization" = "P_AuthValue"}
					"WebSession"                 = New-Object Microsoft.PowerShell.Commands.WebRequestSession
					"BaseURI"                    = "https://P_URI"
					"PVWAAppName"                = "P_App"
					"automaticManagementEnabled" = $true
					"remoteMachines"             = "someMachine"
				}

			}

			it "provides no output - V9 ParameterSet" {

				$InputObj = [pscustomobject]@{
					"safeName"              = "P_Safe"
					"platformID"            = "P_Platform"
					"password"              = $secureString
					"userName"              = "P_UserName"
					"sessionToken"          = @{"Authorization" = "P_AuthValue"}
					"WebSession"            = New-Object Microsoft.PowerShell.Commands.WebRequestSession
					"BaseURI"               = "https://P_URI"
					"PVWAAppName"           = "P_App"
					"Port"                  = 1234
					"ExtraPass1Name"        = "P_ExtP1"
					"DynamicProperties"     = @{"TestKey" = "TestVal"; "TestKey1" = "TestVal"; "TestKey2" = "TestVal"}
					"address"               = "10.10.10.10"
					"accountName"           = "SomeName"
					"disableAutoMgmt"       = $true
					"disableAutoMgmtReason" = "SomeReason"
					"groupName"             = "SomeGroup"
					"groupPlatformID"       = "GPlatform"
					"ExtraPass1Folder"      = "Root"
					"ExtraPass1Safe"        = "Safe1"
					"ExtraPass3Name"        = "SomeName"
					"ExtraPass3Folder"      = "Root"
					"ExtraPass3Safe"        = "SomeSafe"
				}
				$response = $InputObj | Add-PASAccount
				$response | Should BeNullOrEmpty

			}

			it "provides output - V10 ParameterSet" {
				$response = $InputObj | Add-PASAccount
				$response | Should Not BeNullOrEmpty

			}

			it "outputs object with expected typename - v10 parameterset" {
				Mock Invoke-PASRestMethod -MockWith {
					[pscustomobject]@{
						"Count" = 30
						"Value" = [pscustomobject]@{"Prop1" = "Val1"}
					}
				}
				$response = $InputObj | Add-PASAccount
				$response | get-member | select-object -expandproperty typename -Unique | Should Be psPAS.CyberArk.Vault.Account.V10

			}

			$DefaultProps = @{Property = 'sessionToken'},
			@{Property = 'WebSession'},
			@{Property = 'BaseURI'},
			@{Property = 'PVWAAppName'},
			@{Property = 'ExternalVersion'}

			It "returns default property <Property> in V10 response" -TestCases $DefaultProps {
				param($Property)

				$($InputObj | Add-PASAccount).$Property | Should Not BeNullOrEmpty

			}

		}

	}

}