<#
.SYNOPSIS
    Establishes connection to the Fortytwo Education student password service.

.DESCRIPTION
    Establishes connection to the Fortytwo Education student password service.

.PARAMETER AccessTokenProfile
    The name of the Entra ID access token profile to use for authentication.
    Defaults to "default".

.PARAMETER Development
    Indicates whether to use the development API endpoint. If specified, the ApiRoot parameter can be used to specify a custom API root URL.

.PARAMETER ApiRoot
    (Development parameter set) A custom API root URL for local development.
    Must end with '/education/beta/'.

.EXAMPLE
    Connect-StudentPasswordAgent -AccessTokenProfile "Profile1"
#>
function Connect-StudentPasswordAgent {
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    param (
        [Parameter(Mandatory = $false)]
        $AccessTokenProfile = "default",

        [Parameter(Mandatory = $false, ParameterSetName = 'Development')]
        [Switch] $Development,
        
        [Parameter(Mandatory = $false, ParameterSetName = 'Development')]
        [ValidateScript({ $_ -match '^https?://.+$' -and $_ -like "*/education/beta/" }, ErrorMessage = "ApiRoot must start on http(s):// and end on /education/beta/")]
        [string] $ApiRoot
    )

    if ($Development.IsPresent) {
        $Script:APIRoot = [String]::IsNullOrEmpty($ApiRoot) ? "https://dev-api.byfortytwo.com/education/beta/" : $ApiRoot
    }
    else {
        $Script:APIRoot = "https://api.fortytwo.io/education/beta/"
    }

    if (!(Get-EntraIDAccessTokenProfile -Profile $AccessTokenProfile)) {
        throw "Access token profile '$AccessTokenProfile' not found. Please create it using New-EntraIDAccessTokenProfile."
    }

    $Script:AccessTokenProfile = $AccessTokenProfile

    # Test connection by calling the generate password endpoint
    try {
        Invoke-RestMethod -Uri "$($Script:APIRoot)passwords/" -Headers (Get-EntraIDAccessTokenHeader -Profile $Script:AccessTokenProfile) | out-null
    }
    catch {
        throw "Failed to connect to the Fortytwo Education student password service. Please check your access token profile and network connectivity."
    }
}