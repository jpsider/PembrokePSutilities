$script:ModuleName = 'PembrokePSutilities'

Describe "Invoke-InstallRequiredModuleSet function for $moduleName" {
    function Write-Output{}
    function Get-Module{}
    function Import-Module{}
    function Install-Module{}
    It "Should not Throw an exception if the are installed." {
        Mock -CommandName 'Install-Module' -MockWith {
            $true
        }
        Mock -CommandName 'Import-Module' -MockWith {
            $true
        }
        Mock -CommandName 'Get-Module' -MockWith {
            $RawReturn4 = @(
                @{
                    path            = 'c:\someModulePath'
                    Name            = 'c:\PembrokePSwman'
                }               
            )
            $ReturnJson4 = $RawReturn4 | ConvertTo-Json
            $ReturnData4 = $ReturnJson4 | convertfrom-json
            return $ReturnData4
        }
        {Invoke-InstallRequiredModuleSet -RequiredModuleSet "Powerlumber,PembrokePSrest"} | Should -Not -Throw
        Assert-MockCalled -CommandName 'Install-Module' -Times 0 -Exactly
        Assert-MockCalled -CommandName 'Get-Module' -Times 2 -Exactly
    }
    It "Should not Throw an exception if the Modules are already installed." {
        Mock -CommandName 'Install-Module' -MockWith {
            $true
        }
        Mock -CommandName 'Import-Module' -MockWith {
            $true
        }
        Mock -CommandName 'Get-Module' -MockWith {}
        {Invoke-InstallRequiredModuleSet -RequiredModuleSet "Powerlumber,PembrokePSrest"} | Should -Not -Throw
        Assert-MockCalled -CommandName 'Install-Module' -Times 2 -Exactly
        Assert-MockCalled -CommandName 'Get-Module' -Times 4 -Exactly
    }
    It "Should Throw an exception if the Module install fails." {
        Mock -CommandName 'Install-Module' -MockWith {
            Throw "Could not install the Module."
        }
        Mock -CommandName 'Import-Module' -MockWith {}
        Mock -CommandName 'Get-Module' -MockWith {}
        {Invoke-InstallRequiredModuleSet -RequiredModuleSet "Powerlumber,PembrokePSrest"} | Should -Throw
        Assert-MockCalled -CommandName 'Install-Module' -Times 3 -Exactly
        Assert-MockCalled -CommandName 'Get-Module' -Times 5 -Exactly
    }
}