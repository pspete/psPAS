# .ExternalHelp psPAS-help.xml
function Set-PASSafeMember {
	[CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'Gen2')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[string]$SafeName,

		[Alias('UserName')]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[ValidateScript( { $_ -notmatch '.*(\?|\&).*' })]
		[string]$MemberName,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[datetime]$MembershipExpirationDate,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias('RestrictedRetrieve')]
		[boolean]$UseAccounts,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias('Retrieve')]
		[boolean]$RetrieveAccounts,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias('ListContent')]
		[boolean]$ListAccounts,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias('Add')]
		[boolean]$AddAccounts,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias('Update')]
		[boolean]$UpdateAccountContent,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias('UpdateMetadata')]
		[boolean]$UpdateAccountProperties,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$InitiateCPMAccountManagementOperations,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$SpecifyNextAccountContent,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias('Rename')]
		[boolean]$RenameAccounts,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias('Delete')]
		[boolean]$DeleteAccounts,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias('Unlock')]
		[boolean]$UnlockAccounts,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$ManageSafe,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$ManageSafeMembers,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$BackupSafe,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias('ViewAudit')]
		[boolean]$ViewAuditLog,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias('ViewMembers')]
		[boolean]$ViewSafeMembers,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen1'
		)]
		[ValidateRange(0, 2)]
		[int]$RequestsAuthorizationLevel,


		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[boolean]$requestsAuthorizationLevel1,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[boolean]$requestsAuthorizationLevel2,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$AccessWithoutConfirmation,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias('AddRenameFolder')]
		[boolean]$CreateFolders,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$DeleteFolders,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias('MoveFilesAndFolders')]
		[boolean]$MoveAccountsAndFolders,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = 'Gen1'
		)]
		[switch]$UseGen1API

	)

	BEGIN {

		#array for parameter names which appear in the top-tier of the JSON object
		$keysToKeep = [Collections.Generic.List[String]]@(
			'MembershipExpirationDate', 'Permissions'
		)

	}#begin

	PROCESS {

		#Get passed parameters to include in request body
		$boundParameters = $PSBoundParameters | Get-PASParameter

		switch ($PSCmdlet.ParameterSetName) {

			'Gen1' {

				#check required version
				Assert-VersionRequirement -MaximumVersion 12.3

				#Create URL for request
				$URI = "$($psPASSession.BaseURI)/WebServices/PIMServices.svc/Safes/$($SafeName |
					Get-EscapedString)/Members/$($MemberName | Get-EscapedString)/"

				If ($PSBoundParameters.ContainsKey('MembershipExpirationDate')) {

					#Convert ExpiryDate to string in Required format
					$Date = (Get-Date $MembershipExpirationDate -Format MM/dd/yyyy).ToString()

					#Include date string in request
					$boundParameters['MembershipExpirationDate'] = $Date

				}

				#Add permissions array to request in correct order
				[array]$boundParameters['Permissions'] = $boundParameters | ConvertTo-SortedPermission -Gen1

				#Create JSON for body of request
				$body = @{

					'member' = $boundParameters | Get-PASParameter -ParametersToKeep $keysToKeep

					#Ensure all levels of object are output
				} | ConvertTo-Json -Depth 3

				break

			}

			'Gen2' {

				Assert-VersionRequirement -RequiredVersion 12.2

				$safeMember = Get-PASSafeMember -SafeName $SafeName -MemberName $MemberName
				if ($null -ne $safeMember) {
					Format-PutRequestObject -InputObject $safeMember -boundParameters $BoundParameters -ParametersToRemove safeNumber, memberId,
					UserName, safeName, isExpiredMembershipEnable, memberName, memberType, safeUrlId, memberType, isPredefinedUser
				}

				#Create URL for request
				$URI = "$($psPASSession.BaseURI)/api/Safes/$($SafeName | Get-EscapedString)/Members/$($MemberName | Get-EscapedString)/"

				If ($PSBoundParameters.ContainsKey('MembershipExpirationDate')) {

					#Convert MembershipExpirationDate to string in Required format
					$Date = Get-Date $MembershipExpirationDate | ConvertTo-UnixTime

					#Include date string in request
					$boundParameters['MembershipExpirationDate'] = $Date

				}

				#Add permissions array to request in correct order
				$boundParameters['Permissions'] = $boundParameters | ConvertTo-SortedPermission -Gen2

				#Create required request object
				$body = $boundParameters | Get-PASParameter -ParametersToKeep $keysToKeep | ConvertTo-Json

				break

			}

		}

		if ($PSCmdlet.ShouldProcess($SafeName, "Update Safe Permissions for '$MemberName'")) {

			#Send request to webservice
			$result = Invoke-PASRestMethod -Uri $URI -Method PUT -Body $Body

			If ($null -ne $result) {

				switch ($PSCmdlet.ParameterSetName) {

					'Gen1' {

						#format output
						$result.member | Select-Object MembershipExpirationDate,

						@{Name = 'Permissions'; 'Expression' = {

								$result.member.permissions | ConvertFrom-KeyValuePair }

						} | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Safe.Member -PropertyToAdd @{

							'UserName' = $MemberName
							'SafeName' = $SafeName

						}

						break

					}

					'Gen2' {

						$result |
							Select-Object *, @{Name = 'UserName'; 'Expression' = { $PSItem.MemberName } } |
							Add-ObjectDetail -typename psPAS.CyberArk.Vault.Safe.Member.Gen2

						break

					}

				}

			}

		}

	}#process

	END { }#end

}