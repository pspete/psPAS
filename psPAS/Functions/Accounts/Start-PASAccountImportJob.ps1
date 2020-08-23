Function Start-PASAccountImportJob {
	<#
	.SYNOPSIS
	Add multiple accounts to existing Safes.

	.DESCRIPTION
	Sends a list of accounts to be added to existing safes.
	Must be authenticated with a user who has Add accounts, Update account content, and Update account properties authorization in at least one Safe.
	Returns bulk account upload id or status.

	.PARAMETER source
	Free text that describes the source of the bulk account upload.

	.PARAMETER accountsList
	List of account objects.
	Each account object contains the parameters for that account.
	New-PASAccountObject creates Account Objects with the expected properties.

	.EXAMPLE
	$Accounts = @(
		New-PASAccountObject -uploadIndex 1 -userName SomeAccount1 -address domain.com -platformID WinDomain -SafeName SomeSafe
		New-PASAccountObject -uploadIndex 2 -userName SomeAccount2 -address domain.com -platformID WinDomain -SafeName SomeSafe
		New-PASAccountObject -uploadIndex 3 -userName SomeAccount3 -address domain.com -platformID WinDomain -SafeName SomeSafe
		New-PASAccountObject -uploadIndex 4 -userName SomeAccount4 -address domain.com -platformID WinDomain -SafeName SomeSafe
	)

	Start-PASAccountImportJob -source "SomeSource" -accountsList $Accounts

	Create & send list of accounts to be added as a bulk operation.

	.LINK
	https://pspas.pspete.dev/commands/Start-PASAccountImportJob

	#>
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$source,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[object[]]$accountsList
	)

	Begin {

		Assert-VersionRequirement -RequiredVersion 11.6

		#Create URL for Request
		$URI = "$Script:BaseURI/api/bulkactions/accounts"

	}

	Process {

		#Get all parameters that will be sent in the request
		$boundParameters = $PSBoundParameters | Get-PASParameter

		#Create body of request
		$body = $boundParameters | Get-PASParameter | ConvertTo-Json -Depth 3

		if ($PSCmdlet.ShouldProcess("List of $($accountsList.count) account(s)", "Start Bulk Account Import Job")) {

			#send request
			$Result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body -WebSession $Script:WebSession

			If ($null -ne $Result) {

				#Return Results
				try {

					#Query Import Job Status
					Get-PASAccountImportJob -id $Result

				}

				catch {

					#Return Import Job ID
					[PSCustomObject]@{"id" = $Result }

				}

			}

		}

	}

	End {}

}