# .ExternalHelp psPAS-help.xml
function Get-PASApplicationAuthenticationMethod {
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$AppID
	)

	BEGIN { }#begin

	PROCESS {

		$URI = "$($psPASSession.BaseURI)/WebServices/PIMServices.svc/Applications/$($AppID |

            Get-EscapedString)/Authentications/"

		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		If ($null -ne $result) {

			$result.authentication | Add-ObjectDetail -typename psPAS.CyberArk.Vault.ApplicationAuth

		}

	}#process

	END { }#end

}