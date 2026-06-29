BeforeAll {
    $Script:Module = Import-Module "$($PSScriptRoot)/.." -Force -PassThru
    $Script:ATP = "connector-$(New-Guid)"
    Add-EntraIDExternalAccessTokenProfile -Name $Script:ATP -AccessToken (New-DummyJWT)
}

Describe "Connect-StudentPasswordAgent" {
    It "Should throw when there is no access token profile" {
        {
            Connect-StudentPasswordAgent -AccessTokenProfile (New-Guid).ToString()
        } | Should -Throw
    }

    It "Should call the get connector endpoint when an access token is available" {
        Mock -ModuleName $Script:Module.Name -CommandName Invoke-RestMethod -ParameterFilter { $Uri -like "http*/passwords/" } -MockWith {
            @{
                IsSuccess = $true
                Data      = @(
                    (New-Guid).ToString()
                    (New-Guid).ToString()
                    (New-Guid).ToString()
                )
            }
        }
        
        {
            Connect-StudentPasswordAgent -AccessTokenProfile $Script:ATP
        } | Should -Not -Throw
    }
}