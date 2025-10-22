# .ExternalHelp psPAS-help.xml
function Remove-PASRemediationRuleSet {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$id
    )

    begin {

        Assert-VersionRequirement -PrivilegeCloud

    }

    process {

        #Create URL for Request
        $URI = "$($psPASSession.ApiURI)/api/discovery-rule-sets/$id"

        if ($PSCmdlet.ShouldProcess($id, 'Remove Remediation Rule Set')) {

            #Send Delete request to web service
            Invoke-PASRestMethod -Uri $URI -Method DELETE

        }

    }

    end {}

}