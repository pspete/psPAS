# .ExternalHelp psPAS-help.xml
function New-PASRequestObject {
    [CmdletBinding(SupportsShouldProcess, DefaultParameterSetName = 'ConnectionParams')]
    param(
        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [string]$AccountId,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$Reason,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$TicketingSystemName,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$TicketID,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [boolean]$MultipleAccessRequired,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [datetime]$FromDate,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [datetime]$ToDate,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [hashtable]$AdditionalInfo,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [boolean]$UseConnect,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$ConnectionComponent,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'ConnectionParams'
        )]
        [ValidateSet('Yes', 'No')]
        [string]$AllowMappingLocalDrives,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'ConnectionParams'
        )]
        [ValidateSet('Yes', 'No')]
        [string]$AllowConnectToConsole,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'ConnectionParams'
        )]
        [ValidateSet('Yes', 'No')]
        [string]$RedirectSmartCards,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'ConnectionParams'
        )]
        [string]$PSMRemoteMachine,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'ConnectionParams'
        )]
        [string]$LogonDomain,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'ConnectionParams'
        )]
        [ValidateSet('Yes', 'No')]
        [string]$AllowSelectHTML5,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'ManualParams'
        )]
        [hashtable]$ConnectionParams
    )

    BEGIN { }#begin

    PROCESS {

        $boundParameters = $PSBoundParameters | Get-PASParameter

        if ($boundParameters.ContainsKey('FromDate')) {

            #convert to unix time
            $boundParameters['FromDate'] = $FromDate | ConvertTo-UnixTime

        }

        if ($boundParameters.ContainsKey('ToDate')) {

            #convert to unix time
            $boundParameters['ToDate'] = $ToDate | ConvertTo-UnixTime

        }

        #Nest parameters "AllowMappingLocalDrives", "AllowConnectToConsole","RedirectSmartCards",
        #"PSMRemoteMachine", "LogonDomain" & "AllowSelectHTML5" under ConnectionParams Property
        $boundParameters = $boundParameters | ConvertTo-ConnectionParam

        if ($PSCmdlet.ShouldProcess($AccountId, 'Create Request Object Definition')) {

            $boundParameters

        }

    }#process

    END { }#end

}