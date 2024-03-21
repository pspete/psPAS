# .ExternalHelp psPAS-help.xml
function Remove-PASAccountACL {
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias('PolicyID')]
		[ValidateNotNullOrEmpty()]
		[string]$AccountPolicyId,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$AccountAddress,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$AccountUserName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$Id
	)

	BEGIN {
		Assert-VersionRequirement -SelfHosted
	}#begin

	PROCESS {

		#URL for request
		$URI = "$($psPASSession.BaseURI)/WebServices/PIMServices.svc/Account/$($AccountAddress |

            Get-EscapedString)|$($AccountUserName |

                Get-EscapedString)|$($AccountPolicyId |

                    Get-EscapedString)/PrivilegedCommands/$Id/"

		#Request Body
		$Body = @{ }

		if ($PSCmdlet.ShouldProcess("$AccountAddress|$AccountUserName|$AccountPolicyId",
				"Delete Privileged Command '$Id'")) {

			#Send Request to Web Service
			Invoke-PASRestMethod -Uri $URI -Method DELETE -Body $Body

		}

	}#process

	END { }#end

}