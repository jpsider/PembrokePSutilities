$script:ModuleName = 'PembrokePSutilities'

Describe "Get-LocalPropertySet function for $moduleName" {
    It "Should not be null" {
        Mock -CommandName 'Test-Path' -MockWith {
            $true
        }
        Mock -CommandName 'get-content' -MockWith {
            $filedata = @'
app.name=Test App
app.version=1.2
'@ 
            return $filedata
        }
        Get-LocalPropertySet -PropertyFilePath 'c:\fakepath' | Should not be $null
        Assert-MockCalled -CommandName 'Test-Path' -Times 1 -Exactly
        Assert-MockCalled -CommandName 'get-content' -Times 1 -Exactly
    }
    It "Should Throw if the Properties are empty." {
        Mock -CommandName 'Test-Path' -MockWith {
            $true
        }
        Mock -CommandName 'Write-Error' -MockWith {}
        Mock -CommandName 'Get-Content' -MockWith {}
        {Get-LocalPropertySet -PropertyFilePath 'c:\fakepath'} | Should -Throw
        Assert-MockCalled -CommandName 'Test-Path' -Times 2 -Exactly
        Assert-MockCalled -CommandName 'Get-Content' -Times 2 -Exactly
        Assert-MockCalled -CommandName 'Write-Error' -Times 1 -Exactly 
    }
    It "Should Throw if the Properties are empty." {
        Mock -CommandName 'Test-Path' -MockWith {
            $true
        }
        Mock -CommandName 'get-content' -MockWith {}
        {Get-LocalPropertySet -PropertyFilePath 'c:\fakepath'} | Should -Throw
        Assert-MockCalled -CommandName 'Test-Path' -Times 3 -Exactly
        Assert-MockCalled -CommandName 'get-content' -Times 3 -Exactly
    }
    It "Should Throw if the file does not exist." {
        Mock -CommandName 'Test-Path' -MockWith {}
        {Get-LocalPropertySet -PropertyFilePath 'c:\fakepath'} | Should -Throw
        Assert-MockCalled -CommandName 'Test-Path' -Times 4 -Exactly
    }
}