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

Describe $FunctionName {

	InModuleScope $ModuleName {

		$requestArgs1 = @{
			"URI"             = "https://CyberArk_URL"
			"Method"          = "GET"
			"SessionVariable" = "varSession"
		}

		$requestArgs2 = @{
			"URI"        = "https://CyberArk_URL"
			"Method"     = "GET"
			"WebSession" = New-Object Microsoft.PowerShell.Commands.WebRequestSession
		}

		Context "Standard Operation" {

			Mock Invoke-WebRequest -MockWith {

				return [pscustomobject]@{"StatusCode" = 201}

			}

			It "does not throw" {

				{Invoke-PASRestMethod @requestArgs2} | Should Not throw

			}

			#If Tls12 Security Protocol is available
			if([Net.SecurityProtocolType].GetEnumNames() -contains "Tls12") {

				It "uses TLS12" {
					[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls11
					Invoke-PASRestMethod @requestArgs2
					[System.Net.ServicePointManager]::SecurityProtocol | Should Be Tls12
				}

			}

		}

		Context "application/json responses" {

			Set-Variable varSession -Value "valSession"

			$MockResult = [pscustomobject] @{

				"headers"    = @{
					"Content-Type" = "application/json"
				};
				"StatusCode" = 200;
				"content"    = (@{
						"prop1"   = "value1";
						"prop2"   = "value2";
						"prop123" = 123
						"test"    = 321
					}| ConvertTo-Json)
			}

			Mock Invoke-WebRequest -MockWith {

				return $MockResult

			}

			It "sends a web request" {
				Invoke-PASRestMethod @requestArgs1
				Assert-MockCalled "Invoke-WebRequest" -Times 1 -Scope It -Exactly
			}

			It "returns expected number of properties when session variable is supplied" {
				$result = Invoke-PASRestMethod @requestArgs1
				($result | Get-Member -MemberType NoteProperty).length | Should Be 5
			}

			It "returns a websession" {
				$result = Invoke-PASRestMethod @requestArgs1
				$result.WebSession | Should Not BeNullOrEmpty
			}

			It "returns websession sessionvariable value" {
				$result = Invoke-PASRestMethod @requestArgs1
				$result.WebSession | Should Be "valSession"
			}

			It "returns expected number of properties when websession is supplied" {
				$result = Invoke-PASRestMethod @requestArgs2
				($result | Get-Member -MemberType NoteProperty).length | Should Be 4
			}

		}

		Context  "Version 10 Authentication" {

			$RandomString = "ZDE0YTY3MzYtNTk5Ni00YjFiLWFhMWUtYjVjMGFhNjM5MmJiOzY0MjY0NkYyRkE1NjY3N0M7MDAwMDAwMDI4ODY3MDkxRDUzMjE3NjcxM0ZBODM2REZGQTA2MTQ5NkFCRTdEQTAzNzQ1Q0JDNkRBQ0Q0NkRBMzRCODcwNjA0MDAwMDAwMDA7"

			$MockResult = [pscustomobject] @{

				"headers"    = @{
					"Content-Type" = "application/json"
				};
				"StatusCode" = 200;
				"content"    = $RandomString | ConvertTo-Json
			}

			Mock Get-ParentFunction -MockWith {

				[PSCustomObject]@{
					FunctionName = "New-PASSession"
				}

			}

			Mock Invoke-WebRequest -MockWith {

				return $MockResult

			}

			It "handles V10 authentication return value" {
				$result = Invoke-PASRestMethod @requestArgs2
				$result.CyberArkLogonResult | Should Be $RandomString
			}

		}

		Context "text/html responses" {

			$MockResult = [pscustomobject] @{

				"headers"    = @{
					"Content-Type" = "text/html"
				};
				"StatusCode" = 200;
				"content"    = '"Value"'
			}

			$MockHTML = [pscustomobject] @{

				"headers"    = @{
					"Content-Type" = "text/html"
				};
				"StatusCode" = 200;
				"content"    = '<HTML><HEAD><BODY><P>Test</P></BODY></HEAD></HTML>'
			}

			Mock Invoke-WebRequest -MockWith {

				return $MockResult
			}

			It "returns expected (unquoted) string for text/html responses" {
				$result = Invoke-PASRestMethod @requestArgs2
				$result | Should Be 'Value'
			}

			It 'throws an error if response contains actual HTML' {
				Mock Invoke-WebRequest -MockWith {

					return $MockHTML
				}

				{
					$ErrorActionPreference = "Stop"
					$request = Invoke-PASRestMethod @requestArgs2
				} | Should throw "Guru Meditation"

			}

		}

		Context "application/octet-save responses" {

			$MockResult = [pscustomobject] @{

				"headers"    = @{
					"Content-Type" = "application/save"
				};
				"StatusCode" = 200;
				"content"    = [System.Text.Encoding]::Ascii.GetBytes("Expected")
			}

			Mock Invoke-WebRequest -MockWith {

				return $MockResult
			}

			It "returns expected output for application/save responses" {
				$result = Invoke-PASRestMethod @requestArgs2

				$([System.Text.Encoding]::ASCII.GetString($result)) | Should Be "Expected"
			}

		}

		Context "application/octet-stream responses" {

			$MockResult = [pscustomobject] @{

				"headers"    = @{
					"Content-Type" = "application/octet-stream"
				};
				"StatusCode" = 200;
				"content"    = [System.Text.Encoding]::Ascii.GetBytes("Expected")
			}

			Mock Invoke-WebRequest -MockWith {

				return $MockResult
			}

			It "returns expected output for application/octet-stream responses" {
				$result = Invoke-PASRestMethod @requestArgs2

				$([System.Text.Encoding]::ASCII.GetString($result)) | Should Be "Expected"
			}

		}

		Context "Other Response" {

			$MockResult = [pscustomobject] @{
				"headers"    = @{
					"Pragma"         = "no-cache";
					"Content-Length" = 17
				};
				"StatusCode" = 200;
				"content"    = @("65", "99", "99", "101", "115", "115", "32", "105", "115", "32", "100", "101", "110", "105", "101", "100", "46")

			}

			Mock Invoke-WebRequest -MockWith {

				return $MockResult
			}

			It "throws other response" {
				{Invoke-PASRestMethod @requestArgs2} | Should throw "Access is denied."
			}

		}

		Context "Request Fail" {

			$requestArgs = @{
				"URI"        = "https://www.google.co.uk"
				"Method"     = "PUT"
				"WebSession" = New-Object Microsoft.PowerShell.Commands.WebRequestSession
			}

			It "outputs expected exception" {
				{
					$ErrorActionPreference = "Stop"
					Invoke-PASRestMethod @requestArgs
				} | Should throw
			}

			#Context "Error Output" {
			$ErrorActionPreference = "Stop"
			$ErrorMessage = "TestMessage"
			$ErrorCode = "12345"

			Mock Invoke-WebRequest -MockWith {

				throw [pscustomobject]@{"ErrorMessage" = $ErrorMessage; "ErrorCode" = $ErrorCode} | ConvertTo-Json
			}

			Try {
				Invoke-PASRestMethod @requestArgs
			} Catch {
				it "outputs expected error message" {
					$_.exception | should match $ErrorMessage
				}

				it "outputs expected error id" {

					$_.FullyQualifiedErrorId | should match $ErrorCode

				}
			}

		}

	}

}