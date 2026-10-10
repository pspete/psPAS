# .ExternalHelp psPAS-help.xml
function Clear-PASLinkedAccount {
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
        [int]$extraPasswordIndex

    )

    begin {

        Assert-VersionRequirement -RequiredVersion 12.2

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
            Method = 'DELETE'
        }

        if ($BulkConfirmation) {

            #Create URL for Request
            $URI = "$($psPASSession.BaseURI)/API/Accounts/Unlink/Bulk"

            #Create body of request
            $Body = @{'BulkItems' = [System.Collections.Generic.List[object]]::new() }
            $AccountID | ForEach-Object {
                $Body.BulkItems.Add(
                    @{
                        AccountID          = $PSItem
                        extraPasswordIndex = $extraPasswordIndex
                    }
                )
            }
            #Format body as JSON
            $Body = $Body | ConvertTo-Json -Depth 3

            $Request.Add('Body', $Body)

        } else {

            #Create URL for Request
            $URI = "$($psPASSession.BaseURI)/api/Accounts/$AccountID/LinkAccount/$extraPasswordIndex"

        }

        $Request.Add('Uri', $URI)

        if ($PSCmdlet.ShouldProcess($AccountID, "Clear extraPass$extraPasswordIndex Linked Account")) {

            #Send request to web service
            Invoke-PASRestMethod @Request

        }

    }#process

    end { }#end

}