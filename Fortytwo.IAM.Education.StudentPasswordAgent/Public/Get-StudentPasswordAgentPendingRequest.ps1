function Get-StudentPasswordAgentPendingRequest {
    [CmdletBinding()]
    param ()

    Process {
        try {
            $_Result = Invoke-RestMethod -Uri "$($Script:APIRoot)studentpasswordrequests/pendingactivedirectoryagent" -Headers (Get-EntraIDAccessTokenHeader -Profile $Script:AccessTokenProfile)
            if($_Result.isSuccess) {
                if($_Result.data) {
                    return $_Result.data
                }
                else {
                    Write-Verbose "No pending student password agent requests found."
                }
            }
            else {
                throw "Failed to retrieve pending student password agent requests. Result: $($_Result | ConvertTo-Json -Depth 5)"
            }
        }
        catch {
            throw "Failed to connect to the Fortytwo Education student password service. Please check your access token profile and network connectivity."
        }
    }
}