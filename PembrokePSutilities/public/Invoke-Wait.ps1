function Invoke-Wait
{
    <#
	.DESCRIPTION
		This function will pause for the specified amount of time.
    .PARAMETER Seconds
        A valid integer is optional. Default is 10 seconds
	.EXAMPLE
        Invoke-Wait -Seconds 15
	.NOTES
        It's pretty simple.
    #>
    [CmdletBinding()]
    [OutputType([boolean])]
    param(
        [Int]$Seconds = 10
    )
    try
    {
        Write-output "Waiting $Seconds, Seconds"
        start-sleep -s $Seconds
    }
    catch
    {
        $ErrorMessage = $_.Exception.Message
        $FailedItem = $_.Exception.ItemName		
        Throw "Invoke-Wait: $ErrorMessage $FailedItem"
    }
}