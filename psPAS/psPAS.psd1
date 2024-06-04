@{

	# Script module or binary module file associated with this manifest.
	RootModule        = 'psPAS.psm1'

	# Version number of this module.
	ModuleVersion     = '6.4.85'

	# ID used to uniquely identify this module
	GUID              = '11c880d2-1430-4bd2-b6e8-f324741b460b'

	# Author of this module
	Author            = 'Pete Maan'

	# Company or vendor of this module
	# CompanyName       = ''

	# Copyright statement for this module
	Copyright         = '(c) 2017-2024 Pete Maan. All rights reserved.'

	# Description of the functionality provided by this module
	Description       = 'Module for CyberArk Privileged Access Security Web Service REST API'

	# Minimum version of the Windows PowerShell engine required by this module
	PowerShellVersion = '5.1'

	# Name of the Windows PowerShell host required by this module
	# PowerShellHostName = ''

	# Minimum version of the Windows PowerShell host required by this module
	# PowerShellHostVersion = ''

	# Minimum version of Microsoft .NET Framework required by this module
	# DotNetFrameworkVersion = ''

	# Minimum version of the common language runtime (CLR) required by this module
	# CLRVersion = ''

	# Processor architecture (None, X86, Amd64) required by this module
	# ProcessorArchitecture = ''

	# Modules that must be imported into the global environment prior to importing this module
	# RequiredModules = @()

	# Assemblies that must be loaded prior to importing this module
	# RequiredAssemblies = @()

	# Script files (.ps1) that are run in the caller's environment prior to importing this module.
	# ScriptsToProcess = @()

	# Type files (.ps1xml) to be loaded when importing this module
	TypesToProcess    = @(
		'xml\psPAS.CyberArk.Vault.Account.Type.ps1xml',
		'xml\psPAS.CyberArk.Vault.ACL.Type.ps1xml',
		'xml\psPAS.CyberArk.Vault.Credential.Type.ps1xml',
		'xml\psPAS.CyberArk.Vault.Safe.Type.ps1xml',
		'xml\psPAS.CyberArk.Vault.User.Type.ps1xml'
	)

	# Format files (.ps1xml) to be loaded when importing this module
	FormatsToProcess  = @(
		'xml\psPAS.CyberArk.Vault.Account.Formats.ps1xml',
		'xml\psPAS.CyberArk.Vault.ACL.Formats.ps1xml',
		'xml\psPAS.CyberArk.Vault.Application.Formats.ps1xml',
		'xml\psPAS.CyberArk.Vault.Credential.Formats.ps1xml',
		'xml\psPAS.CyberArk.Vault.OnboardingRule.Formats.ps1xml',
		'xml\psPAS.CyberArk.Vault.Platform.Formats.ps1xml',
		'xml\psPAS.CyberArk.Vault.PSM.Formats.ps1xml',
		'xml\psPAS.CyberArk.Vault.SSHKey.Formats.ps1xml',
		'xml\psPAS.CyberArk.Vault.Request.Formats.ps1xml',
		'xml\psPAS.CyberArk.Vault.Safe.Formats.ps1xml',
		'xml\psPAS.CyberArk.Vault.User.Formats.ps1xml',
		'xml\psPAS.CyberArk.Vault.Directory.Formats.ps1xml',
		'xml\psPAS.CyberArk.Vault.PTA.Formats.ps1xml',
		'xml\psPAS.CyberArk.Vault.Group.Formats.ps1xml'
	)

	# Functions to export from this module
	FunctionsToExport = @(
		'New-PASSession',
		'Close-PASSession',
		'Add-PASPublicSSHKey',
		'Get-PASPublicSSHKey',
		'Remove-PASPublicSSHKey',
		'Add-PASAccount',
		'Get-PASAccount',
		'Remove-PASAccount',
		'Set-PASAccount',
		'Add-PASSafe',
		'Set-PASSafe',
		'Remove-PASSafe',
		'Add-PASSafeMember',
		'Set-PASSafeMember',
		'Remove-PASSafeMember',
		'Get-PASPolicyACL',
		'Add-PASPolicyACL',
		'Remove-PASPolicyACL',
		'Get-PASAccountACL',
		'Add-PASAccountACL',
		'Remove-PASAccountACL',
		'Get-PASApplication',
		'Add-PASApplication',
		'Add-PASApplicationAuthenticationMethod',
		'Remove-PASApplication',
		'Remove-PASApplicationAuthenticationMethod',
		'Unblock-PASUser',
		'Set-PASUser',
		'Remove-PASUser',
		'New-PASUser',
		'Get-PASUser',
		'Get-PASLoggedOnUser',
		'Add-PASGroupMember',
		'Get-PASAccountActivity',
		'Add-PASPendingAccount',
		'Get-PASSafe',
		'Add-PASAccountGroupMember',
		'New-PASAccountGroup',
		'New-PASOnboardingRule',
		'Get-PASOnboardingRule',
		'Remove-PASOnboardingRule',
		'Get-PASServer',
		'Get-PASSafeShareLogo',
		'Get-PASServerWebService',
		'Get-PASAccountPassword',
		'Get-PASSafeMember',
		'Get-PASApplicationAuthenticationMethod',
		'Get-PASPlatform',
		'Unlock-PASAccount',
		'Get-PASAccountGroup',
		'Get-PASAccountGroupMember',
		'Remove-PASAccountGroupMember',
		'New-PASRequest',
		'Remove-PASRequest',
		'Approve-PASRequest',
		'Deny-PASRequest',
		'Get-PASRequest',
		'Get-PASRequestDetail',
		'New-PASPSMSession',
		'Get-PASPSMRecording',
		'Get-PASPSMSession',
		'Stop-PASPSMSession',
		'Get-PASComponentSummary',
		'Get-PASComponentDetail',
		'Suspend-PASPSMSession',
		'Resume-PASPSMSession',
		'Import-PASPlatform',
		'Import-PASConnectionComponent',
		'Export-PASPlatform',
		'Get-PASUserLoginInfo',
		'Get-PASDirectory',
		'Add-PASDirectory',
		'New-PASDirectoryMapping',
		'Get-PASPTAEvent',
		'Get-PASPTARemediation',
		'Set-PASPTARemediation',
		'Get-PASPTARule',
		'Set-PASPTARule',
		'Add-PASPTARule',
		'Get-PASGroup',
		'Remove-PASGroupMember',
		'Set-PASOnboardingRule',
		'Add-PASDiscoveredAccount',
		'Connect-PASPSMSession',
		'Get-PASPSMSessionActivity',
		'Get-PASPSMRecordingActivity',
		'Get-PASPSMRecordingProperty',
		'Get-PASPSMSessionProperty',
		'Export-PASPSMRecording',
		'Request-PASJustInTimeAccess',
		'Get-PASDirectoryMapping',
		'Remove-PASDirectory',
		'Set-PASDirectoryMapping',
		'Find-PASSafe',
		'Get-PASSession',
		'Use-PASSession',
		'Invoke-PASCPMOperation',
		'Set-PASUserPassword',
		'Set-PASDirectoryMappingOrder',
		'Enable-PASCPMAutoManagement',
		'New-PASGroup',
		'Get-PASPlatformSafe',
		'Remove-PASDirectoryMapping',
		'Disable-PASCPMAutoManagement',
		'Test-PASPSMRecording',
		'Set-PASPTAEvent',
		'Copy-PASPlatform',
		'Disable-PASPlatform',
		'Enable-PASPlatform',
		'Remove-PASPlatform',
		'Remove-PASGroup',
		'Get-PASAllowedReferrer',
		'Add-PASAllowedReferrer',
		'Get-PASAccountSSHKey',
		'Get-PASAuthenticationMethod',
		'Add-PASAuthenticationMethod',
		'Set-PASAuthenticationMethod',
		'Get-PASConnectionComponent',
		'Get-PASPSMServer',
		'Get-PASPlatformPSMConfig',
		'Set-PASPlatformPSMConfig',
		'New-PASAccountObject',
		'Start-PASAccountImportJob',
		'Get-PASAccountImportJob',
		'Get-PASDiscoveredAccount',
		'Add-PASOpenIDConnectProvider',
		'Get-PASOpenIDConnectProvider',
		'Set-PASOpenIDConnectProvider',
		'Remove-PASOpenIDConnectProvider',
		'Remove-PASAuthenticationMethod',
		'Set-PASGroup',
		'Set-PASLinkedAccount',
		'Clear-PASDiscoveredAccountList',
		'New-PASAccountPassword',
		'Get-PASAccountPasswordVersion',
		'New-PASPrivateSSHKey',
		'Remove-PASPrivateSSHKey',
		'Clear-PASPrivateSSHKey',
		'Revoke-PASJustInTimeAccess',
		'Get-PASAccountDetail',
		'Clear-PASLinkedAccount',
		'Get-PASPlatformSummary',
		'Enable-PASUser',
		'Disable-PASUser',
		'Publish-PASDiscoveredAccount',
		'Get-PASLinkedAccount',
		'Add-PASPersonalAdminAccount',
		'Add-PASPTAGlobalCatalog',
		'Get-PASPTAGlobalCatalog',
		'New-PASRequestObject',
		'Get-PASPTARiskEvent',
		'Set-PASPTARiskEvent',
		'Get-PASPTARiskSummary',
		'Get-PASUserTypeInfo',
		'Get-PASPTAPrivilegedUser',
		'Get-PASPTAPrivilegedGroup',
		'Remove-PASPTAPrivilegedUser',
		'Remove-PASPTAPrivilegedGroup',
		'Add-PASPTAPrivilegedUser',
		'Add-PASPTAPrivilegedGroup',
		'Get-PASPTAIncludedTarget',
		'Get-PASPTAExcludedTarget',
		'Add-PASPTAIncludedTarget',
		'Add-PASPTAExcludedTarget',
		'Remove-PASPTAIncludedTarget',
		'Remove-PASPTAExcludedTarget',
		'Get-PASLinkedGroup',
		'Set-PASIPAllowList',
		'Get-PASIPAllowList',
		'Get-PASBYOKConfig',
		'Get-PASDiscoveredLocalAccount',
		'Get-PASDiscoveredLocalAccountActivity',
		'Publish-PASDiscoveredLocalAccount',
		'Add-PASDiscoveredLocalAccount',
		'Clear-PASDiscoveredLocalAccount',
		'Remove-PASDiscoveredLocalAccount'
	)

	#AliasesToExport   = @()

	# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
	PrivateData       = @{

		PSData = @{

			# Tags applied to this module. These help with module discovery in online galleries.
			Tags         = @('CyberArk', 'REST', 'API', 'Security')

			# A URL to the license for this module.
			LicenseUri   = 'https://github.com/pspete/psPAS/blob/master/LICENSE.md'

			# A URL to the main website for this project.
			ProjectUri   = 'https://pspas.pspete.dev/'

			# A URL to an icon representing this module.
			IconUri      = 'https://pspas.pspete.dev/assets/images/symbol.png'

			# ReleaseNotes of this module
			ReleaseNotes = 'https://github.com/pspete/psPAS/blob/master/CHANGELOG.md'

		} # End of PSData hashtable

	} # End of PrivateData hashtable

}
