# .ExternalHelp psPAS-help.xml
function Get-PASAccountActivity {
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias("id")]
		[string]$AccountID


	)

	BEGIN { }#begin

	PROCESS {

		#Create request URL
		$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Accounts/$($AccountID |

            Get-EscapedString)/Activities"

		#Send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -WebSession $Script:WebSession

		If ($null -ne $result) {

			#Return Results
			$result.GetAccountActivitiesResult |

			Add-ObjectDetail -typename psPAS.CyberArk.Vault.Account.Activity

		}

	}#process

	END { }#end

}