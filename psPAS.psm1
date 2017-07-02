<#
.SYNOPSIS

.DESCRIPTION

.EXAMPLE

.INPUTS

.OUTPUTS

.NOTES

.LINK

#>
[CmdletBinding()]  
param()

#Get function files
Write-Verbose $PSScriptRoot 

Get-ChildItem $PSScriptRoot\ -Recurse -Filter *.ps1 -ErrorAction SilentlyContinue | 

    Foreach {
    
        Try{
            
            #Dot Source each file
            . $_.fullname

        }

        Catch{

            Write-Error "Failed to import function $($_.fullname)"

        }
        
    
    }