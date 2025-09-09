# .ExternalHelp psPAS-help.xml
function Get-PASDependentAccount {
	[CmdletBinding(DefaultParameterSetName = 'AllDependentAccounts')]
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

					If ($PSBoundParameters.Keys -notcontains 'Limit') {
						$Limit = 100   #default limit
						$boundParameters.Add('Limit', $Limit) # Add to boundparameters for inclusion in query string
					}

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

		$Total = $result.Total

		If ($Total -gt 0) {

			#Set events as output collection
			$DependentAccounts = [Collections.Generic.List[Object]]::New(@($result.DependentAccounts))

			#Split Request URL into baseURI & any query string value
			$URLString = $URI.Split('?')
			$URI = $URLString[0]
			$queryString = $URLString[1]

			For ( $Offset = $Limit ; $Offset -lt $Total ; $Offset += $Limit ) {

				#While more DependentAccounts to return, create nextLink query value
				$nextLink = "OffSet=$Offset"

				if ($null -ne $queryString) {

					#If original request contained a queryString, concatenate with nextLink value.
					$nextLink = "$queryString&$nextLink"

				}
				$result = (Invoke-PASRestMethod -Uri "$URI`?$nextLink" -Method GET).DependentAccounts

				#Request nextLink. Add DependentAccounts to output collection.
				$Null = $DependentAccounts.AddRange($result)
			}

			$Result = $DependentAccounts

		}

		If ($null -ne $result) {

			$Result

		}

	}#process

	END { }#end

}