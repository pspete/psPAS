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

	Import-Module -Name "$ManifestPath" -Force -ErrorAction Stop

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

		Context "text/html responses" {

			$MockResult = [pscustomobject] @{

				"headers"    = @{
					"Content-Type" = "text/html"
				};
				"StatusCode" = 200;
				"content"    = '"Value"'
			}

			Mock Invoke-WebRequest -MockWith {

				return $MockResult
			}

			It "returns expected (unquoted) string for text/html responses" {
				$result = Invoke-PASRestMethod @requestArgs2
				$result | Should Be 'Value'
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
				$result | Should Be "Expected"
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