# .ExternalHelp psPAS-help.xml
function Stop-PASCPMTask {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [Alias('id')]
        [string[]]$Accountid,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$dependentAccountid
    )

    begin {

        Assert-VersionRequirement -SelfHosted
        Assert-VersionRequirement -RequiredVersion 15.2

        # Variable to track if we are doing bulk confirmation
        $BulkConfirmation = $false

        $boundInput = $PSBoundParameters['AccountID']

        if (Test-IsMultiValue -Value $boundInput) {

            $BulkConfirmation = $true
        }

        $Request = @{
            Method = 'POST'
        }

    }#begin

    process {

        if ($PSBoundParameters.ContainsKey('dependentAccountid')) {

            $URI = "$($psPASSession.BaseURI)/api/Accounts/$Accountid/DependentAccounts/$dependentAccountid/Cancel"

        } else {

            if ($BulkConfirmation) {

                #Create URL for Request
                $URI = "$($psPASSession.BaseURI)/API/Accounts/Cancel/Bulk"

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
                $URI = "$($psPASSession.BaseURI)/API/Accounts/$Accountid/Cancel/"

            }

        }

        $Request.Add('Uri', $URI)

        if ($PSCmdlet.ShouldProcess($Accountid, 'Cancel CPM Task')) {

            Invoke-PASRestMethod @Request

        }

    }#process

    end { }#end

}
