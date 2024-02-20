# .ExternalHelp psPAS-help.xml
function Add-PASGroupMember {
	[CmdletBinding(DefaultParameterSetName = 'Gen2')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[Alias('ID')]
		[int]$groupId,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[string]$memberId,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[ValidateSet('domain', 'vault')]
		[string]$memberType,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[string]$domainName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[string]$GroupName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[string]$UserName
	)

	BEGIN {

	}#begin

	PROCESS {

		switch ($PSCmdlet.ParameterSetName) {

			'Gen1' {

				Assert-VersionRequirement -MaximumVersion 12.3

				#Create URL for request
				$URI = "$($psPASSession.BaseURI)/WebServices/PIMServices.svc/Groups/$($GroupName | Get-EscapedString)/Users/"

				break

			}

			'Gen2' {

				Assert-VersionRequirement -RequiredVersion 10.6

				#Create URL for request
				$URI = "$($psPASSession.BaseURI)/API/UserGroups/$groupId/Members"

				break

			}

		}

		#create request body
		$Body = $PSBoundParameters | Get-PASParameter -ParametersToRemove GroupName, groupId | ConvertTo-Json

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body

		If ($null -ne $result) {

			$result

		}

	}#process

	END { }#end

}