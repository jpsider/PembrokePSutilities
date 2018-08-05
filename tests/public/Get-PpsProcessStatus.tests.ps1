$script:ModuleName = 'PembrokePSutilities'

$here = (Split-Path -Parent $MyInvocation.MyCommand.Path) -replace 'tests', "$script:ModuleName"
$sut = (Split-Path -Leaf $MyInvocation.MyCommand.Path) -replace '\.Tests\.', '.'
. "$here\$sut"

Describe "Get-PpsProcessStatus function for $moduleName" {
    function Get-Process{}
    It "Should not Throw if the process exists." {
        Mock -CommandName 'Get-Process' -MockWith {
            $RawReturn4 = @(
                @{
                    MainWindowTitle = 'Workflow_Manager'
                    Name            = 'powershell'
                }               
            )
            $ReturnJson4 = $RawReturn4 | ConvertTo-Json
            $ReturnData4 = $ReturnJson4 | convertfrom-json
            return $ReturnData4
        }
        {Get-PpsProcessStatus -ProcessName Workflow_Manager} | Should -Not -Throw
        Assert-MockCalled -CommandName 'Get-Process' -Times 1 -Exactly
    }
    It "Should be true if the process exists." {
        Mock -CommandName 'Get-Process' -MockWith {
            $RawReturn4 = @(
                @{
                    MainWindowTitle = 'Workflow_Manager'
                    Name            = 'powershell'
                }               
            )
            $ReturnJson4 = $RawReturn4 | ConvertTo-Json
            $ReturnData4 = $ReturnJson4 | convertfrom-json
            return $ReturnData4
        }
        Get-PpsProcessStatus -ProcessName Workflow_Manager | Should be $true
        Assert-MockCalled -CommandName 'Get-Process' -Times 2 -Exactly
    }
    It "Should be false if the process does not exist." {
        Mock -CommandName 'Get-Process' -MockWith {
            $RawReturn4 = @(
                @{
                    MainWindowTitle = 'Bad_Process_Name'
                    Name            = 'powershell'
                }               
            )
            $ReturnJson4 = $RawReturn4 | ConvertTo-Json
            $ReturnData4 = $ReturnJson4 | convertfrom-json
            return $ReturnData4
        }
        Get-PpsProcessStatus -ProcessName Workflow_Manager | Should be $false
        Assert-MockCalled -CommandName 'Get-Process' -Times 3 -Exactly
    }
    It "Should Throw if the get-process command fails." {
        Mock -CommandName 'Get-Process' -MockWith {
            throw "Get-Process failed."
        }
        {Get-PpsProcessStatus -ProcessName Workflow_Manager} | Should -Throw
        Assert-MockCalled -CommandName 'Get-Process' -Times 4 -Exactly
    }
}