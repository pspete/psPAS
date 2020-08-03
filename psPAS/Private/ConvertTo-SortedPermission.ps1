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

	.EXAMPLE
	$PSBoundParameters | ConvertTo-SortedPermission

	Returns key value pairs fro $PSBoundParameters which relate to safe permissions

	#>
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseDeclaredVarsMoreThanAssignments', 'Permissions', Justification = "False Positive")]
	[CmdletBinding()]
	param (
		[parameter(
			Mandatory = $false,
			ValueFromPipeline = $true
		)]
		[hashtable]$Parameters
	)

	begin {

		$OrderedPermisions = [ordered]@{
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

	}

	process {

		#Input parameters have been provided
		If ($null -ne $Parameters.Keys) {

			#For each Ordered Safe Member Permission
			$OrderedPermisions.keys | ForEach-Object {

				$Permissions = [ordered]@{ }

			} {

				#Parameter match
				If ($Parameters.ContainsKey($PSItem)) {

					#Add to hash table in key/value pair
					$Permissions.Add($PSItem, $Parameters[$PSItem])

				}

			} {

				#return array of permissions, in order
				@($Permissions.getenumerator() | ForEach-Object { $PSItem })

			}
		}

	}

	end {

	}

}