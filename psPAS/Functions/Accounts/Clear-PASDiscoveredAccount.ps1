# .ExternalHelp psPAS-help.xml
function Clear-PASDiscoveredAccount {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $false,
            ValueFromPipelineByPropertyName = $true
        )]
        [string[]]$id
    )

    begin {

        Assert-VersionRequirement -RequiredVersion 12.1

        # Variable to track if we are doing bulk confirmation
        $BulkConfirmation = $false

        $boundInput = $PSBoundParameters['id']

        if (Test-IsMultiValue -Value $boundInput) {

            $BulkConfirmation = $true

        }

    }#begin

    process {

        if ($BulkConfirmation) {

            $Request = @{
                Method = 'POST'
            }

            #Create URL for Request
            $URI = "$($psPASSession.BaseURI)/api/DiscoveredAccounts/Delete/Bulk"

            #Create body of request
            $Body = @{'BulkItems' = [System.Collections.Generic.List[object]]::new() }
            $id | ForEach-Object {
                $Body.BulkItems.Add(
                    @{
                        discoveredAccountId = $PSItem
                    }
                )
            }
            #Format body as JSON
            $Body = $Body | ConvertTo-Json -Depth 3

            $Request.Add('Body', $Body)

        } else {

            #Create URL for request
            $URI = "$($psPASSession.BaseURI)/api/DiscoveredAccounts"

            $Request = @{
                Method = 'DELETE'
            }

            if ($PSBoundParameters.ContainsKey('id')) {

                $URI = "$URI/$($id | Get-EscapedString)"

            }

        }

        $Request.Add('Uri', $URI)

        if ($PSCmdlet.ShouldProcess('Discovered/Pending Account List', 'Delete')) {

            Invoke-PASRestMethod @Request

        }

    }#process

    end { }#end
}