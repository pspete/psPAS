Function Hide-SecretValue {
	<#
    .SYNOPSIS
    Hide a secret value by converting it to "******"

    .DESCRIPTION
    Matches a pattern in a JSON formatted string which is expected to contain a secret value.
    Replaces all secret values with "******", and returns a sanitised string.
    Enables a request body to be included in debug/verbose streams without exposing secret values.

    .PARAMETER InputValue
    JSON body of API request

    .PARAMETER SecretsToRemove
    Any additional JSON properties which should be sanitised.

    .PARAMETER Secrets
    psPAS default JSON properties known to contain secrets

    .EXAMPLE
    Remove Secret Values from $String

    $String = [pscustomobject]@{
        "Property"="Value"
        "Password"="SecretValue"
        "Secret"="DoNotShareThis"
        "NewCredentials"="S3cr3t"
        "NewPassword"="Password123!"
        "BindPassword"="ABCDE123!"
        "InitialPassword"="123456"
        "InnocentProperty"="SomeValue"
    } | ConvertTo-Json

    Hide-SecretValue -InputValue $String

    {
        "Property":  "Value",
        "Password":  "******",
        "Secret":  "******",
        "NewCredentials":  "******",
        "NewPassword":  "******",
        "BindPassword":  "******",
        "InitialPassword":  "******",
        "InnocentProperty":  "SomeValue"
    }

    #>
	[CmdletBinding()]
	[OutputType('System.String')]
	param(
		[parameter(
			Position = 0,
			Mandatory = $true,
			ValueFromPipeline = $true)]
		[String]$InputValue,

		[parameter(
			Mandatory = $false)]
		[array]$SecretsToRemove = @(),

		[parameter(
			Mandatory = $false)]
		[array]$Secrets = @(
			'Secret',
			'Password',
			'NewCredentials',
			'NewPassword',
			'BindPassword',
			'InitialPassword',
			'clientSecret',
			'keyPassword',
			'defaultPassword'
		)
	)

	BEGIN {



	}#begin

	PROCESS {

		$InputValue | Set-Variable -Name OutputValue

		#Combine base parameters and any additional parameters to remove
		($SecretsToRemove + $Secrets) |

			ForEach-Object {

				$OutputValue -replace "(`"$_`":).+(`",?)", "`$1  `"******`$2" | Set-Variable -Name OutputValue

			}

	}#process

	END {

		#Return Output
		$OutputValue

	}#end

}