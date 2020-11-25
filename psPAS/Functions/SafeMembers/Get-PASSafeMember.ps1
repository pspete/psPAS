# .ExternalHelp psPAS-help.xml
function Get-PASSafeMember {
	[CmdletBinding(DefaultParameterSetName = "SafePermissions")]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$SafeName,

		[Alias("UserName")]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "MemberPermissions"
		)]
		[ValidateNotNullOrEmpty()]
		[string]$MemberName
	)

	BEGIN {

		$Request = @{ }
		$Method = "GET"

	}#begin

	PROCESS {

		#Create URL for request
		$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Safes/$($SafeName | Get-EscapedString)/Members"

		switch ($PSCmdlet.ParameterSetName) {

			"MemberPermissions" {

				#Create URL for member specific request
				$URI = "$URI/$($MemberName | Get-EscapedString)"
				#Send a PUT Request instead of GET
				$Method = "PUT"
				#Send an empty body
				#Add to Request parameters for PUT Request
				$Request["Body"] = @{"member" = @{ } } | ConvertTo-Json

				break

			}

		}

		#Build Request Parameters
		$Request["URI"] = $URI
		$Request["Method"] = $Method
		$Request["WebSession"] = $Script:WebSession

		#Send request to webservice
		$result = Invoke-PASRestMethod @Request

		If ($null -ne $result) {

			switch ($PSCmdlet.ParameterSetName) {

				"MemberPermissions" {

					#format output
					$Output = $result.member | Select-Object MembershipExpirationDate,

					@{Name = "UserName"; "Expression" = { $MemberName } },

					@{Name = "Permissions"; "Expression" = {

							$result.member.permissions | ConvertFrom-KeyValuePair }

					}

					break

				}

				default {

					#output
					$Output = $result.members | Select-Object UserName, Permissions

				}

			}

			$Output | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Safe.Member -PropertyToAdd @{

				"SafeName" = $SafeName

			}

		}

	}#process

	END { }#end

}