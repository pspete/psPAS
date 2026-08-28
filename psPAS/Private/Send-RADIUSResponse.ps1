function Send-RADIUSResponse {
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

    begin {

        #Default value for the Read-Host prompt.
        $Prompt = 'Enter OTP'

    }

    process {

        #OTP value has not yet been provided.
        #Initial RADIUS auth attempt will trigger notification of OTP for user to provide.
        #?"passcode" remains an option for backward compatibility.
        if ((-not ($PSBoundParameters.ContainsKey('OTP'))) -or ($PSBoundParameters['OTP'] -match 'passcode')) {

            if ($null -ne $Message) {

                #*The message from the exception containing challenge instructions from the RADIUS server.
                $Prompt = $Message

            }

            #Prompt user for OTP or Challenge Response
            $OTP = $(Read-Host -Prompt $Prompt)

        }

        #Construct Request Body with $OTP value as RADIUS response
        #New-PASSession (and this function on recursion) provides Body as raw UTF8 bytes;
        #decode back to a string before parsing so the JSON isn't enumerated byte-by-byte.
        $RawBody = $LogonRequest['Body']
        if ($RawBody -is [byte[]]) {

            $RawBody = [System.Text.Encoding]::UTF8.GetString($RawBody)

        }
        $Body = $RawBody | ConvertFrom-Json | Select-Object username
        $Body | Add-Member -MemberType NoteProperty -Name 'Password' -Value $OTP -Force

        #Send as raw UTF8 bytes rather than a String so ParameterBinding/module logging of this
        #call records a non-revealing type name instead of the literal request content.
        $LogonRequest['Body'] = [System.Text.Encoding]::UTF8.GetBytes($($Body | ConvertTo-Json))

        try {

            #Respond to RADIUS challenge
            Invoke-PASRestMethod @LogonRequest

        } catch {

            if ($PSItem.FullyQualifiedErrorId -notmatch 'ITATS542I') {

                #Throw all errors not related to ITATS542I
                throw $PSItem

            } else {

                #ITATS542I indicates further challenge required
                #pass $LogonRequest and challenge message back into this function
                Send-RADIUSResponse -LogonRequest $LogonRequest -Message "$($PSItem.Exception.Message)"

            }

        }

    }

    end {}

}