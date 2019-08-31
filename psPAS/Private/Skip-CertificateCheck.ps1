Function Skip-CertificateCheck {
	<#
	.SYNOPSIS
	Bypass SSL Validation

	.DESCRIPTION
	Enables skipping of ssl certificate validation for current PowerShell session.

	.EXAMPLE
	Skip-CertificateCheck

	#>

	#Only required to be executed once per ps session
	$Provider = New-Object Microsoft.CSharp.CSharpCodeProvider
	$Compiler = $Provider.CreateCompiler()
	$Params = New-Object System.CodeDom.Compiler.CompilerParameters
	$Params.GenerateExecutable = $false
	$Params.GenerateInMemory = $true
	$Params.IncludeDebugInformation = $false
	$Params.ReferencedAssemblies.Add("System.DLL") | Out-Null
	$TASource = @'
        namespace Local.ToolkitExtensions.Net.CertificatePolicy
        {
            public class TrustAll : System.Net.ICertificatePolicy
            {
                public bool CheckValidationResult(System.Net.ServicePoint sp,System.Security.Cryptography.X509Certificates.X509Certificate cert, System.Net.WebRequest req, int problem)
                {
                    return true;
                }
            }
        }
'@

	$TAResults = $Provider.CompileAssemblyFromSource($Params, $TASource)
	$TAAssembly = $TAResults.CompiledAssembly
	## Create an instance of TrustAll and attach it to the ServicePointManager
	$TrustAll = $TAAssembly.CreateInstance("Local.ToolkitExtensions.Net.CertificatePolicy.TrustAll")
	[System.Net.ServicePointManager]::CertificatePolicy = $TrustAll
}