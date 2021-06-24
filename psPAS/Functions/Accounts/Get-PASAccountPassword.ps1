# .ExternalHelp psPAS-help.xml
function Get-PASAccountPassword {
	[CmdletBinding(DefaultParameterSetName = "Gen2")]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "Gen1"
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "Gen2"
		)]
		[Alias("id")]
		[string]$AccountID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "Gen1"
		)]
		[Alias("UseClassicAPI")]
		[switch]$UseGen1API,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "Gen2"
		)]
		[string]$Reason,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "Gen2"
		)]
		[string]$TicketingSystem,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "Gen2"
		)]
		[string]$TicketId,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "Gen2"
		)]
		[int]$Version,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "Gen2"
		)]
		[ValidateSet("show", "copy", "connect")]
		[string]$ActionType,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "Gen2"
		)]
		[boolean]$isUse,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = "Gen2"
		)]
		[switch]$Machine,
		[switch]$AsPsCredential,
		[parameter(ValueFromPipelinebyPropertyName = $true)][String]$UserName
	)

	BEGIN {

	}#begin

	PROCESS {

		#Build Request
		switch ($PSCmdlet.ParameterSetName) {

			"Gen2" {

				Assert-VersionRequirement -RequiredVersion 10.1

				#For Version 10.1+
				$Request = @{

					"URI"    = "$Script:BaseURI/api/Accounts/$($AccountID | Get-EscapedString)/Password/Retrieve"

					"Method" = "POST"

					#Get all parameters that will be sent in the request
					"Body"   = $PSBoundParameters | Get-PASParameter -ParametersToRemove AccountID,AsPsCredential,UserName | ConvertTo-Json

				}

				break

			}

			"Gen1" {

				#For Version 9.7+
				$Request = @{

					"URI"    = "$Script:BaseURI/WebServices/PIMServices.svc/Accounts/$($AccountID | Get-EscapedString)/Credentials"

					"Method" = "GET"

				}

				break

			}

		}

		#Add default Request parameters
		$Request.Add("WebSession", $Script:WebSession)

		#splat request to web service
		$result = Invoke-PASRestMethod @Request

		If ($null -ne $result) {

			switch ($PSCmdlet.ParameterSetName) {

				"Gen1" {

					$result = [System.Text.Encoding]::ASCII.GetString([PSCustomObject]$result.Content)

					break

				}

				"Gen2" {

					#Unescape returned string and remove enclosing quotes.
					$result = $([System.Text.RegularExpressions.Regex]::Unescape($result) -replace '^"|"$', '')

					break

				}

			}
			if ($PsBoundParameters.containskey("AsPsCredential")) {
				New-Object System.Management.Automation.PSCredential ($UserName,( ConvertTo-SecureString $result -AsPlainText -force))	
			} else {
				if ($PsBoundParameters.containskey("UserName")) { 
					write-warning "The username switch does not have any action unless used with the AsPsCredential switch" 
				}
				[PSCustomObject] @{"Password" = $result } | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Credential
			}

		}

	}#process

	END { }#end

}
