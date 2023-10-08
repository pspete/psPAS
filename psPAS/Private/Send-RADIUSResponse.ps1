Function Send-RADIUSResponse {
    <#
    .SYNOPSIS
    Sends RADIUS challenge response as part of PAS logon process

    .DESCRIPTION
    psPAS helper function.
    Sends (RADIUS) logon request to Invoke-PASRestMethod,
    if response indicates RADIUS challenge, prompts for input.

    .PARAMETER LogonRequest
    The required parameters for PAS logon as defined in New-PASSession

    .PARAMETER Message
    An optional message to display as a prompt detailing the RADIUS challenge criteria

    .PARAMETER OTP
    An optional OTP value to provide as challenge response.

    .EXAMPLE
    Send-RADIUSResponse -LogonRequest $LogonRequest -Message "Some Message"
    #>
    [CmdletBinding()]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelineByPropertyName = $true)]
        [hashtable]$LogonRequest,

        [parameter(
            Mandatory = $false,
            ValueFromPipelineByPropertyName = $true)]
        [string]$Message,

        [parameter(
            Mandatory = $false,
            ValueFromPipelineByPropertyName = $true)]
        [string]$OTP
    )

    Begin {

        #Default value for the Read-Host prompt.
        $Prompt = 'Enter OTP'

    }

    Process {

        #OTP value has not yet been provided.
        #Initial RADIUS auth attempt will trigger notification of OTP for user to provide.
        #?"passcode" remains an option for backward compatibility.
        If ((-not ($PSBoundParameters.ContainsKey('OTP'))) -or ($PSBoundParameters['OTP'] -match 'passcode')) {

            If ($null -ne $Message) {

                #*The message from the exception containing challenge instructions from the RADIUS server.
                $Prompt = $Message

            }

            #Prompt user for OTP or Challenge Response
            $OTP = $(Read-Host -Prompt $Prompt)

        }

        #Construct Request Body with $OTP value as RADIUS response
        $Body = $LogonRequest['Body'] | ConvertFrom-Json | Select-Object username
        $Body | Add-Member -MemberType NoteProperty -Name 'Password' -Value $OTP -Force
        $LogonRequest['Body'] = $Body | ConvertTo-Json

        try {

            #Respond to RADIUS challenge
            Invoke-PASRestMethod @LogonRequest

        } catch {

            if ($PSItem.FullyQualifiedErrorId -notmatch 'ITATS542I') {

                #Throw all errors not related to ITATS542I
                throw $PSItem

            } Else {

                #ITATS542I indicates further challenge required
                #pass $LogonRequest and challenge message back into this function
                Send-RADIUSResponse -LogonRequest $LogonRequest -Message "$($PSItem.Exception.Message)"

            }

        }

    }

    End {}

}