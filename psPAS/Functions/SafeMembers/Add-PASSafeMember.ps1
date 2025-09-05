# .ExternalHelp psPAS-help.xml
function Add-PASSafeMember {
	[CmdletBinding(DefaultParameterSetName = 'Gen2')]
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
		[string]$SearchIn,

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
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
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
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'Gen2'
		)]
		[ValidateNotNullOrEmpty()]
		[ValidateSet('User', 'Group', 'Role')]
		[string]$memberType,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = 'Gen1'
		)]
		[switch]$UseGen1API,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = 'ConnectOnly'
		)]
		[switch]$ConnectOnly,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = 'ReadOnly'
		)]
		[switch]$ReadOnly,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = 'Approver'
		)]
		[switch]$Approver,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = 'AccountsManager'
		)]
		[switch]$AccountsManager,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = 'Full'
		)]
		[switch]$Full
	)

	BEGIN {

		#array for parameter names which appear in the top-tier of the JSON object
		$keysToKeep = [Collections.Generic.List[String]]@(
			'MemberName', 'SearchIn', 'MembershipExpirationDate', 'Permissions', 'MemberType'
		)

	}#begin

	PROCESS {

		#Get Parameters for request body
		$boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove SafeName, UseGen1API
		
		If ($PSCmdlet.ParameterSetName -in 'ReadOnly','ConnectOnly','Approver','AccountsManager','Full') {

			switch ($PSCmdlet.ParameterSetName) {

				'ConnectOnly' { 
					Add-PASSafeMember -MemberName $MemberName -SafeName $SafeName -ListAccounts $true -UseAccounts $true
					break
				}

				'ReadOnly' {
					Add-PASSafeMember -MemberName $MemberName -SafeName $SafeName -ListAccounts $true -UseAccounts $true -RetrieveAccounts $true
					break
				}

				'Approver' {
					Add-PASSafeMember -memberName $memberName -SafeName $SafeName -ListAccounts $true -ViewSafeMembers $true -ManageSafeMembers $true -requestsAuthorizationLevel1 $true
					break
				}

				'AccountsManager' {
					Add-PASSafeMember -memberName $MemberName -SafeName $SafeName -ListAccounts $true -UseAccounts $true -RetrieveAccounts $true -AddAccounts $true -UpdateAccountProperties $true -UpdateAccountContent $true -InitiateCPMAccountManagementOperations $true -SpecifyNextAccountContent $true -RenameAccounts $true -DeleteAccounts $true -UnlockAccounts $true -ViewSafeMembers $true -ManageSafeMembers $true -ViewAuditLog $true -AccessWithoutConfirmation $true
					break
				}

				'Full' {
					Add-PASSafeMember -memberName $MemberName -SafeName $SafeName -ListAccounts $true -UseAccounts $true -RetrieveAccounts $true -AddAccounts $true -UpdateAccountProperties $true -UpdateAccountContent $true -InitiateCPMAccountManagementOperations $true -SpecifyNextAccountContent $true -RenameAccounts $true -DeleteAccounts $true -UnlockAccounts $true -ManageSafe $true -ViewSafeMembers $true -ManageSafeMembers $true -ViewAuditLog $true -BackupSafe $true -requestsAuthorizationLevel1 $true -AccessWithoutConfirmation $true -MoveAccountsAndFolders $true -CreateFolders $true -DeleteFolders $true
					break
				}
			}
			break
		}

		switch ($PSCmdlet.ParameterSetName) {

			( { $PSItem -match '^Gen1' } ) {

				Assert-VersionRequirement -MaximumVersion 12.3

				#Create URL for request
				$URI = "$($psPASSession.BaseURI)/WebServices/PIMServices.svc/Safes/$($SafeName |
				Get-EscapedString)/Members"

				If ($PSBoundParameters.ContainsKey('MembershipExpirationDate')) {

					#Convert MembershipExpirationDate to string in Required format
					$Date = (Get-Date $MembershipExpirationDate -Format MM/dd/yyyy).ToString()

					#Include date string in request
					$boundParameters['MembershipExpirationDate'] = $Date

				}

				#Add permissions array to request in correct order
				[array]$boundParameters['Permissions'] = $boundParameters | ConvertTo-SortedPermission -Gen1

				#Create required request object
				$body = @{

					'member' = $boundParameters | Get-PASParameter -ParametersToKeep $keysToKeep

					#Ensure all required JSON levels are output
				} | ConvertTo-Json -Depth 3

				break

			}

			( { $PSItem -match '^Gen2' -or '^ReadOnly' -or '^ConnectOnly' -or '^Approver' -or '^AccountsManager' -or '^Full'} ) {

				Assert-VersionRequirement -RequiredVersion 12.1

				#Create URL for request
				$URI = "$($psPASSession.BaseURI)/api/Safes/$($SafeName | Get-EscapedString)/Members"

				If ($PSBoundParameters.ContainsKey('MemberType')) {

					Assert-VersionRequirement -RequiredVersion 12.6

				}

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

		#Send request to Web Service
		$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body

		If ($null -ne $result) {

			switch ($PSCmdlet.ParameterSetName) {

				( { $PSItem -match '^Gen1' } ) {
					#format output
					$result.member | Select-Object MemberName, MembershipExpirationDate, SearchIn,

					@{Name = 'Permissions'; 'Expression' = {

							$result.member.permissions | ConvertFrom-KeyValuePair }

					} | Add-ObjectDetail -typename psPAS.CyberArk.Vault.Safe.Member.Extended -PropertyToAdd @{

						'SafeName' = $SafeName

					}

					break

				}

				( { $PSItem -match '^Gen2' -or '^ReadOnly' -or '^ConnectOnly' -or '^Approver' -or '^AccountsManager' -or '^Full'} ) {

					$result |
						Select-Object *, @{Name = 'UserName'; 'Expression' = { $PSItem.MemberName } } |
						Add-ObjectDetail -typename psPAS.CyberArk.Vault.Safe.Member.Gen2

					break

				}

			}

		}

	}#process

	END { }#end

}