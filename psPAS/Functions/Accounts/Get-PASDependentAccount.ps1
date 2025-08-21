# .ExternalHelp psPAS-help.xml
function Get-PASDependentAccount {
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$search,

        [parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$MasterAccountId,

        [parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
        [datetime]$modificationTime,

        [parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
        [string]$platformId,

        [parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
        [string]$SafeName,

        [parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
        [bool]$includeDeleted,

        [parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
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

        #define base URL
		$URI = "$($psPASSession.BaseURI)/API/dependentAccounts"

		#Get Parameters to include in request
		$boundParameters = $PSBoundParameters | Get-PASParameter -ParametersToRemove $Parameters
		$filterParameters = $PSBoundParameters | Get-PASParameter -ParametersToKeep $Parameters
		$FilterString = $filterParameters | ConvertTo-FilterString

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

            #Get default parameters to pass to Get-NextLink
            $DefaultParams = $PSBoundParameters | Get-PASParameter -ParametersToKeep TimeoutSec

            #return list
            $return = $Result | Get-NextLink @DefaultParams

        }

        if ($return) {

            #Return Results
            $return

        }



	}#process

	END { }#end

}