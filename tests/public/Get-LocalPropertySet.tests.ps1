$script:ModuleName = 'PembrokePSutilities'

$here = (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace 'tests', "$script:ModuleName"
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "Get-LocalPropertySet function for $moduleName" {
    function Write-LogLevel{}
    It "Should not be null" {
        Mock -CommandName 'Test-Path' -MockWith {
            $true
        }
        Mock -CommandName 'get-content' -MockWith {
            $filedata = @'
system.RestServer=localhost
component.Id=1
component.Type=Qman
component.RestPort=8000
'@ 
            return $filedata
        }
        Mock -CommandName 'Write-LogLevel' -MockWith {}
        Get-LocalPropertySet -PropertyFilePath 'c:\fakepath' | Should not be $null
        Assert-MockCalled -CommandName 'Test-Path' -Times 1 -Exactly
        Assert-MockCalled -CommandName 'get-content' -Times 1 -Exactly
        Assert-MockCalled -CommandName 'Write-LogLevel' -Times 1 -Exactly
    }
    It "Should Throw if the Properties are empty." {
        Mock -CommandName 'Test-Path' -MockWith {
            $true
        }
        Mock -CommandName 'Write-LogLevel' -MockWith {}
        Mock -CommandName 'Get-Content' -MockWith {}
        {Get-LocalPropertySet -PropertyFilePath 'c:\fakepath'} | Should -Throw
        Assert-MockCalled -CommandName 'Test-Path' -Times 2 -Exactly
        Assert-MockCalled -CommandName 'Get-Content' -Times 2 -Exactly
        Assert-MockCalled -CommandName 'Write-LogLevel' -Times 2 -Exactly
    }
    It "Should Throw if the Properties are empty." {
        Mock -CommandName 'Test-Path' -MockWith {
            $true
        }
        Mock -CommandName 'get-content' -MockWith {}
        Mock -CommandName 'Write-LogLevel' -MockWith {}
        {Get-LocalPropertySet -PropertyFilePath 'c:\fakepath'} | Should -Throw
        Assert-MockCalled -CommandName 'Test-Path' -Times 3 -Exactly
        Assert-MockCalled -CommandName 'get-content' -Times 3 -Exactly
        Assert-MockCalled -CommandName 'Write-LogLevel' -Times 3 -Exactly
    }
    It "Should Throw if the file does not exist." {
        Mock -CommandName 'Test-Path' -MockWith {}
        Mock -CommandName 'Write-LogLevel' -MockWith {}
        {Get-LocalPropertySet -PropertyFilePath 'c:\fakepath'} | Should -Throw
        Assert-MockCalled -CommandName 'Test-Path' -Times 4 -Exactly
        Assert-MockCalled -CommandName 'Write-LogLevel' -Times 3 -Exactly
    }
}