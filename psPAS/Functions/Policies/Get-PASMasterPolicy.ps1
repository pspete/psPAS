Function Get-PASMasterPolicy {
    [CmdletBinding()]
    param (
        <#
        [Parameter(
            Mandatory = $true,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true
        )]
        [int]$PolicyId
        #>
    )

    Begin{
        Assert-VersionRequirement -RequiredVersion 14.6
        $PolicyId = 1
    }

    Process{
        $URI = "$($psPASSession.BaseURI)/API/Policies/$PolicyId"

        $result = Invoke-PASRestMethod -Uri $URI -Method GET

        if($null -ne $result) {
            $result
        }
    }

    End{}
}