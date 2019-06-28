function Unblock-PASUser {
	<#
.SYNOPSIS
Activates a suspended user

.DESCRIPTION
Activates an existing vault user who was suspended due to password
failures.

.PARAMETER UserName
The user's name

.PARAMETER Suspended
Suspension status

.EXAMPLE
Unblock-PASUser -UserName MrFatFingers -Suspended $false

Activates suspended vault user MrFatFingers
#>
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$UserName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $false
		)]
		[ValidateSet($false)]
		[boolean]$Suspended
	)

	BEGIN { }#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Users/$($UserName |

            Get-EscapedString)"

		#request body
		$body = $PSBoundParameters |

		Get-PASParameter -ParametersToRemove UserName |

		ConvertTo-Json

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method PUT -Body $body -WebSession $Script:WebSession

		if ($result) {

			$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.User

		}

	}#process

	END { }#end

}