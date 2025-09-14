# .ExternalHelp psPAS-help.xml
function Disable-PASCPMAutoManagement {
	[CmdletBinding()]
	param(
		[parameter(
			Mandatory = $true,
			ValueFromPipelinebyPropertyName = $true
		)]
		[Alias('id')]
		[string]$AccountID,

		[parameter(
			Mandatory = $false,
			ValueFromPipelinebyPropertyName = $true,
			ParameterSetName = 'manualManagementReason'
		)]
		[string]$Reason

	)

	begin {

		Assert-VersionRequirement -RequiredVersion 10.4

		$ops = [Collections.Generic.List[Object]]@(
			@{
				'path'  = '/secretManagement/automaticManagementEnabled'
				'op'    = 'replace'
				'value' = $false
			}
		)

	}#begin

	process {

		if ($PSCmdlet.ParameterSetName -eq 'manualManagementReason') {

			$null = $ops.Add(@{
					'path'  = '/secretManagement/manualManagementReason'
					'op'    = 'replace'
					'value' = $Reason
				})
		}

		Set-PASAccount -AccountID $AccountID -operations $ops

	}#process

	end { }#end

}