# .ExternalHelp psPAS-help.xml
function Set-PASPlatform {
    [System.Diagnostics.CodeAnalysis.SuppressMessageAttribute('PSUseSingularNouns', '', Justification = 'Settings matches the API endpoint terminology')]
    [CmdletBinding(SupportsShouldProcess)]
    param(

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [Alias('PlatformID')]
        [int]$id,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $false
        )]
        [ValidateSet('replace', 'remove')]
        [Alias('Operation')]
        [string]$op,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $false
        )]
        [ValidateSet('Policy/General/policyType', 'Policy/General/immediateInterval', 'Policy/General/interval', 'Policy/General/maxConcurrentConnections', 'Policy/General/searchForUsages',
            'Policy/General/looselyConnectedDevices', 'Policy/General/allowedSafes', 'Policy/cpmPlugin/dllName', 'Policy/cpmPlugin/exeName',
            'Policy/cpmPlugin/scriptName', 'Policy/cpmPlugin/scriptEngine', 'Policy/cpmPlugin/xmlFile', 'Policy/cpmPlugin/activationMethod',
            'Policy/cpmPlugin/protocolValidationEx', 'Policy/cpmPlugin/protocolValidationFileCategories', 'Policy/cpmPlugin/supportedBitness', 'Policy/cpmPlugin/supportedTechnology', 'Policy/additionalPolicySettings/promptsFilename',
            'Policy/additionalPolicySettings/processFilename', 'Policy/additionalPolicySettings/port', 'Policy/additionalPolicySettings/protocol', 'Policy/additionalPolicySettings/changeCommand' ,'Policy/additionalPolicySettings/reconcileCommand',
            'Policy/additionalPolicySettings/connectionCommand', 'Policy/additionalPolicySettings/dsn', 'Policy/additionalPolicySettings/reconcileIsWinAccount', 'Policy/additionalPolicySettings/reconcileWinExtraConnectionString', 'Policy/additionalPolicySettings/useSsl',
            'Policy/additionalPolicySettings/restartAppPool', 'Policy/additionalPolicySettings/commit', 'Policy/additionalPolicySettings/debug', 'Policy/additionalPolicySettings/disableAddressResolving', 'Policy/additionalPolicySettings/verifyMachineNameBeforeAction',
            'Policy/additionalPolicySettings/wmiCommandStatementFile', 'Policy/additionalPolicySettings/wmiReconcileCommandStatementFile', 'Policy/additionalPolicySettings/wmiRegistryReturnCodePath', 'Policy/additionalPolicySettings/unlockUserOnReconcile', 'Policy/additionalPolicySettings/changePasswordInResetMode',
            'Policy/additionalPolicySettings/convertFqdnToIP', 'Policy/additionalPolicySettings/commandForbiddenCharacters', 'Policy/additionalPolicySettings/commandBlackList', 'Policy/additionalPolicySettings/allowDomainUserAdHocAccess', 'Policy/additionalPolicySettings/domainUserAdHocAccessLimit',
            'Policy/additionalPolicySettings/adHocConnectionTimeout', 'Policy/additionalPolicySettings/adHocUserNamePrefix', 'Policy/additionalPolicySettings/adHocUserNameSuffix', 'General/description', 'General/name',
            'General/platformBaseId', 'General/platformBaseProtocol', 'General/platformBaseType', 'General/status')]
        [string]$path,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$value,

        [parameter(
            Mandatory = $false,
            ValueFromPipelinebyPropertyName = $true
        )]
        [hashtable[]]$operations
    )

    begin {
        Assert-VersionRequirement -SelfHosted
        Assert-VersionRequirement -RequiredVersion 15.2
    }#begin

    process {

        #Get all parameters that will be sent in the request
        $boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove InputObject, id

        #Create URL for Request
        $URI = "$($psPASSession.BaseURI)/API/platforms/targets/$id/settings"

        if ($PSBoundParameters.Keys -contains 'operations') {

            $boundParameters = $boundParameters['operations']

        }

        #Do Not Pipe into ConvertTo-JSON.
        #Correct JSON Format is only achieved when the array is not sent along the pipe
        $body = ConvertTo-Json @($boundParameters)

        if ($PSCmdlet.ShouldProcess($id, 'Update Platform Properties')) {

            #send request to PAS web service
            Invoke-PASRestMethod -Uri $URI -Method PATCH -Body $Body

        }

    }#process

    end { }#end

}