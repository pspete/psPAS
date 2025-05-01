# .ExternalHelp psPAS-help.xml
function Disable-PASCPMAutoManagement {
	[CmdletBinding(SupportsShouldProcess)]
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

	BEGIN {

		Assert-VersionRequirement -RequiredVersion 10.4

		$ops = [Collections.Generic.List[Object]]@(
			@{
				'path'  = '/secretManagement/automaticManagementEnabled'
				'op'    = 'replace'
				'value' = $false
			}
		)

	}#begin

	PROCESS {

		if ($PSCmdlet.ParameterSetName -eq 'manualManagementReason') {

			$null = $ops.Add(@{
					'path'  = '/secretManagement/manualManagementReason'
					'op'    = 'replace'
					'value' = $Reason
				})
		}

		# Only proceed with the operation if ShouldProcess returns true
		if ($PSCmdlet.ShouldProcess($AccountID, "Disable CPM Auto Management $(if($Reason){"with reason: $Reason"})")) {
			Set-PASAccount -AccountID $AccountID -operations $ops
		}

	}#process

	END { }#end

}