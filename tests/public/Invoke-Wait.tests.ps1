$script:ModuleName = 'PembrokePSutilities'

$here = (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace 'tests', "$script:ModuleName"
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "Invoke-Wait function for $moduleName" {
    function Write-Output{}
    It "Should Return null if no errors were encountered." {
        Mock -CommandName 'start-sleep' -MockWith {}
        Mock -CommandName 'Write-Output' -MockWith {}
        Invoke-Wait -Seconds 3 | Should be $null
        Assert-MockCalled -CommandName 'start-sleep' -Times 1 -Exactly
        Assert-MockCalled -CommandName 'Write-Output' -Times 1 -Exactly
    }
    It "Should not Throw if the wait succeeds." {
        Mock -CommandName 'start-sleep' -MockWith {}
        Mock -CommandName 'Write-Output' -MockWith {}
        {Invoke-Wait -Seconds 3} | Should -Not -Throw
        Assert-MockCalled -CommandName 'start-sleep' -Times 2 -Exactly
        Assert-MockCalled -CommandName 'Write-Output' -Times 2 -Exactly
    }
    It "Should Return Throw if an error was encountered." {
        Mock -CommandName 'start-sleep' -MockWith {
            Throw 'Unable to perform the Wait.'
        }
        Mock -CommandName 'Write-Output' -MockWith {}
        {Invoke-Wait -Seconds 3} | Should -Throw
        Assert-MockCalled -CommandName 'start-sleep' -Times 3 -Exactly
        Assert-MockCalled -CommandName 'Write-Output' -Times 3 -Exactly
    }
}