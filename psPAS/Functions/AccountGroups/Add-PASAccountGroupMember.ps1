# .ExternalHelp psPAS-help.xml
function Add-PASAccountGroupMember {
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$GroupID,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$AccountID
	)

	BEGIN {
		Assert-VersionRequirement -RequiredVersion 9.9.5
	}#begin

	PROCESS {

		#Create URL for Request
		$URI = "$($psPASSession.BaseURI)/API/AccountGroups/$($GroupID |

            Get-EscapedString)/Members"

		#Create body of request
		$body = $PSBoundParameters |

			Get-PASParameter -ParametersToRemove GroupID | ConvertTo-Json

		# Only proceed with the operation if ShouldProcess returns true
		if ($PSCmdlet.ShouldProcess($AccountID, "Add to Account Group $GroupID")) {
			#send request to PAS web service
			Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body
		}

	}#process

	END { }#end

}