function Get-LocalPropertySet {
    <#
	.DESCRIPTION
		This function will gather Key value pairs from a properties file.
    .PARAMETER PropertyFilePath
        A path is optional.
	.EXAMPLE
        Get-LocalPropertySet -PropertyFilePath c:\pps\qman\pembrokeps.properties
	.NOTES
        This file is generated during the deployment or Registration of tha Pembroke PS component.
    #>
    [CmdletBinding()]
    [OutputType([hashtable])]
    param(
        [string]$PropertyFilePath = 10
    )
    if (Test-Path -Path $PropertyFilePath) {
        try
        {
            $PpsProperties = ConvertFrom-StringData (Get-Content $PropertyFilePath -raw)
        }
        catch
        {
            $ErrorMessage = $_.Exception.Message
            $FailedItem = $_.Exception.ItemName		
            Write-Error "Error: $ErrorMessage $FailedItem"
            Throw $_
        }
        $PpsProperties
    } else {
        Throw "Property File path: $PropertyFilePath does not exist."
    }
    
}