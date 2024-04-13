# .ExternalHelp psPAS-help.xml
Function Set-PASPTARule {
	[CmdletBinding(SupportsShouldProcess)]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateRange(1, [int]::MaxValue)]
		[string]$id,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet('SSH', 'WINDOWS', 'SCP', 'KEYSTROKES', 'SQL')]
		[string]$category,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$regex,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateRange(1, 100)]
		[int]$score,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[string]$description,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true
		)]
		[ValidateSet('NONE', 'TERMINATE', 'SUSPEND')]
		[string]$response,

		[parameter(
			Mandatory = $false,
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

		$PTARule = (Get-PASPTARule).Where({ $PSitem.ID -eq $id })
		if ($null -ne $PTARule) {
			Format-PutRequestObject -InputObject $PTARule -boundParameters $BoundParameters -ParametersToRemove mode, list
		}

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
				#translate parameter names into request property name
				#* Return only last 4 characters of parametername in lowercase
				#*vaultUsersMode & machinesMode translate to "mode"
				#*vaultUsersList & machinesList translate to "list"
				$property = ($PSItem).Substring(($PSItem).length - 4, 4).ToLower()

				if ($null -ne $PSBoundParameters[$PSItem]) {
					#Add scope parameter vaultUsers & machines request values to boundParameters
					$boundParameters['scope'][$scopeItem][$property] = $PSBoundParameters[$PSItem]
				} else {
					#clear vaultUsers/machine scope if null value specified
					$boundParameters['scope'][$scopeItem] = $null
				}


			}

		}

		switch ($boundParameters) {
			{ $PSItem.keys -contains 'scope' } {
				#BoundParameteters Contains Scope Key
				switch ($boundParameters['scope']) {
					{ $PSItem.ContainsKey('vaultUsers') -and (-not($PSItem.ContainsKey('machines'))) } {
						#vaultUser Scope is being updated - copy existing machines scope
						$boundParameters['scope']['machines'] = $PTARule.scope.machines
					}

					{ $PSItem.ContainsKey('machines') -and (-not($PSItem.ContainsKey('vaultUsers'))) } {
						#machines Scope is being updated - copy existing vaultUsers scope
						$boundParameters['scope']['vaultUsers'] = $PTARule.scope.vaultUsers
					}
				}

			}
			default {
				#No updated scope specified - Use existing scope copied from rule
				'third'
				$boundParameters['scope'] = $PTARule.scope
			}
		}
		#Create body of request
		#* Ensure JSON Depth of 3 to capture correct scope format
		$Body = $boundParameters | Get-PASParameter -ParametersToRemove $scopeParams | ConvertTo-Json -Depth 3

		if ($PSCmdlet.ShouldProcess($id, 'Update Risky Activity Rule')) {

			#send request to PAS web service
			Invoke-PASRestMethod -Uri $URI -Method PUT -Body $Body

		}

	}#process

	END { }#end

}