# .ExternalHelp psPAS-help.xml
function Set-PASLinkedAccount {
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSAvoidUsingPlainTextForPassword', '', Justification = 'Does not involve a plaintext password')]
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias('id')]
		[string[]]$AccountID,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateLength(1, 28)]
		[string[]]$safe,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet('1', '2', '3')]
		[string[]]$extraPasswordIndex,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string[]]$name,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string[]]$folder

	)

	begin {

		Assert-VersionRequirement -RequiredVersion 12.1

		# Variable to track if we are doing bulk confirmation
		$BulkConfirmation = $false

		$boundInput = $PSBoundParameters['AccountID']

		if (Test-IsMultiValue -Value $boundInput) {

			#Bulk Confirmations supported from 15.2
			Assert-VersionRequirement -RequiredVersion 15.2

			$BulkConfirmation = $true
		}

		$Request = @{
			Method = 'POST'
		}

	}#begin

	process {

		if ($BulkConfirmation) {

			#Create URL for Request
			$URI = "$($psPASSession.BaseURI)/API/Accounts/Link/Bulk"

			#Create body of request
			$Body = @{'BulkItems' = [System.Collections.Generic.List[object]]::new() }
			$AccountID | ForEach-Object {
				$Body.BulkItems.Add(
					@{
						AccountID          = $PSItem
						safe               = $safe
						extraPasswordIndex = $extraPasswordIndex
						name               = $name
						folder             = $folder
					}
				)
			}
			#Format body as JSON
			$Body = $Body | ConvertTo-Json -Depth 3

			$Request.Add('Body', $Body)

		} else {

			#Create URL for request
			$URI = "$($psPASSession.BaseURI)/api/Accounts/$AccountID/LinkAccount"

			#Get Parameters to include in request
			$body = $PSBoundParameters | Get-PASParameter -ParametersToRemove AccountID | ConvertTo-Json

			$Request.Add('Body', $Body)

		}

		$Request.Add('Uri', $URI)

		if ($PSCmdlet.ShouldProcess($AccountID, 'Set Linked Account')) {

			#Send request to web service
			Invoke-PASRestMethod @Request

		}

	}#process

	end { }#end

}