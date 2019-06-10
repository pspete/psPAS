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

.INPUTS
UserName, SessionToken, WebSession & BaseURI can be piped to the function by propertyname

.OUTPUTS
Outputs Object of Custom Type psPAS.CyberArk.Vault.User
SessionToken, WebSession, BaseURI are passed through and
contained in output object for inclusion in subsequent
pipeline operations.

Output format is defined via psPAS.Format.ps1xml.
To force all output to be shown, pipe to Select-Object *

.NOTES

.LINK

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

	BEGIN {}#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/$Script:PVWAAppName/WebServices/PIMServices.svc/Users/$($UserName |

            Get-EscapedString)"

		#request body
		$body = $PSBoundParameters |

		Get-PASParameter -ParametersToRemove UserName |

		ConvertTo-Json

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method PUT -Body $body -WebSession $Script:WebSession

		if($result) {

			$result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.User

		}

	}#process

	END {}#end

}