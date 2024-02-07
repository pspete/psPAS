# .ExternalHelp psPAS-help.xml
function Add-PASDiscoveredAccount {
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingUserNameAndPassWordParams', '', Justification = 'Username not used for authentication')]
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', 'platformTypeAccountProperties', Justification = 'False Positive')]
	[CmdletBinding(DefaultParameterSetName = 'Windows')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$UserName,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$Address,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[datetime]$discoveryDate,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$AccountEnabled,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$osGroups,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet('Windows Server Local', 'Windows Desktop Local', 'Windows Domain', 'Unix', 'Unix SSH Key', 'AWS', 'AWS Access Keys', 'Azure Password Management')]
		[string]$platformType,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$Domain,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[datetime]$lastLogonDateTime,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[datetime]$lastPasswordSetDateTime,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$passwordNeverExpires,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$OSVersion,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$privileged,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$privilegedCriteria,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$UserDisplayName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$description,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[datetime]$passwordExpirationDateTime,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet('Workstation', 'Server')]
		[string]$osFamily,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[hashtable]$additionalProperties,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$organizationalUnit,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Windows'
		)]
		[string]$SID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Unix'
		)]

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'UnixSSHKey'
		)]
		[string]$uid,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Unix'
		)]

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'UnixSSHKey'
		)]
		[string]$gid,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'UnixSSHKey'
		)]
		[string]$fingerprint,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'UnixSSHKey'
		)]
		[ValidateSet(1024, 2048, 4096, 8192)]
		[int]$size,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'UnixSSHKey'
		)]
		[string]$path,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'UnixSSHKey'
		)]
		[string]$format,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'UnixSSHKey'
		)]
		[string]$comment,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'UnixSSHKey'
		)]
		[ValidateSet('RSA', 'DSA')]
		[string]$encryption,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'AWS'
		)]
		[ValidateLength(12, 12)]
		[string]$awsAccountID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'AWS'
		)]
		[string]$awsAccessKeyID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Dependency'
		)]
		[hashtable[]]$Dependencies,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Azure'
		)]
		[string]$activeDirectoryID
	)

	BEGIN {

		switch ($PSCmdlet.ParameterSetName) {

			{ $PSItem -match 'Azure' } {

				#v11.7 required for Azure
				Assert-VersionRequirement -RequiredVersion 11.7

			}

			{ $PSItem -match 'AWS|Dependency' } {

				#v10.8 required for AWS & Dependencies
				Assert-VersionRequirement -RequiredVersion 10.8

			}

			Default {

				#v10.5 Minimum version required
				Assert-VersionRequirement -RequiredVersion 10.5

			}

		}

		$AccountProperties = [Collections.Generic.List[String]]@('SID', 'uid', 'gid', 'fingerprint', 'size', 'path', 'format', 'comment', 'encryption', 'awsAccountID', 'awsAccessKeyID', 'activeDirectoryID')

		$DateTimes = [Collections.Generic.List[String]]@('discoveryDate', 'lastLogonDateTime', 'lastPasswordSetDateTime', 'passwordExpirationDateTime')

	}#begin

	PROCESS {

		#Create URL for Request
		$URI = "$($psPASSession.BaseURI)/api/DiscoveredAccounts"

		#Get all parameters that will be sent in the request
		$boundParameters = $PSBoundParameters | Get-PASParameter

		Foreach ($DateTime in $DateTimes) {

			if ($PSBoundParameters.ContainsKey($DateTime)) {

				#convert to unix time
				$boundParameters["$DateTime"] = $PSBoundParameters["$DateTime"] | ConvertTo-UnixTime

			}

		}

		$boundParameters.keys | Where-Object { $AccountProperties -contains $_ } | ForEach-Object {

			$platformTypeAccountProperties = @{ }

		} {

			#add key=value to hashtable
			$platformTypeAccountProperties[$_] = $boundParameters[$_]

		} {

			If ($platformTypeAccountProperties.Count -gt 0) {

				$boundParameters['platformTypeAccountProperties'] = $platformTypeAccountProperties

			}

		}

		$Body = $boundParameters | Get-PASParameter -ParametersToRemove $AccountProperties | ConvertTo-Json

		#send request to PAS web service
		$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body

		If ($null -ne $result) {

			#Return Results
			$result

		}

	}#process

	END { }#end

}