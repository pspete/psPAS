#Requires -Modules Pester
<#
.SYNOPSIS
    Tests psPAS-specific conventions across the module.
.EXAMPLE
    Invoke-Pester
.NOTES
    The generic module tests come from pspete.Build (build/tests/Module.Tests.ps1).
    The built module is a single psm1 with no Public or Private folder, so Secure Value Handling finds no scripts to check against it.
#>

Describe 'Module' -Tag 'Consistency' {

	$ModuleName = 'psPAS'

	$ModulePath = Join-Path (Split-Path (Split-Path -Parent $PSCommandPath) -Parent) $ModuleName

	$Scripts = Get-ChildItem $ModulePath -Include *.ps1 -Recurse

	Context 'Secure Value Handling' -Tag 'SecureValueHandling' {

		#Any function which handles a SecureString or PSCredential value and builds a JSON request body
		#must convert that body to UTF8 bytes (not a String) before it is passed on, so that
		#Windows PowerShell ParameterBinding/Module Logging cannot capture the plaintext value.
		#See https://github.com/pspete/psPAS/issues/602

		Foreach ($Script in $Scripts) {

			$Content = Get-Content -Path $Script.FullName -Raw

			$HandlesSecureString = $Content -match '\[securestring\]|\[System\.Security\.SecureString\]|ConvertTo-InsecureString|GetNetworkCredential\(\)'
			$BuildsJsonBody = $Content -match 'ConvertTo-Json'

			if ($HandlesSecureString -and $BuildsJsonBody) {

				It "$($Script.Name) converts its request body to UTF8 bytes" -Tag "$($Script.BaseName)" -TestCases @{
					'Content' = $Content
				} {
					param($Content)

					$Content | Should -Match '\[System\.Text\.Encoding\]::UTF8\.GetBytes\('

				}

			}

		}

		#Secret values passed between module functions must be typed PSCredential or SecureString,
		#as ParameterBinding/Module Logging records String and Object parameter values as plain text.
		#Get-PASRadiusCredential -OTP receives the value bound to the public New-PASSession -OTP parameter.
		$Exempt = @('Get-PASRadiusCredential.ps1:OTP')

		Foreach ($Script in ($Scripts | Where-Object { $PSItem.Directory.Name -eq 'Private' })) {

			$Ast = [System.Management.Automation.Language.Parser]::ParseFile($Script.FullName, [ref]$null, [ref]$null)

			$SecretParameters = $Ast.FindAll( { $args[0] -is [System.Management.Automation.Language.ParameterAst] }, $true) |
				Where-Object { $PSItem.Name.VariablePath.UserPath -match '(Password|Token|Secret|Credential|OTP)$' } |
				Where-Object { "$($Script.Name):$($PSItem.Name.VariablePath.UserPath)" -notin $Exempt }

			Foreach ($Parameter in $SecretParameters) {

				It "$($Script.Name) parameter $($Parameter.Name) is typed PSCredential or SecureString" -Tag "$($Script.BaseName)" -TestCases @{
					'Type' = $Parameter.StaticType
				} {
					param($Type)

					$Type | Should -BeIn @([PSCredential], [SecureString])

				}

			}

		}

	}

}
