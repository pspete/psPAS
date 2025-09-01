# .ExternalHelp psPAS-help.xml
Function Add-PASThemeImage {
    [CmdletBinding(SupportsShouldProcess)]
    param(
        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [string]$Name,

        [parameter(
            Mandatory = $true,
            ValueFromPipelinebyPropertyName = $true
        )]
        [ValidateNotNullOrEmpty()]
        [ValidateScript( { Test-Path -Path $_ -PathType Leaf })]
        [string]$ImageFile

    )

    BEGIN {
        Assert-VersionRequirement -SelfHosted
        Assert-VersionRequirement -RequiredVersion 14.4
        $Request = @{}
		$Request['Method'] = 'POST'
        #Create URL for request
        $URI = "$($psPASSession.BaseURI)/API/Images/"
    }#begin

    PROCESS {

        #Convert File to byte array
        $FileBytes = $ImageFile | Get-ByteArray

        $Request['Body'] = @{
            'Name'      = $Name
            'Content'   = $FileBytes
        } | ConvertTo-Json
        $Request['Debug'] = $false

        if ($PSCmdlet.ShouldProcess($Name, 'Add Image')) {

			try {
				#send request to web service
				Invoke-PASRestMethod @Request
			} catch {
				throw $_
			}

		}

    }#process

    END { }#end
}