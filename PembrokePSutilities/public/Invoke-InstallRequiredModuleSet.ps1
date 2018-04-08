function Invoke-InstallRequiredModuleSet {
    <#
	.DESCRIPTION
		This function will Install additional Modules for a PembrokePS component.
    .PARAMETER RequiredModuleSet
        A RequiredModuleSet is Required.
	.EXAMPLE
        Invoke-InstallRequiredModuleSet -RequiredModuleSet "Powerlumber,PembrokePSrest"
	.NOTES
        This will Install additional Modules for a Workflow_Manager.
    #>
    [CmdletBinding()]
    [OutputType([Boolean])]
    param(
        [Parameter(Mandatory=$true)][string]$RequiredModuleSet
    )
    try
    {
        Write-Output "Checking for installation of required modules."
        $RequiredModuleList = $RequiredModuleSet.split(",")
        foreach ($RequiredModule in $RequiredModuleList){
            $localModuledataCount = (Get-Module -ListAvailable $RequiredModule | Measure-Object).count
            if($localModuledataCount -ge 1){
                Write-Output "Module: $RequiredModule is installed on this device."
            } else {
                Write-Output "Installing Required Module: $RequiredModule"
                Install-Module -Name $RequiredModule -Force
            }
        }
    }
    catch
    {
        $ErrorMessage = $_.Exception.Message
        $FailedItem = $_.Exception.ItemName		
        Throw "Invoke-InstallRequiredModuleSet: $ErrorMessage $FailedItem"
    }
}
    