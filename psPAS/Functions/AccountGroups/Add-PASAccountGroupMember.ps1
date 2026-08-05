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
		[ValidateLength(1, 170)]
		[string]$AccountID
	)

	begin {
		Assert-VersionRequirement -RequiredVersion 9.9.5
	}#begin

	process {

		#Create URL for Request
		$URI = "$($psPASSession.BaseURI)/API/AccountGroups/$($GroupID |

            Get-EscapedString)/Members"

		#Create body of request
		$body = $PSBoundParameters |

			Get-PASParameter -ParametersToRemove GroupID | ConvertTo-Json

		#send request to PAS web service
		if ($PSCmdlet.ShouldProcess($GroupID, 'Add Account Group Member')) {

			Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body

		}

	}#process

	end { }#end

}