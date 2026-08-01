# .ExternalHelp psPAS-help.xml
function Resume-PASCPMAutoManagement {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [Alias('id')]
        [string[]]$Accountid
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

        if ($BulkConfirmation) {

            #Create URL for Request
            $URI = "$($psPASSession.BaseURI)/API/Accounts/Resume/Bulk"

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
            $URI = "$($psPASSession.BaseURI)/API/Accounts/$Accountid/Resume/"

        }

        $Request.Add('Uri', $URI)

        if ($PSCmdlet.ShouldProcess($Accountid, 'Resume CPM Auto Management')) {

            Invoke-PASRestMethod @Request

        }

    }#process

    end { }#end

}
