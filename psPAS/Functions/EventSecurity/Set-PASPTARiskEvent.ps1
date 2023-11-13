# .ExternalHelp psPAS-help.xml
Function Set-PASPTARiskEvent {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$EventID,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateSet('OPEN', 'CLOSED')]
        [string]$Status

    )

    BEGIN {
        Assert-VersionRequirement -RequiredVersion 13.2
    }#begin

    PROCESS {

        #Create request URL
        $URI = "$Script:BaseURI/API/pta/API/Risks/RiskEvents/$EventID"

        #Get Parameters to include in request
        $Body = $PSBoundParameters | Get-PASParameter -ParametersToRemove EventID | ConvertTo-Json

        if ($PSCmdlet.ShouldProcess($EventID, 'Update Event Status')) {

            #Send request to web service
            $result = Invoke-PASRestMethod -Uri $URI -Method PATCH -Body $Body -WebSession $Script:WebSession

        }

        If ($null -ne $result) {

            #Return Results
            $result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.PTA.Event.Risk

        }

    }#process

    END { }#end

}