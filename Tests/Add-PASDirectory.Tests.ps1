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

if ( -not (Get-Module -Name $ModuleName -All)) {

	Import-Module -Name "$ManifestPath" -ArgumentList $true -Force -ErrorAction Stop

}

BeforeAll {

	$Script:RequestBody = $null
	$Script:BaseURI = "https://SomeURL/SomeApp"
	$Script:ExternalVersion = "0.0"
	$Script:WebSession = New-Object Microsoft.PowerShell.Commands.WebRequestSession

}

AfterAll {

	$Script:RequestBody = $null

}

Describe $FunctionName {

	InModuleScope $ModuleName {

		Context "Mandatory Parameters" {

			$Parameters = @{Parameter = 'DirectoryType' },
			@{Parameter = 'HostAddresses' },
			@{Parameter = 'DomainName' },
			@{Parameter = 'DomainBaseContext' }

			It "specifies parameter <Parameter> as mandatory" -TestCases $Parameters {

				param($Parameter)

				(Get-Command Add-PASDirectory).Parameters["$Parameter"].Attributes.Mandatory | Should Be $true

			}

		}

		Context "Input" {

			BeforeEach {
				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{"Prop1" = "Val1"; "Prop2" = "Val2" }
				}

				$InputObj = [pscustomobject]@{
					"DirectoryType"     = "SomeType.ini"
					"HostAddresses"     = "1.1.1.1", "2.2.2.2", "3.3.3.3"
					"DomainName"        = "SomeDomain"
					"DomainBaseContext" = "DC=Some,DC=Domain"
					"BindPassword"      = $(ConvertTo-SecureString "SomeNewPassword" -AsPlainText -Force)
					"BindUsername"      = "SomeUser"

				}

				$response = $InputObj | Add-PASDirectory -BindPassword $(ConvertTo-SecureString "SomeNewPassword" -AsPlainText -Force)

			}

			It "sends request" {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($Script:BaseURI)/api/Configuration/LDAP/Directories"

				} -Times 1 -Exactly -Scope It

			}

			It "uses expected method" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter { $Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It "sends request with expected body" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody) -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It "has a request body with expected number of properties" {

				($Script:RequestBody | Get-Member -MemberType NoteProperty).length | Should Be 6

			}

			It "throws error if version requirement not met" {
$Script:ExternalVersion = "1.0"
				$Script:ExternalVersion = "1.0"
				{ $InputObj | Add-PASDirectory } | Should Throw
				$Script:ExternalVersion = "0.0"
			}

		}

		Context "Output" {

			BeforeEach {
				Mock Invoke-PASRestMethod -MockWith {
					[PSCustomObject]@{"Prop1" = "Val1"; "Prop2" = "Val2" }
				}

				$InputObj = [pscustomobject]@{
					"DirectoryType"     = "SomeType.ini"
					"DCList"            = @{"Name" = "SomeName"; }
					"DomainName"        = "SomeDomain"
					"DomainBaseContext" = "DC=Some,DC=Domain"
					"BindPassword"      = $(ConvertTo-SecureString "SomeNewPassword" -AsPlainText -Force)
					"BindUsername"      = "SomeUser"

				}

				$response = $InputObj | Add-PASDirectory -BindPassword $(ConvertTo-SecureString "SomeNewPassword" -AsPlainText -Force)

			}

			it "provides output" {

				$response | Should not BeNullOrEmpty

			}

			It "has output with expected number of properties" {

				($response | Get-Member -MemberType NoteProperty).length | Should Be 2

			}

			it "outputs object with expected typename" {

				$response | get-member | select-object -expandproperty typename -Unique | Should Be psPAS.CyberArk.Vault.Directory.Extended

			}



		}

	}

}