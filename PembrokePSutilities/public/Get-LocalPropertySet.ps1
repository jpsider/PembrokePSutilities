function Get-LocalPropertySet {
    <#
	.DESCRIPTION
		This function will gather Key value pairs from a properties file.
    .PARAMETER PropertyFilePath
        A path is Required.
	.EXAMPLE
        Get-LocalPropertySet -PropertyFilePath c:\pps\qman\pembrokeps.properties
	.NOTES
        This file is generated during the deployment or Registration of tha Pembroke PS component.
    #>
    [CmdletBinding()]
    [Diagnostics.CodeAnalysis.SuppressMessageAttribute("PSUseDeclaredVarsMoreThanAssignments", "")]
    [OutputType([System.Object[]])]
    param(
        [Parameter(Mandatory=$true)][string]$PropertyFilePath
    )
    if (Test-Path -Path $PropertyFilePath) {
        try
        {
            $PpsPropertiesHash = ConvertFrom-StringData (Get-Content $PropertyFilePath -raw)
            $PpsProperties = @()
            $PpsPropertiesHash | ForEach-Object {
                $result = New-Object psobject;
                foreach ($key in $_.keys) {
                    $result | Add-Member -MemberType NoteProperty -Name $key -Value $_[$key]
                 }
                 $PpsProperties += $result;
             }
        }
        catch
        {
            $ErrorMessage = $_.Exception.Message
            $FailedItem = $_.Exception.ItemName		
            Throw "Get-LocalPropertySet: $ErrorMessage $FailedItem"
        }
        $PpsProperties
    } else {
        Throw "Property File path: $PropertyFilePath does not exist."
    }
    
}