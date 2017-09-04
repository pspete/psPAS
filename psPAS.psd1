@{

	# Script module or binary module file associated with this manifest.
	RootModule        = 'psPAS.psm1'

	# Version number of this module.
	ModuleVersion     = '0.0.6'

	# ID used to uniquely identify this module
	GUID              = '11c880d2-1430-4bd2-b6e8-f324741b460b'

	# Author of this module
	Author            = 'Pete Maan'

	# Company or vendor of this module
	# CompanyName = ''

	# Copyright statement for this module
	Copyright         = '(c) 2017 Pete Maan. All rights reserved.'

	# Description of the functionality provided by this module
	Description       = 'Module to expose CyberArk REST API/Web Service functions'

	# Minimum version of the Windows PowerShell engine required by this module
	PowerShellVersion = '3.0'

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
	#TypesToProcess = @()

	# Format files (.ps1xml) to be loaded when importing this module
	FormatsToProcess  = 'psPAS.Format.ps1xml'


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
		'Start-PASCredChange',
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
		'Get-PASApplications',
		'Get-PASApplication',
		'Add-PASApplication',
		'Get-PASApplicationAuthenticationMethods',
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
		'Get-PASAccountCredentials',
		'Add-PASPendingAccount',
		'Start-PASCredVerify',
		'Get-PASSafe',
		'Get-PASSafeMembers',
		'Add-PASAccountGroupMember',
		'New-PASAccountGroup',
		'New-PASOnboardingRule',
		'Get-PASOnboardingRule',
		'Remove-PASOnboardingRule',
		'Get-PASServer',
		'Get-PASSafeShareLogo',
		'Get-PASServerWebService',
		'New-PASSAMLSession',
		'ClosePASSAMLSession',
		'New-PASSharedSession',
		'Close-PASSharedSession'
	)

	# Private data to pass to the module specified in RootModule/ModuleToProcess. This may also contain a PSData hashtable with additional module metadata used by PowerShell.
	PrivateData       = @{

		PSData = @{

			# Tags applied to this module. These help with module discovery in online galleries.
			Tags       = @('CyberArk', 'REST API', 'REST', 'Web Service')

			# A URL to the license for this module.
			LicenseUri = 'https://github.com/pspete/psPAS/blob/master/LICENSE.md'

			# A URL to the main website for this project.
			ProjectUri = 'https://github.com/pspete/psPAS'

			# A URL to an icon representing this module.
			# IconUri = ''

			# ReleaseNotes of this module
			# ReleaseNotes = ''

		} # End of PSData hashtable

	} # End of PrivateData hashtable

}