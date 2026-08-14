# .ExternalHelp psPAS-help.xml
function Resume-PASDependentAccount {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [Alias('id')]
        [string]$AccountID,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [Alias('dependentid')]
        [string[]]$dependentAccountId

    )

    begin {

        Assert-VersionRequirement -RequiredVersion 14.6

        # Variable to track if we are doing bulk confirmation
        $BulkConfirmation = $false

        $boundInput = $PSBoundParameters['dependentAccountId']

        if (Test-IsMultiValue -Value $boundInput) {

            #Bulk Confirmations supported from 15.0
            Assert-VersionRequirement -RequiredVersion 15.0

            $BulkConfirmation = $true
        }

        $Request = @{
            Method = 'POST'
        }

    }#begin

    process {

        if ($BulkConfirmation) {

            #Create URL for Request
            $URI = "$($psPASSession.BaseURI)/API/Accounts/dependentAccounts/Resume/Bulk"

            #Create body of request
            $Body = @{'BulkItems' = [System.Collections.Generic.List[object]]::new() }
            $dependentAccountId | ForEach-Object {
                $Body.BulkItems.Add(
                    @{
                        AccountID          = $AccountID
                        dependentAccountId = $PSItem
                    }
                )
            }
            #Format body as JSON
            $Body = $Body | ConvertTo-Json -Depth 3

            $Request.Add('Body', $Body)

        } else {

            #Create URL for Request
            $URI = "$($psPASSession.BaseURI)/API/Accounts/$AccountID/dependentAccounts/$dependentAccountId/Resume"

        }

        $Request.Add('Uri', $URI)

        if ($PSCmdlet.ShouldProcess($AccountID, 'Resume Dependent Account')) {

            #Send request to web service
            Invoke-PASRestMethod @Request

        }

    }#process

    end { }#end

}
