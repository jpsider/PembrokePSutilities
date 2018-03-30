$script:ModuleName = 'PembrokePSutilities'

Describe "Invoke-Wait function for $moduleName" {
    function Write-LogLevel{}
    It "Should Return null if no errors were encountered." {
        Mock -CommandName 'start-sleep' -MockWith {}
        Mock -CommandName 'Write-LogLevel' -MockWith {}
        Invoke-Wait -Seconds 3 | Should be $null
        Assert-MockCalled -CommandName 'start-sleep' -Times 1 -Exactly
        Assert-MockCalled -CommandName 'Write-LogLevel' -Times 1 -Exactly
    }
    It "Should not Throw if the wait succeeds." {
        Mock -CommandName 'start-sleep' -MockWith {}
        Mock -CommandName 'Write-LogLevel' -MockWith {}
        {Invoke-Wait -Seconds 3} | Should -Not -Throw
        Assert-MockCalled -CommandName 'start-sleep' -Times 2 -Exactly
        Assert-MockCalled -CommandName 'Write-LogLevel' -Times 2 -Exactly
    }
    It "Should Return Throw if an error was encountered." {
        Mock -CommandName 'start-sleep' -MockWith {
            Throw 'Unable to perform the Wait.'
        }
        Mock -CommandName 'Write-LogLevel' -MockWith {}
        {Invoke-Wait -Seconds 3} | Should -Throw
        Assert-MockCalled -CommandName 'start-sleep' -Times 3 -Exactly
        Assert-MockCalled -CommandName 'Write-LogLevel' -Times 3 -Exactly
    }
}