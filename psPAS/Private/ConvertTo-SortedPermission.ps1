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
		[switch]$Gen2
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
		}


	}

	process {

		#Input parameters have been provided
		If ($null -ne $Parameters.Keys) {

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