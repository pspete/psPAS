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
			[PSCustomObject]@{
				"CyberArkLogonResult" = "AAAAAAA\\\REEEAAAAALLLLYYYYY\\\\LOOOOONNNNGGGGG\\\ACCCCCEEEEEEEESSSSSSS\\\\\\TTTTTOOOOOKKKKKEEEEEN"
				"WebSession"          = New-Object Microsoft.PowerShell.Commands.WebRequestSession
			}
		}

		Mock Get-PASServer -MockWith {
			[PSCustomObject]@{
				ExternalVersion = "6.6.6"
			}
		}

		Context "Mandatory Parameters" {

			$Parameters = @{Parameter = 'BaseURI'}

			It "specifies parameter <Parameter> as mandatory" -TestCases $Parameters {

				param($Parameter)

				(Get-Command New-PASSharedSession).Parameters["$Parameter"].Attributes.Mandatory | Should Be $true

			}

		}

		$response = New-PASSharedSession -BaseURI "https://P_URI" -PVWAAppName "SomeApp"

		Context "Input" {

			It "sends request" {

				Assert-MockCalled Invoke-PASRestMethod -Times 1 -Exactly -Scope Describe

			}

			It "sends request to expected endpoint" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$URI -eq "https://P_URI/SomeApp/WebServices/auth/Shared/RestfulAuthenticationService.svc/Logon"

				} -Times 1 -Exactly -Scope Describe

			}

			It "uses expected method" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {$Method -match 'POST' } -Times 1 -Exactly -Scope Describe

			}

			It "sends request with expected body" {

				Assert-MockCalled Invoke-PASRestMethod -ParameterFilter {

					$Script:RequestBody = $Body | ConvertFrom-Json

					($Script:RequestBody) -ne $null

				} -Times 1 -Exactly -Scope Describe

			}

			It "has a request body with expected number of properties" {

				($Script:RequestBody | Get-Member -MemberType NoteProperty).length | Should Be 0

			}

			It "calls Get-PASServer" {

				$response = New-PASSharedSession -BaseURI "https://P_URI" -PVWAAppName "SomeApp"
				Assert-MockCalled Get-PASServer -Times 1 -Exactly -Scope It

			}

			It "skips version check" {

				$response = New-PASSharedSession -BaseURI "https://P_URI" -PVWAAppName "SomeApp" -SkipVersionCheck
				Assert-MockCalled Get-PASServer -Times 0 -Exactly -Scope It

			}

		}

		Context "Output" {

			it "provides output" {

				$response | Should not BeNullOrEmpty

			}

			It "has output with expected number of properties" {

				($response | Get-Member -MemberType NoteProperty).length | Should Be 5

			}

			it "outputs object with expected typename" {

				$response | get-member | select-object -expandproperty typename -Unique | Should Be System.Management.Automation.PSCustomObject

			}

			$DefaultProps = @{Property = 'sessionToken'},
			@{Property = 'WebSession'},
			@{Property = 'BaseURI'},
			@{Property = 'PVWAAppName'},
			@{Property = 'ExternalVersion'}

			It "returns default property <Property> in response" -TestCases $DefaultProps {
				param($Property)

				$response.$Property | Should Not BeNullOrEmpty

			}

			It "outputs sessionToken in expected format" {

				$response.sessiontoken.gettype() | Should be Hashtable

			}

			It "outputs sessionToken with expected key name" {

				$response.sessiontoken.keys | Should be "Authorization"

			}

			It "outputs sessionToken with expected value" {

				$response.sessiontoken["Authorization"] | Should be "AAAAAAA\\\REEEAAAAALLLLYYYYY\\\\LOOOOONNNNGGGGG\\\ACCCCCEEEEEEEESSSSSSS\\\\\\TTTTTOOOOOKKKKKEEEEEN"

			}

			It "outputs Version with expected value" {

				$response.ExternalVersion | Should be "6.6.6"

			}

			It "outputs Version in expected format" {

				$response.ExternalVersion.gettype() | Should be Version

			}

			It "outputs Version with expected value on SkipVersionCheck" {

				$response = New-PASSharedSession -BaseURI "https://P_URI" -PVWAAppName "SomeApp" -SkipVersionCheck
				$response.ExternalVersion | Should be "0.0"

			}

			It "outputs Version with expected value on Get-PASServer error" {
				Mock Get-PASServer -MockWith {
					throw "Some Error"
				}
				$response = New-PASSharedSession -BaseURI "https://P_URI" -PVWAAppName "SomeApp" -WarningAction SilentlyContinue
				$response.ExternalVersion | Should be "0.0"

			}

			It "throws error if authentication request fails" {

				Mock Invoke-PASRestMethod -MockWith {Write-Error -Message "Some Error" -ErrorId 12345}
				{New-PASSharedSession -BaseURI "https://P_URI" -ErrorAction Stop} | Should throw

			}

			It "returns no output if authentication request fails" {

				Mock Invoke-PASRestMethod -MockWith {Write-Error -Message "Some Error" -ErrorId 12345}
				New-PASSharedSession -BaseURI "https://P_URI" -ErrorAction SilentlyContinue | Should BeNullOrEmpty

			}

		}

	}

}