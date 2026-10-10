# .ExternalHelp psPAS-help.xml
function Get-PASComponentSummary {
	[CmdletBinding()]
	param(

	)

	begin {
		Assert-VersionRequirement -RequiredVersion 10.1
	}#begin

	process {

		#Create URL for request
		$URI = "$($psPASSession.BaseURI)/api/ComponentsMonitoringSummary"

		#send request to web service
		$result = Invoke-PASRestMethod -Uri $URI -Method GET

		if ($null -ne $result) {

			$result | Select-Object -ExpandProperty Components

			# Process vaults with conditional property selection
			$vaults = $result | Select-Object -ExpandProperty Vaults | Add-ObjectDetail -PropertyToAdd @{
				'ComponentID'   = 'EPV'
				'ComponentName' = 'EPV'
			}

			# Output Primary vaults without replication fields
			$vaults | Where-Object { $_.Role -ne 'DR' } | Select-Object ComponentID, ComponentName, Role, IP, IsLoggedOn

			# Check if version supports replication status fields (14.6+)
			$currentVersion = [System.Version]::new($psPASSession.ExternalVersion)
			$requiredVersion = [System.Version]::new('14.6.0')
			$supportsReplicationStatus = $currentVersion -ge $requiredVersion

			# Output DR vaults with conditional replication fields based on version
			if ($supportsReplicationStatus) {
				# Version 14.6+: Include replication status fields
				$vaults | Where-Object { $_.Role -eq 'DR' } | Select-Object ComponentID, ComponentName, Role, IP, IsLoggedOn, @{
					Name       = 'DBReplicationDiffSecs'
					Expression = { if ($_.ReplicationStatus) { $_.ReplicationStatus.DBReplicationDiffSecs } else { $null } }
				}, @{
					Name       = 'IsDBReplicationHealthy'
					Expression = { if ($_.ReplicationStatus) { $_.ReplicationStatus.IsDBReplicationHealthy } else { $null } }
				}, @{
					Name       = 'FileReplicationDiffSecs'
					Expression = { if ($_.ReplicationStatus) { $_.ReplicationStatus.FileReplicationDiffSecs } else { $null } }
				}, @{
					Name       = 'IsFileReplicationHealthy'
					Expression = { if ($_.ReplicationStatus) { $_.ReplicationStatus.IsFileReplicationHealthy } else { $null } }
				}
			} else {
				# Version < 14.6: Show basic DR vault information without replication fields
				$vaults | Where-Object { $_.Role -eq 'DR' } | Select-Object ComponentID, ComponentName, Role, IP, IsLoggedOn
			}

		}

	}#process

	end { }#end

}