BeforeAll {
    $Script:Module = Import-Module "$($PSScriptRoot)/." -Force -PassThru
    
    $Script:ATP = "connector-$Script:ConnectorId"
    Add-EntraIDExternalAccessTokenProfile -Name $Script:ATP -AccessToken (New-DummyJWT)

    # Mock /configuration api call
    Mock -ModuleName $Script:Module.Name -CommandName Invoke-RestMethod -ParameterFilter { $Uri -like "https://api.fortytwo.io/education/beta/studentpasswordrequests/pendingactivedirectoryagent" } -MockWith {
        @{
            isSuccess = $true
            data      = @(
                @{
                    id                 = "0bf77396-f832-418c-b6f2-1001a6c19cc5"
                    student            = @{
                        id = "5c077326-02c8-4bd0-80cd-972aa215316d"
                    }
                    generatedPasswords = @("Password1!", "Password2!", "Password3!")
                }
            )
        }
    }

    # Mock /configuration api call
    Mock -ModuleName $Script:Module.Name -CommandName Invoke-RestMethod -ParameterFilter { $Uri -like "https://api.fortytwo.io/education/beta/passwords/" } -MockWith {
        @{
            isSuccess = $true
            data      = @(
                (New-Guid).ToString(),
                (New-Guid).ToString(),
                (New-Guid).ToString(),
                (New-Guid).ToString(),
                (New-Guid).ToString()
            )
        }
    }

    # Mock /data api call
    Mock -ModuleName $Script:Module.Name -CommandName Invoke-RestMethod -ParameterFilter { $Uri -like "https://api.fortytwo.io/education/beta/studentpasswordrequests/0bf77396-f832-418c-b6f2-1001a6c19cc5" -and $Method -eq "PATCH" } -MockWith {
        @{
            isSuccess = $true
            data      = @{
                id      = "0bf77396-f832-418c-b6f2-1001a6c19cc5"
                student = @{
                    id = "5c077326-02c8-4bd0-80cd-972aa215316d"
                }
            }
        }
    }
}

Describe "Happypath1" -Tag "happypath" {
    It "Should succesfully connect" {
        {
            Connect-StudentPasswordAgent -AccessTokenProfile $Script:ATP
        } | Should -Not -Throw
    }

    It "Is possible to retrieve and complete pending request" {
        $Requests = Get-StudentPasswordAgentPendingRequest

        $Requests | Should -HaveCount 1
        $Request = $Requests | select-Object -First 1
        $Request.id | Should -BeExactly "0bf77396-f832-418c-b6f2-1001a6c19cc5"
        $Request.student.id | Should -BeExactly "5c077326-02c8-4bd0-80cd-972aa215316d"

        $Request.password = $Request.generatedPasswords[0]
        {
            $Request | Complete-StudentPasswordAgentPendingRequest
        } | Should -Not -Throw

        Assert-MockCalled -ModuleName $Script:Module.Name -CommandName Invoke-RestMethod -ParameterFilter { $Uri -like "https://api.fortytwo.io/education/beta/studentpasswordrequests/0bf77396-f832-418c-b6f2-1001a6c19cc5" -and $Method -eq "PATCH" } -Times 1
    }
}