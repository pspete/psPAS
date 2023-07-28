function ConvertTo-BulkFilterItem {
    <#
	.SYNOPSIS
    Creates hashtable in format expected for bulk access requests

	.DESCRIPTION
    If hashtable provided as the Item property for a bulk filter access request for multiple accounts is not in the expected format, the request fails.
    This function formats the hashtable as expected.

	.PARAMETER Parameters
    The hashtable conatining the common properties for the access request.

	.EXAMPLE
    New-PASRequestObject @Item | ConvertTo-BulkFilterItem

    Converts the output of New-PASRequestObject into a hashtable containing all necessary key value pairs

	#>
    [CmdletBinding()]
    param (
        [parameter(
            Mandatory = $false,
            ValueFromPipeline = $true
        )]
        [hashtable]$Parameters
    )

    begin {

        #Default bulk filter request common properties
        $BulkFilterItem = @{
            Reason                 = $null
            TicketingSystemName    = $null
            TicketID               = $null
            multipleAccessRequired = $false
            fromDate               = 0
            toDate                 = 0
            AdditionalInfo         = $null
        }

    }

    process {

        #if passed paramters
        If ($null -ne $Parameters.Keys) {

            #iterate paramter keys
            $Parameters.keys | ForEach-Object {

                If ($BulkFilterItem.ContainsKey($PSItem)) {

                    #replace value of key value pair in Default bulk filter object
                    $BulkFilterItem[$PSItem] = $Parameters[$PSItem]

                }

            }

        }

        #return bulk filter request common properties
        $BulkFilterItem

    }

    end {

    }

}