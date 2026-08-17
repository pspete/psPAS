# .ExternalHelp psPAS-help.xml
function Unlock-PASAccount {
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', 'CheckIn', Justification = 'Parameter used for ParameterSet function logic')]
	[System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSReviewUnusedParameter', 'Unlock', Justification = 'Parameter used for ParameterSet function logic')]
	[CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'CheckIn')]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateNotNullOrEmpty()]
		[Alias('id')]
		[string[]]$AccountID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = 'CheckIn'
		)]
		[switch]$CheckIn,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $false,
			ParameterSetName = 'Unlock'
		)]
		[switch]$Unlock
	)

	begin { 
		# Variable to track if we are doing bulk confirmation
		$BulkConfirmation = $false
		
		$boundInput = $PSBoundParameters['AccountID']

		if (Test-IsMultiValue -Value $boundInput) {

			#Bulk Confirmations supported from 15.2
			Assert-VersionRequirement -RequiredVersion 15.2

			$BulkConfirmation = $true
		}

	}#begin

	process {

		$Request = @{
			Method = 'POST'
		}

		switch ($PSCmdlet.ParameterSetName) {

			'CheckIn' {

				if ($BulkConfirmation) {

					#Create URL for Request
					$URI = "$($psPASSession.BaseURI)/API/Accounts/CheckIn/Bulk"

					#Create body of request
					$Body = @{'BulkItems' = [System.Collections.Generic.List[object]]::new() }
					$AccountID | ForEach-Object {
						$Body.BulkItems.Add(
							@{
								AccountID = $PSItem
							}
						)
					}
					#Format body as JSON
					$Body = $Body | ConvertTo-Json -Depth 3

					$Request.Add('Body', $Body)

				} else {

					#Create URL for request
					$URI = "$($psPASSession.BaseURI)/API/Accounts/$AccountID/CheckIn"
					break

				}

			}

			'Unlock' {

				if ($BulkConfirmation) {

					#Create URL for Request
					$URI = "$($psPASSession.BaseURI)/API/Accounts/Unlock/Bulk"

					#Create body of request
					$Body = @{'BulkItems' = [System.Collections.Generic.List[object]]::new() }
					$AccountID | ForEach-Object {
						$Body.BulkItems.Add(
							@{
								AccountID = $PSItem
							}
						)
					}
					#Format body as JSON
					$Body = $Body | ConvertTo-Json -Depth 3

					$Request.Add('Body', $Body)

				} else {

					#*Assumed working for 11.6+ (not verified/tested for all versions)
					Assert-VersionRequirement -RequiredVersion 11.6

					#Create URL for request
					$URI = "$($psPASSession.BaseURI)/API/Accounts/$AccountID/Unlock"
					break

				}

			}

		}

		$Request.Add('Uri', $URI)

		if ($PSCmdlet.ShouldProcess($AccountID, "$($PSCmdlet.ParameterSetName) Account")) {

			#send request to web service
			Invoke-PASRestMethod @Request

		}

	}#process

	end { }#end

}