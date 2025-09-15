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

	begin { }#begin

	process {

		$URI = "$($psPASSession.BaseURI)/WebServices/PIMServices.svc/Applications/$($AppID |

            Get-EscapedString)/Authentications/"

		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		if ($null -ne $result) {

			$result.authentication | Add-ObjectDetail -typename psPAS.CyberArk.Vault.ApplicationAuth

		}

	}#process

	end { }#end

}