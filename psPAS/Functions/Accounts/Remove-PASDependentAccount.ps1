# .ExternalHelp psPAS-help.xml
function Remove-PASDependentAccount {
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

    begin {

        Assert-VersionRequirement -RequiredVersion 14.6
        #check if Privilege Cloud
		$isPcloud = $false
		if ($psPASSession.BaseUri -match 'cyberark.cloud') {
			$isPcloud = $true
		}

    }#begin

    process {

        #Create URL for Request
        if ($isPcloud) {
            $URI = "$($psPASSession.ApiURI)/api/accounts/$AccountID/account-dependents/$dependentAccountId"
        }
        else {
            $URI = "$($psPASSession.BaseURI)/API/Accounts/$AccountID/dependentAccounts/$dependentAccountId"
        }

        if ($PSCmdlet.ShouldProcess($AccountID, 'Remove Dependent Account')) {

            #Send request to web service
            Invoke-PASRestMethod -Uri $URI -Method DELETE

        }

    }#process

    end { }#end

}
