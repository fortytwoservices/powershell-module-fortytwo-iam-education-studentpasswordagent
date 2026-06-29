#region Initialization and authentication
Add-EntraIDClientSecretAccessTokenProfile -ClientId "c0c82166-618a-47e2-8df2-da9d3cafb3cf" -Scope "https://dev-api.byfortytwo.com/.default" -TenantId "bb73082a-b74c-4d39-aec0-41c77d6f4850"

Import-Module "./Fortytwo.IAM.Education.StudentPasswordAgent" -Force
Connect-StudentPasswordAgent -AccessTokenProfile "default" -ApiRoot "https://localhost:7400/education/beta/" -Development
#endregion

#region Example processing requests
while($true) {
    $Requests = Get-StudentPasswordAgentPendingRequest
    if($Requests) {
        Write-Host "Processing requests"
        foreach($Request in $Requests) {
            Write-Host "Request ID: $($Request.id), Student ID: $($Request.student.id)"

            # Caos monkey :)
            if((Get-Random -Maximum 9 -Minimum 1) -eq 7) {
                $Request.error = "The password does not meet the complexity requirements."
            } else {
                $Request.password = $Request.generatedPasswords | Get-Random -Count 1
            }
            
            $Request | Complete-StudentPasswordAgentPendingRequest
        }
    }
    else {
        Write-Host "No pending requests found, checking again in 3 seconds..."
        Start-Sleep -Seconds 3
    }
}
#endregion
