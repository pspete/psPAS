Function Skip-CertificateCheck {
	<#
	.SYNOPSIS
	Bypass SSL Validation

	.DESCRIPTION
	Enables skipping of ssl certificate validation for current PowerShell session.

	.EXAMPLE
	Skip-CertificateCheck

	#>

	$CompilerParameters = New-Object System.CodeDom.Compiler.CompilerParameters
	$CompilerParameters.GenerateExecutable = $false
	$CompilerParameters.GenerateInMemory = $true
	$CompilerParameters.IncludeDebugInformation = $false
	$CompilerParameters.ReferencedAssemblies.Add('System.DLL') | Out-Null
	$CertificatePolicy = @'
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

	if ( -not (Test-IsCoreCLR)) {

		$CSharpCodeProvider = New-Object Microsoft.CSharp.CSharpCodeProvider
		$PolicyResult = $CSharpCodeProvider.CompileAssemblyFromSource($CompilerParameters, $CertificatePolicy)
		$CompiledAssembly = $PolicyResult.CompiledAssembly
		## Create an instance of TrustAll and attach it to the ServicePointManager
		$TrustAll = $CompiledAssembly.CreateInstance('Local.ToolkitExtensions.Net.CertificatePolicy.TrustAll')
		[System.Net.ServicePointManager]::CertificatePolicy = $TrustAll

	}

}