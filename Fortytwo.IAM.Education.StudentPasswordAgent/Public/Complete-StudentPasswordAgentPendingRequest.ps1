function Complete-StudentPasswordAgentPendingRequest {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)]
        $Request
    )

    Process {
        if (!$Request.id) {
            throw "The Request object must contain a 'id' property. Please provide a Request object with an 'id' property."
        }

        if (!$Request.student.id) {
            throw "The Request object must contain an 'student/id' property. Please provide a Request object with a 'student/id' property."
        }

        if (!$Request.password -and !$Request.error) {
            throw "The Request object must contain a 'password' or 'error' property. Please provide a Request object with a 'password' or 'error' property."
        }

        try {
            $_Result = Invoke-RestMethod -Uri "$($Script:APIRoot)studentpasswordrequests/$($Request.id)" -Headers (Get-EntraIDAccessTokenHeader -Profile $Script:AccessTokenProfile) -Method Patch -Body ($Request | ConvertTo-Json -Depth 5) -ContentType "application/json"
            if ($_Result.isSuccess) {
                return $_Result.data
            }
            else {
                throw "Failed to complete student password agent request. Result: $($_Result | ConvertTo-Json -Depth 5)"
            }
        }
        catch {
            throw "Failed to connect to the Fortytwo Education student password service. Please check your access token profile and network connectivity."
        }
    }
}