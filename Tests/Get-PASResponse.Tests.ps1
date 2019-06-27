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

		Context "Standard Operation" {

			BeforeEach {

				$JSONResponse = New-MockObject -Type Microsoft.PowerShell.Commands.WebResponseObject
				$JSONResponse | Add-Member -MemberType NoteProperty -Name StatusCode -Value 200 -Force
				$JSONResponse | Add-Member -MemberType NoteProperty -Name Headers -Value @{ "Content-Type" = 'application/json; charset=utf-8' } -Force
				$JSONResponse | Add-Member -MemberType NoteProperty -Name Content -Value (@{
						"prop1"   = "value1";
						"prop2"   = "value2";
						"prop123" = 123
						"test"    = 321
					} | ConvertTo-Json) -Force

				$TextResponse = New-MockObject -Type Microsoft.PowerShell.Commands.WebResponseObject
				$TextResponse | Add-Member -MemberType NoteProperty -Name StatusCode -Value 200 -Force
				$TextResponse | Add-Member -MemberType NoteProperty -Name Headers -Value @{ "Content-Type" = 'text/html; charset=utf-8' } -Force
				$TextResponse | Add-Member -MemberType NoteProperty -Name Content -Value '"Value"' -Force

				$HTMLResponse = New-MockObject -Type Microsoft.PowerShell.Commands.WebResponseObject
				$HTMLResponse | Add-Member -MemberType NoteProperty -Name StatusCode -Value 200 -Force
				$HTMLResponse | Add-Member -MemberType NoteProperty -Name Headers -Value @{ "Content-Type" = 'text/html; charset=utf-8' } -Force
				$HTMLResponse | Add-Member -MemberType NoteProperty -Name Content -Value '<HTML><HEAD><BODY><P>Test</P></BODY></HEAD></HTML>' -Force

				$ApplicationSave = New-MockObject -Type Microsoft.PowerShell.Commands.WebResponseObject
				$ApplicationSave | Add-Member -MemberType NoteProperty -Name StatusCode -Value 200 -Force
				$ApplicationSave | Add-Member -MemberType NoteProperty -Name Headers -Value @{ "Content-Type" = 'application/save' } -Force
				$ApplicationSave | Add-Member -MemberType NoteProperty -Name Content -Value $([System.Text.Encoding]::Ascii.GetBytes("Expected")) -Force

				$OctetStream = New-MockObject -Type Microsoft.PowerShell.Commands.WebResponseObject
				$OctetStream | Add-Member -MemberType NoteProperty -Name StatusCode -Value 200 -Force
				$OctetStream | Add-Member -MemberType NoteProperty -Name Headers -Value @{ "Content-Type" = 'application/octet-stream' } -Force
				$OctetStream | Add-Member -MemberType NoteProperty -Name Content -Value $([System.Text.Encoding]::Ascii.GetBytes("Expected")) -Force

			}

			It "returns expected number of properties" {
				$result = Get-PASResponse -APIResponse $JSONResponse
				($result | Get-Member -MemberType NoteProperty).length | Should Be 4
			}

			It "returns expected text value" {
				Get-PASResponse -APIResponse $TextResponse | Should Be "Value"
			}

			It "throws if HTML received" {
				{ Get-PASResponse -APIResponse $HTMLResponse } | Should -Throw
			}

			It "returns expected application-save value" {
				$result = Get-PASResponse -APIResponse $ApplicationSave
				$([System.Text.Encoding]::ASCII.GetString($result)) | Should Be "Expected"
			}

			It "returns expected octet-stream value" {
				$result = Get-PASResponse -APIResponse $OctetStream
				$([System.Text.Encoding]::ASCII.GetString($result)) | Should Be "Expected"
			}

		}

		Context New-PASSession {

			BeforeEach {

				Mock Get-ParentFunction -MockWith {

					[PSCustomObject]@{
						FunctionName = "New-PASSession"
					}

				}

				$RandomString = "ZDE0YTY3MzYtNTk5Ni00YjFiLWFhMWUtYjVjMGFhNjM5MmJiOzY0MjY0NkYyRkE1NjY3N0M7MDAwMDAwMDI4ODY3MDkxRDUzMjE3NjcxM0ZBODM2REZGQTA2MTQ5NkFCRTdEQTAzNzQ1Q0JDNkRBQ0Q0NkRBMzRCODcwNjA0MDAwMDAwMDA7"

				$ClassicToken = New-MockObject -Type Microsoft.PowerShell.Commands.WebResponseObject
				$ClassicToken | Add-Member -MemberType NoteProperty -Name StatusCode -Value 200 -Force
				$ClassicToken | Add-Member -MemberType NoteProperty -Name Headers -Value @{ "Content-Type" = 'application/json; charset=utf-8' } -Force
				$ClassicToken | Add-Member -MemberType NoteProperty -Name Content -Value $([PSCustomObject]@{CyberArkLogonResult = $RandomString } | ConvertTo-Json) -Force

				$V10Token = New-MockObject -Type Microsoft.PowerShell.Commands.WebResponseObject
				$V10Token | Add-Member -MemberType NoteProperty -Name StatusCode -Value 200 -Force
				$V10Token | Add-Member -MemberType NoteProperty -Name Headers -Value @{ "Content-Type" = 'application/json; charset=utf-8' } -Force
				$V10Token | Add-Member -MemberType NoteProperty -Name Content -Value $($RandomString | ConvertTo-Json) -Force

				$SharedToken = New-MockObject -Type Microsoft.PowerShell.Commands.WebResponseObject
				$SharedToken | Add-Member -MemberType NoteProperty -Name StatusCode -Value 200 -Force
				$SharedToken | Add-Member -MemberType NoteProperty -Name Headers -Value @{ "Content-Type" = 'application/json; charset=utf-8' } -Force
				$SharedToken | Add-Member -MemberType NoteProperty -Name Content -Value $([PSCustomObject]@{LogonResult = $RandomString } | ConvertTo-Json) -Force

			}

			It "returns expected Classic API Logon Token" {
				Get-PASResponse -APIResponse $ClassicToken | Select-Object -ExpandProperty CyberArkLogonResult | Should Be $RandomString
			}

			It "returns expected V10 API Logon Token" {
				Get-PASResponse -APIResponse $V10Token | Select-Object -ExpandProperty CyberArkLogonResult | Should Be $RandomString
			}

			It "returns expected Shared Authentication Logon Token" {
				Get-PASResponse -APIResponse $SharedToken | Select-Object -ExpandProperty CyberArkLogonResult | Should Be $RandomString
			}

		}

	}

}