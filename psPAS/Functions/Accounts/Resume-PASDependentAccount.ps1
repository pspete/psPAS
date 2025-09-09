# .ExternalHelp psPAS-help.xml
Function Resume-PASDependentAccount {
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
        [string]$dependentAccountId

    )

    BEGIN {

        Assert-VersionRequirement -RequiredVersion 14.6

    }#begin

    PROCESS {

        #Create URL for Request
        $URI = "$($psPASSession.BaseURI)/API/Accounts/$AccountID/dependentAccounts/$dependentAccountId/Resume"

        if ($PSCmdlet.ShouldProcess($AccountID, "Resume Dependent Account")) {

            #Send request to web service
            Invoke-PASRestMethod -Uri $URI -Method POST

        }

    }#process

    END { }#end

}
