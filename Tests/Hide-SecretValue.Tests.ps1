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

Describe $FunctionName {

	InModuleScope $ModuleName {

		[array]$Secrets = @(
			"Secret",
			"Password",
			"NewCredentials",
			"NewPassword",
			"BindPassword",
			"InitialPassword"
		)

		$String = [pscustomobject]@{
			"Property"         = "Value"
			"Password"         = "SecretValue"
			"Secret"           = "DontShareThis"
			"NewCredentials"   = "S3cr3t"
			"NewPassword"      = "Password123!"
			"BindPassword"     = "ABCDE123!"
			"InitialPassword"  = "123456"
			"InnocentProperty" = "SomeValue"
		} | ConvertTo-Json

		It 'returns a string' {
			$ReturnData = Hide-SecretValue -InputValue $String -SecretsToRemove Property
			$ReturnData | Should BeOfType System.String

		}

		$Secrets | ForEach-Object {

			It "does not include $_ value in return data" {
				$ReturnData = Hide-SecretValue -InputValue $String -SecretsToRemove Property
				$ReturnData | ConvertFrom-Json | Select-Object -ExpandProperty $_ | Should Be "******"

			}

		}

		It 'does not return additional specified parameters' {
			$ReturnData = Hide-SecretValue -InputValue $String -SecretsToRemove Property
			$ReturnData | ConvertFrom-Json | Select-Object -ExpandProperty Property | Should Be "******"
		}

		It 'returns expected value' {
			$ReturnData = Hide-SecretValue -InputValue $String -SecretsToRemove Property
			$ReturnData | ConvertFrom-Json | Select-Object -ExpandProperty InnocentProperty | Should Be "SomeValue"
		}

	}

}