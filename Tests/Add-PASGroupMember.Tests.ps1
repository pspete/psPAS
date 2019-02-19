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

		Mock Invoke-PASRestMethod -MockWith {
			Write-Output "Added"
		}

		$InputObj = [pscustomobject]@{
			"sessionToken" = @{"Authorization" = "P_AuthValue"}
			"WebSession"   = New-Object Microsoft.PowerShell.Commands.WebRequestSession
			"BaseURI"      = "https://P_URI"
			"PVWAAppName"  = "P_App"
			"GroupName"    = "SomeGroup"
			"UserName"     = "SomeUser"

		}

		$InputObjV10 = [pscustomobject]@{
			"memberId"     = "someName"
			"memberType"   = "domain"
			"domainName"   = "SomeDomain"
			"groupId"      = "1234"
			"sessionToken" = @{"Authorization" = "P_AuthValue"}
			"WebSession"   = New-Object Microsoft.PowerShell.Commands.WebRequestSession
			"BaseURI"      = "https://P_URI"
			"PVWAAppName"  = "P_App"
		}

		Context "Mandatory Parameters" {

			$Parameters = @{Parameter = 'BaseURI'},
			@{Parameter = 'SessionToken'},
			@{Parameter = 'GroupName'},
			@{Parameter = 'UserName'}

			It "specifies parameter <Parameter> as mandatory" -TestCases $Parameters {

				param($Parameter)

				(Get-Command Add-PASGroupMember).Parameters["$Parameter"].Attributes.Mandatory | Should Be $true

			}

		}

		#$response = $InputObj | Add-PASGroupMember

		Context "Input" {

			It "sends request" {

				$InputObj | Add-PASGroupMember

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint" {

				$InputObj | Add-PASGroupMember

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($InputObj.BaseURI)/$($InputObj.PVWAAppName)/WebServices/PIMServices.svc/Groups/SomeGroup/Users"

				} -Times 1 -Exactly -Scope It

			}

			It "sends request to expected endpoint - V10" {

				$InputObjV10 | Add-PASGroupMember

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "$($InputObjV10.BaseURI)/$($InputObjV10.PVWAAppName)/API/UserGroups/$($InputObjV10.groupId)/Members"

				} -Times 1 -Exactly -Scope It

			}

			It "uses expected method" {

				$InputObj | Add-PASGroupMember

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {$Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It "uses expected method - V10" {

				$InputObjV10 | Add-PASGroupMember

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {$Method -match 'POST' } -Times 1 -Exactly -Scope It

			}

			It "sends request with expected body" {

				$InputObj | Add-PASGroupMember

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody) -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It "has a request body with expected number of properties" {

				($Script:RequestBody | Get-Member -MemberType NoteProperty).length | Should Be 1

			}

			It "sends request with expected body - v10" {

				$InputObjV10 | Add-PASGroupMember

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody) -ne $null

				} -Times 1 -Exactly -Scope It

			}

			It "has a request body with expected number of properties - V10" {

				($Script:RequestBody | Get-Member -MemberType NoteProperty).length | Should Be 3

			}

			It "throws error if version requirement not met" {

				{$InputObjV10 | Add-PASGroupMember -ExternalVersion "1.0"} | Should Throw

			}

		}

		Context "Output" {

			it "provides output" {
				$response = $InputObj | Add-PASGroupMember
				$response | Should not BeNullOrEmpty

			}

		}

	}

}