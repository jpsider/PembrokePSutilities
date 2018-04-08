function Get-PpsProcessStatus {
    <#
	.DESCRIPTION
		This function will gather Key value pairs from a properties file.
    .PARAMETER ProcessName
        A path is Required.
	.EXAMPLE
        Get-PpsProcessStatus -ProcessName WmanKicker
	.NOTES
        This file will return true or false
    #>
    [CmdletBinding()]
    [OutputType([Boolean])]
    param(
        [Parameter(Mandatory=$true)][string]$ProcessName
    )
    try 
    {
        $ReturnData = Get-Process | Where-Object {($_.Name -eq "powershell") -and ($_.MainWindowTitle -like "*$ProcessName*")}
        $ReturnDataCount = ($ReturnData | Measure-Object).count
        If($ReturnDataCount -eq 1) {
            return $true
        } else {
            return $false
        }
    }
    catch
    {
        $ErrorMessage = $_.Exception.Message
        $FailedItem = $_.Exception.ItemName		
        Throw "Get-PpsProcessStatus: $ErrorMessage $FailedItem"
    }
}
    