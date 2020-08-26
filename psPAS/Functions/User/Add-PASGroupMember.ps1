# .ExternalHelp psPAS-help.xml
function Add-PASGroupMember {
	[CmdletBinding(DefaultParameterSetName = "post_10_6")]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "post_10_6"
		)]
		[int]$groupId,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "post_10_6"
		)]
		[string]$memberId,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "post_10_6"
		)]
		[ValidateSet("domain", "vault")]
		[string]$memberType,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "post_10_6"
		)]
		[string]$domainName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "pre_10_6"
		)]
		[string]$GroupName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = "pre_10_6"
		)]
		[string]$UserName
	)

	BEGIN {

	}#begin

	PROCESS {

		switch ($PSCmdlet.ParameterSetName) {

			"pre_10_6" {

				#Create URL for request
				$URI = "$Script:BaseURI/WebServices/PIMServices.svc/Groups/$($GroupName | Get-EscapedString)/Users"

				break

			}

			"post_10_6" {

				Assert-VersionRequirement -RequiredVersion 10.6

				#Create URL for request
				$URI = "$Script:BaseURI/API/UserGroups/$groupId/Members"

				break

			}

		}

		#create request body
		$Body = $PSBoundParameters | Get-PASParameter -ParametersToRemove GroupName, groupId | ConvertTo-Json

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -WebSession $Script:WebSession

		If ($null -ne $result) {

			$result

		}

	}#process

	END { }#end

}