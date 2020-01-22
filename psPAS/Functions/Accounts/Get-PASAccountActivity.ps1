function Get-PASAccountActivity {
	<#
.SYNOPSIS
Returns activities for an account.

.DESCRIPTION
Returns activities for a specific account identified by its AccountID.

.PARAMETER AccountID
The ID of the account whose activities will be retrieved.

.EXAMPLE
Get-PASAccount -Keywords root -Safe UNIXSafe | Get-PASAccountActivity

Will return the account activity for the account output by Get-PASAccount:

Time                Activity                  UserName      AccountName
----                --------                  --------      -----------
08/07/2017 13:05:46 Delete Privileged Command Administrator root
08/07/2017 13:02:54 Delete Privileged Command Administrator root
07/30/2017 10:49:32 Add Privileged Command    Administrator root
...
...
...

.INPUTS
All parameters can be piped by property name
Accepts pipeline input from Get-PASAccount

.OUTPUTS
Outputs Object of Custom Type psPAS.CyberArk.Vault.Account.Activity
Output format is defined via psPAS.Format.ps1xml.
To force all output to be shown, pipe to Select-Object *

.LINK
https://pspas.pspete.dev/commands/Get-PASAccountActivity
#>
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

		If ($result) {

			#Return Results
			$result.GetAccountActivitiesResult |

			Add-ObjectDetail -typename psPAS.CyberArk.Vault.Account.Activity

		}

	}#process

	END { }#end

}