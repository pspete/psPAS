Function Set-PASMasterPolicy {
    [CmdletBinding()]
    param (
<#
    [Parameter(
        Mandatory = $true,
        ValueFromPipeline = $true,
        ValueFromPipelineByPropertyName = $true
    )]
    [int]$PolicyId,
#>
    [Parameter(
        Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        HelpMessage = "Dual control policy."
    )]
    [bool]$DualControl = $false,

    [Parameter(
        Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        HelpMessage = "Multi-level approval policy."
    )]
    [bool]$MultiLevelApproval = $false,

    [Parameter(
        Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        HelpMessage = "Only managers approval policy."
    )]
    [bool]$OnlyManagersApproval = $false,

    [Parameter(
        Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        HelpMessage = "Number of confirmers policy."
    )]
    [int]$ConfirmersNumber = 0,

    [Parameter(
        Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        HelpMessage = "Enforce exclusive access policy."
    )]
    [bool]$EnforceExclusiveAccess = $false,

    [Parameter(
        Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        HelpMessage = "Enforce one-time password policy."
    )]
    [bool]$EnforceOneTimePassword = $false,

    [Parameter(
        Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        HelpMessage = "Transparent connection policy."
    )]
    [bool]$TransparentConnection = $false,

    [Parameter(
        Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        HelpMessage = "Allow view password policy."
    )]
    [bool]$AllowViewPassword = $false,

    [Parameter(
        Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        HelpMessage = "Require reason policy."
    )]
    [bool]$RequireReason = $false,

    [Parameter(
        Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        HelpMessage = "Allow free text policy."
    )]
    [bool]$AllowFreeText = $false,

    [Parameter(
        Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        HelpMessage = "Password change days policy."
    )]
    [int]$PasswordChangeDays = 0,

    [Parameter(
        Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        HelpMessage = "Password verification days policy."
    )]
    [int]$PasswordVerificationDays = 0,

    [Parameter(
        Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        HelpMessage = "Require monitoring and isolation policy."
    )]
    [bool]$RequireMonitoringAndIsolation = $false,

    [Parameter(
        Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        HelpMessage = "Record activity policy."
    )]
    [bool]$RecordActivity = $false,

    [Parameter(
        Mandatory = $false,
        ValueFromPipelineByPropertyName = $true,
        HelpMessage = "Retention period policy."
    )]
    [int]$RetentionPeriod = 0
)

    Begin{
        Assert-VersionRequirement -RequiredVersion 14.6
        $PolicyId = 1
    }

    Process{
        $URI = "$($psPASSession.BaseURI)/API/Policies/$PolicyId"

        #Get request parameters
		$boundParameters = $PSBoundParameters | Get-PASParameter

        $originalMasterPolicy = Get-PASMasterPolicy

        # Flattened object with just the .Value properties
        $flattenedMasterPolicy = [PSCustomObject]@{}

        foreach ($prop in $originalMasterPolicy.PSObject.Properties) {
            $flattenedMasterPolicy | Add-Member -MemberType NoteProperty -Name $prop.Name -Value $prop.Value.Value
        }

		if ($null -ne $originalMasterPolicy) {
			Format-PutRequestObject -InputObject $flattenedMasterPolicy -boundParameters $boundParameters
		}

        #Create body of request
		$body = $boundParameters | ConvertTo-Json

        if ($PSCmdlet.ShouldProcess($PolicyId, 'Update Master Policy')) {

            $result = Invoke-PASRestMethod -Uri $URI -Method PUT -Body $body

            if($null -ne $result) {
                $result
            }
        }
    }

    End{}
}