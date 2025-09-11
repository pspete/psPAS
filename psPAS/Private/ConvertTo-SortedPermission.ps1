function ConvertTo-SortedPermission {
	<#
	.SYNOPSIS
	Correctly sorts PAS Safe Permissions

	.DESCRIPTION
	Safe permissions should be sent to the API in a specific order.
	When given a hashtable of parameters as input, safe permission key
	value pairs are returned in the correct order and format for
	inclusion in request body.

	.PARAMETER Parameters
	The input parameters to filter for safe permissons

	.PARAMETER Gen1
	Format permission object for Gen1 Add Safe Member

	.PARAMETER Gen2
	Format permission object for Gen2 Add Safe Member

	.EXAMPLE
	$PSBoundParameters | ConvertTo-SortedPermission -Gen1

	Returns key value pairs for $PSBoundParameters which relate to Gen1 safe permissions

	.EXAMPLE
	$PSBoundParameters | ConvertTo-SortedPermission -Gen2

	Returns hashtable for $PSBoundParameters which formatted for Gen2 safe permissions

	#>
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', 'Permissions', Justification = 'False Positive')]
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', 'Gen1', Justification = 'False Positive')]
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', 'Gen2', Justification = 'False Positive')]
	[CmdletBinding()]
	param (
		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[hashtable]$Parameters,

		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true,
			ParameterSetName = 'Gen1'
		)]
		[switch]$Gen1,

		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true,
			ParameterSetName = 'Gen2'
		)]
		[switch]$Gen2,

		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true,
			ParameterSetName = 'ConnectOnly'
		)]
		[switch]$ConnectOnly,

		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true,
			ParameterSetName = 'ReadOnly'
		)]
		[switch]$ReadOnly,

		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true,
			ParameterSetName = 'Approver'
		)]
		[switch]$Approver,

		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true,
			ParameterSetName = 'AccountsManager'
		)]
		[switch]$AccountsManager,

		[parameter(
			Mandatory = $true,
			ValueFromPipeline = $true,
			ParameterSetName = 'Full'
		)]
		[switch]$Full
	)

	begin {

		Switch ($PSCmdlet.ParameterSetName) {

			'Gen1' {
				$OrderedPermissions = [ordered]@{
					UseAccounts                            = $false
					RetrieveAccounts                       = $false
					ListAccounts                           = $false
					AddAccounts                            = $false
					UpdateAccountContent                   = $false
					UpdateAccountProperties                = $false
					InitiateCPMAccountManagementOperations = $false
					SpecifyNextAccountContent              = $false
					RenameAccounts                         = $false
					DeleteAccounts                         = $false
					UnlockAccounts                         = $false
					ManageSafe                             = $false
					ManageSafeMembers                      = $false
					BackupSafe                             = $false
					ViewAuditLog                           = $false
					ViewSafeMembers                        = $false
					RequestsAuthorizationLevel             = 0
					AccessWithoutConfirmation              = $false
					CreateFolders                          = $false
					DeleteFolders                          = $false
					MoveAccountsAndFolders                 = $false
				}

				break
			}

			'Gen2' {
				$OrderedPermissions = [ordered]@{
					useAccounts                            = $false
					retrieveAccounts                       = $false
					listAccounts                           = $false
					addAccounts                            = $false
					updateAccountContent                   = $false
					updateAccountProperties                = $false
					initiateCPMAccountManagementOperations = $false
					specifyNextAccountContent              = $false
					renameAccounts                         = $false
					deleteAccounts                         = $false
					unlockAccounts                         = $false
					manageSafe                             = $false
					manageSafeMembers                      = $false
					backupSafe                             = $false
					viewAuditLog                           = $false
					viewSafeMembers                        = $false
					accessWithoutConfirmation              = $false
					createFolders                          = $false
					deleteFolders                          = $false
					moveAccountsAndFolders                 = $false
					requestsAuthorizationLevel1            = $false
					requestsAuthorizationLevel2            = $false
					}
					break
				}
			
			'ConnectOnly' {
				$OrderedPermissions = [ordered]@{
					useAccounts                            = $true
					retrieveAccounts                       = $false
					listAccounts                           = $true
					addAccounts                            = $false
					updateAccountContent                   = $false
					updateAccountProperties                = $false
					initiateCPMAccountManagementOperations = $false
					specifyNextAccountContent              = $false
					renameAccounts                         = $false
					deleteAccounts                         = $false
					unlockAccounts                         = $false
					manageSafe                             = $false
					manageSafeMembers                      = $false
					backupSafe                             = $false
					viewAuditLog                           = $false
					viewSafeMembers                        = $false
					accessWithoutConfirmation              = $false
					createFolders                          = $false
					deleteFolders                          = $false
					moveAccountsAndFolders                 = $false
					requestsAuthorizationLevel1            = $false
					requestsAuthorizationLevel2            = $false
				}
				break
			}

			'ReadOnly' {
				$OrderedPermissions = [ordered]@{
					useAccounts                            = $true
					retrieveAccounts                       = $true
					listAccounts                           = $true
					addAccounts                            = $false
					updateAccountContent                   = $false
					updateAccountProperties                = $false
					initiateCPMAccountManagementOperations = $false
					specifyNextAccountContent              = $false
					renameAccounts                         = $false
					deleteAccounts                         = $false
					unlockAccounts                         = $false
					manageSafe                             = $false
					manageSafeMembers                      = $false
					backupSafe                             = $false
					viewAuditLog                           = $false
					viewSafeMembers                        = $false
					accessWithoutConfirmation              = $false
					createFolders                          = $false
					deleteFolders                          = $false
					moveAccountsAndFolders                 = $false
					requestsAuthorizationLevel1            = $false
					requestsAuthorizationLevel2            = $false
				}
				break
			}
			'Approver' {
				$OrderedPermissions = [ordered]@{
					useAccounts                            = $false
					retrieveAccounts                       = $false
					listAccounts                           = $true
					addAccounts                            = $false
					updateAccountContent                   = $false
					updateAccountProperties                = $false
					initiateCPMAccountManagementOperations = $false
					specifyNextAccountContent              = $false
					renameAccounts                         = $false
					deleteAccounts                         = $false
					unlockAccounts                         = $false
					manageSafe                             = $false
					manageSafeMembers                      = $true
					backupSafe                             = $false
					viewAuditLog                           = $false
					viewSafeMembers                        = $true
					accessWithoutConfirmation              = $false
					createFolders                          = $false
					deleteFolders                          = $false
					moveAccountsAndFolders                 = $false
					requestsAuthorizationLevel1            = $true
					requestsAuthorizationLevel2            = $false
				}
				break
			}

			'AccountsManager' {
				$OrderedPermissions = [ordered]@{
					useAccounts                            = $true
					retrieveAccounts                       = $true
					listAccounts                           = $true
					addAccounts                            = $true
					updateAccountContent                   = $true
					updateAccountProperties                = $true
					initiateCPMAccountManagementOperations = $true
					specifyNextAccountContent              = $true
					renameAccounts                         = $true
					deleteAccounts                         = $true
					unlockAccounts                         = $true
					manageSafe                             = $false
					manageSafeMembers                      = $true
					backupSafe                             = $false
					viewAuditLog                           = $true
					viewSafeMembers                        = $true
					accessWithoutConfirmation              = $true
					createFolders                          = $false
					deleteFolders                          = $false
					moveAccountsAndFolders                 = $false
					requestsAuthorizationLevel1            = $false
					requestsAuthorizationLevel2            = $false
				}
				break
			}

			'Full' {
				$OrderedPermissions = [ordered]@{
					useAccounts                            = $true
					retrieveAccounts                       = $true
					listAccounts                           = $true
					addAccounts                            = $true
					updateAccountContent                   = $true
					updateAccountProperties                = $true
					initiateCPMAccountManagementOperations = $true
					specifyNextAccountContent              = $true
					renameAccounts                         = $true
					deleteAccounts                         = $true
					unlockAccounts                         = $true
					manageSafe                             = $true
					manageSafeMembers                      = $true
					backupSafe                             = $true
					viewAuditLog                           = $true
					viewSafeMembers                        = $true
					accessWithoutConfirmation              = $true
					createFolders                          = $true
					deleteFolders                          = $true
					moveAccountsAndFolders                 = $true
					requestsAuthorizationLevel1            = $true
					requestsAuthorizationLevel2            = $false
				}
				break
			}
		}
	}

	process {

		If ($PSCmdlet.ParameterSetName -in 'ConnectOnly','ReadOnly','Approver','AccountsManager','Full') {

			$Permissions = $OrderedPermissions
			return $Permissions

		}

		#Input parameters have been provided
		If ($null -ne $Parameters.Keys -and 'Gen1','Gen2' -in $PSCmdlet.ParameterSetName) {

			#For each Ordered Safe Member Permission
			$OrderedPermissions.keys | ForEach-Object {

				$Permissions = [ordered]@{ }

			} {

				#Parameter match
				If ($Parameters.ContainsKey($PSItem)) {

					#Add to hash table in key/value pair
					$Permissions.Add($PSItem, $Parameters[$PSItem])

				}

			} {

				If (($Permissions.Keys).count -gt 0) {

					Switch ($PSCmdlet.ParameterSetName) {

						'Gen1' {

							#return permissions, in order
							$Permissions.getenumerator() | ForEach-Object { $PSItem }

							break

						}

						'Gen2' {

							#return permissions, in order
							$Permissions

							break

						}

					}

				}

			}

		}

	}

	end {

	}

}