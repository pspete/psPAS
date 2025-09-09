# .ExternalHelp psPAS-help.xml
Function Sync-PASDependentAccount {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $false
        )]
        [Alias('id')]
        [string]$accountId,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $false
        )]
        [Alias('dependentid')]
        [string[]]$dependentAccountId

    )

    BEGIN {

        Assert-VersionRequirement -RequiredVersion 14.6

        # Variable to track if we are doing bulk confirmation
		$BulkConfirmation = $false

		$boundInput = $PSBoundParameters['dependentAccountId']

		if (Test-IsMultiValue -Value $boundInput) {

			#Bulk Confirmations supported from 14.6
			Assert-VersionRequirement -RequiredVersion 14.6

			$BulkConfirmation = $true
		}

        $Request = @{
            Method = 'POST'
        }

    }#begin

    PROCESS {

        #Create URL for Request
        $URI = "$($psPASSession.BaseURI)/API/Accounts/$AccountID/dependentAccounts"

        if ($BulkConfirmation) {

			# Branch logic for bulk confirmation
            #TODO: Confirm this URL - the documentation is unclear
			$URI = "$URI/Sync/Bulk"

			#Create body of request
			$Body = @{"BulkItems" = [System.Collections.Generic.List[object]]::new()}
			$dependentAccountId | ForEach-Object {
				$Body.BulkItems.Add(
					@{
						accountId            = $accountId
						dependentAccountId   = $PSItem
					}
				)
			}

            #Format body as JSON
		    $Body = $Body | ConvertTo-Json

            $Request.Add('Body', $Body)

		} Else{

			# Branch logic for single confirmation
			$URI = "$URI/$($boundInput)/Sync"

		}

        $Request.Add('Uri', $URI)

        if ($PSCmdlet.ShouldProcess($AccountID, "Sync Dependent Account")) {

            #Send request to web service
            Invoke-PASRestMethod @Request

        }

    }#process

    END { }#end

}
