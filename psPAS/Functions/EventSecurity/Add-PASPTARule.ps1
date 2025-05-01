# .ExternalHelp psPAS-help.xml
Function Add-PASPTARule {
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet('SSH', 'WINDOWS', 'SCP', 'KEYSTROKES', 'SQL')]
		[string]$category,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$regex,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateRange(1, 100)]
		[int]$score,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$description,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet('NONE', 'TERMINATE', 'SUSPEND')]
		[string]$response,

		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[boolean]$active,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet('EXCLUDE', 'INCLUDE')]
		[string]$vaultUsersMode,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string[]]$vaultUsersList,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet('EXCLUDE', 'INCLUDE')]
		[string]$machinesMode,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string[]]$machinesList

	)

	BEGIN {
		Assert-VersionRequirement -SelfHosted
		Assert-VersionRequirement -RequiredVersion 10.4
		$userScopeParams = [Collections.Generic.List[String]]@('vaultUsersMode', 'vaultUsersList')
		$machineScopeParams = [Collections.Generic.List[String]]@('machinesMode', 'machinesList')
		$scopeParams = [Collections.Generic.List[String]]@($userScopeParams + $machineScopeParams)

	}#begin

	PROCESS {

		#Get all parameters that will be sent in the request
		$boundParameters = $PSBoundParameters | Get-PASParameter

		#Create URL for Request
		$URI = "$($psPASSession.BaseURI)/API/pta/API/Settings/RiskyActivity/"

		switch ($PSBoundParameters.keys) {

			{ $scopeParams -contains $PSItem } {

				#Current parameter relates to scope section of request object
				if (-not($boundParameters.ContainsKey('scope'))) {
					#create the scope key
					$boundParameters.Add('scope', @{})
				}

				#determine whether vaultUsers or machines scope item
				if ($userScopeParams -contains $PSItem) {
					$scopeItem = 'vaultUsers'
				} elseif ( $machineScopeParams -contains $PSItem) {
					$scopeItem = 'machines'
				}

				#add scope item key to bond parameters
				if (-not($boundParameters['scope'].ContainsKey($scopeItem))) {
					$boundParameters['scope'].Add($scopeItem, @{})
				}
				#translate paramer names into request property name
				#* Return only last 4 characters of parametername in lowercase
				#*vaultUsersMode & machinesMode translate to "mode"
				#*vaultUsersList & machinesList translate to "list"
				$property = ($PSItem).Substring(($PSItem).length - 4, 4).ToLower()

				#Add scope parameter vaultUsers & machines request values to boundParameters
				$boundParameters['scope'][$scopeItem][$property] = $PSBoundParameters[$PSItem]

			}

		}

		#Create body of request
		#* Ensure JSON Depth of 3 to capture correct scope format
		$Body = $boundParameters | Get-PASParameter -ParametersToRemove $scopeParams | ConvertTo-Json -Depth 3

		#send request to PAS web service
		$result = Invoke-PASRestMethod -Uri $URI -Method POST -Body $Body

		If ($null -ne $result) {

			#Return Results
			$result | Add-ObjectDetail -typename 'psPAS.CyberArk.Vault.PTA.Rule'

		}

	}#process

	END { }#end

}