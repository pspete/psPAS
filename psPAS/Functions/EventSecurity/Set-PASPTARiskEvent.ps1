# .ExternalHelp psPAS-help.xml
Function Set-PASPTARiskEvent {
    [CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = '13.2')]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = '13.2'
        )]
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = '14.0'
        )]
        [string]$ID,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = '13.2'
        )]
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = '14.0'
        )]
        [ValidateSet('OPEN', 'CLOSED')]
        [string]$status,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = '14.0'
        )]
        [ValidateSet('HANDLED', 'NOTREAL', 'OTHER', 'NONE')]
        [string]$closeReason,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = '14.0'
        )]
        [ValidateLength(0, 100)]
        [string]$reasonText

    )

    BEGIN {
        Assert-VersionRequirement -SelfHosted
        Assert-VersionRequirement -RequiredVersion $PSCmdlet.ParameterSetName
    }#begin

    PROCESS {

        #Create request URL
        $URI = "$($psPASSession.BaseURI)/api/pta/API/Risks/RisksEvents/$ID"

        #Get Parameters to include in request
        $Body = $PSBoundParameters | Get-PASParameter -ParametersToRemove ID | ConvertTo-Json

        if ($PSCmdlet.ShouldProcess($EventID, 'Update Event Status')) {

            #Send request to web service
            $result = Invoke-PASRestMethod -Uri $URI -Method PATCH -Body $Body

        }

        If ($null -ne $result) {

            #Return Results
            $result | Add-ObjectDetail -typename psPAS.CyberArk.Vault.PTA.Event.Risk

        }

    }#process

    END { }#end

}