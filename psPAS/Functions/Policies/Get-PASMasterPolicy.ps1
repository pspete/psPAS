function Get-PASMasterPolicy {
    [CmdletBinding()]
    param (
        [Parameter(
            Mandatory = $false,
            ValueFromPipeline = $true,
            ValueFromPipelineByPropertyName = $true
        )]
        [int]$PolicyId = 1
    )

    begin {
        Assert-VersionRequirement -SelfHosted
        Assert-VersionRequirement -RequiredVersion 14.6
        if ($PolicyId -ne 1) {
            Assert-VersionRequirement -RequiredVersion 15.0
        }
    }

    process {
        $URI = "$($psPASSession.BaseURI)/API/Policies/$PolicyId"

        $result = Invoke-PASRestMethod -Uri $URI -Method GET

        if ($null -ne $result) {
            $result
        }
    }

    end {}
}