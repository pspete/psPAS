# .ExternalHelp psPAS-help.xml
function Get-PASDependentAccount {
	[CmdletBinding()]
	param(
        [parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'SpecificAccount'
		)]
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'SpecificDependentAccount'
		)]
		[Alias('AccountID')]
		[string]$id,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'SpecificDependentAccount'
		)]
		[string]$dependentAccountId,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'AllDependentAccounts'
		)]
        [parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'SpecificAccount'
		)]
		[string]$search,

        [parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'AllDependentAccounts'
		)]
		[string]$MasterAccountId,

        [parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'AllDependentAccounts'
		)]
        [parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'SpecificAccount'
		)]
        [datetime]$modificationTime,

        [parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'AllDependentAccounts'
		)]
        [parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'SpecificAccount'
		)]
        [string]$platformId,

        [parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'AllDependentAccounts'
		)]
        [string]$SafeName,

        [parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'AllDependentAccounts'
		)]
        [bool]$includeDeleted,

        [parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'SpecificAccount'
		)]
        [bool]$failed,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'SpecificDependentAccount'
		)]
		[bool]$extendedDetails,

        [parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
            ParameterSetName = 'AllDependentAccounts'
		)]
		[ValidateRange(1, 1000)]
		[int]$limit,

        [parameter(
			Mandatory = $false,
			ValueFromPipelineByPropertyName = $false
		)]
		[int]$TimeoutSec

	)

	BEGIN {

		#check required version
		Assert-VersionRequirement -RequiredVersion 14.6

        #Parameter to include as filter value in url
		$Parameters = [Collections.Generic.List[String]]@('MasterAccountId', 'modificationTime', 'platformId', 'SafeName')

	}#begin

	PROCESS {

		#Get Parameters to include in request
		$boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove $Parameters, id, dependentAccountId
		$filterParameters = $PSBoundParameters | Get-PASParameter -ParametersToKeep $Parameters
		$FilterString = $filterParameters | ConvertTo-FilterString

        switch ($PSCmdlet.ParameterSetName) {

                'SpecificAccount' {

                    #define base URL
		            $URI = "$($psPASSession.BaseURI)/API/Accounts/$id/dependentAccounts"
					break

                }

                'AllDependentAccounts' {

                    #define base URL
		            $URI = "$($psPASSession.BaseURI)/API/dependentAccounts"
					break

                }

				'SpecificDependentAccount'{

					#define base URL
					$URI = "$($psPASSession.BaseURI)/API/Accounts/$id/dependentAccounts/$($dependentAccountId)"
					break

				}

        }

        If ($null -ne $FilterString) {

            $boundParameters = $boundParameters + $FilterString

        }

        #Create Query String, escaped for inclusion in request URL
        $queryString = $boundParameters | ConvertTo-QueryString

        If ($null -ne $queryString) {

            #Build URL from base URL
            $URI = "$URI`?$queryString"

        }

		#Send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET -TimeoutSec $TimeoutSec

		If ($null -ne $result) {

			switch ($PSCmdlet.ParameterSetName) {

				( { $PSItem -match '^Specific' } ){
					$return = $Result
					break
				}

				'AllDependentAccounts' {
					# Get default parameters to pass to Get-NextLink
					$DefaultParams = $PSBoundParameters | Get-PASParameter -ParametersToKeep TimeoutSec
					#return list
            		$return = $Result | Get-NextLink @DefaultParams

					break
				}

        }

        if ($return) {

            #Return Results
            $return

        }

	}#process

	END { }#end

}