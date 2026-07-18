function Test-IsISPSS {
    <#
.SYNOPSIS
Tests if the module is running against P Cloud (ISPSS)

.DESCRIPTION
Returns "$true" if ISPSS is being used
Returns "$false" if self-hosted is being used

.EXAMPLE
Test-IsISPSS

Returns "$true" if run against ISPSS
Returns "$false" if run against self-hosted

#>

    if ($null -ne $psPASSession.ApiURI) {

        #$psPASSession.ApiURI is only set if authenticated against ISPSS
        $true

    } else {

        #Assumed self-hosted
        $false

    }

}