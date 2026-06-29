function Invoke-StudentPasswordAgent {
    [CmdletBinding()]

    param (
        [Parameter(Mandatory = $false)]
        [string]$IdentityAttribute = "msDs-cloudExtensionAttribute20",

        [Parameter(Mandatory = $false)]
        [ValidateRange(1, 10)]
        [int]$PollingInterval = 3
    )

    process {
        if (!$Script:AccessTokenProfile) {
            throw "The AccessTokenProfile variable is not set. Please call Connect-StudentPasswordAgent before invoking the student password agent."
        }

        $cts = [System.Threading.CancellationTokenSource]::new()
        $token = $cts.Token

        while (!$token.IsCancellationRequested) {
            $Requests = Get-StudentPasswordAgentPendingRequest
            if ($Requests) {
                Write-Host "Got requests to process!"
                foreach ($Request in $Requests) {
                    Write-Host "Request ID: $($Request.id), Student ID: $($Request.student.id)"

                    $Script:ADUser = $null

                    # Locate AD user account by the specified identity attribute
                    if ($IdentityAttribute -ne $null) {
                        $Script:ADUser = Get-ADUser -LDAPFilter "($IdentityAttribute=$($Request.student.id))"
                        if ($Script:ADUser) {
                            Write-Verbose "Found AD user account by $($IdentityAttribute): $($Script:ADUser.SamAccountName)"
                        }
                    }

                    # Locate AD user account by distinguishedName if not found by identity attribute
                    if (!$Script:ADUser -and $Request.student.entraOnPremisesDistinguishedName) {
                        $Script:ADUser = Get-ADUser -LDAPFilter "(distinguishedName=$($Request.student.entraOnPremisesDistinguishedName))"
                        if ($Script:ADUser) {
                            Write-Verbose "Found AD user account by distinguishedName: $($Script:ADUser.SamAccountName)"
                        }
                    }

                    # Locate AD user account by userPrincipalName if not found by identity attribute or distinguishedName
                    if (!$Script:ADUser -and $Request.student.userPrincipalName) {
                        $Script:ADUser = Get-ADUser -LDAPFilter "(userPrincipalName=$($Request.student.userPrincipalName))"
                        if ($Script:ADUser) {
                            Write-Verbose "Found AD user account by userPrincipalName: $($Script:ADUser.SamAccountName)"
                        }
                    }

                    # If the AD user account is still not found, log a warning and complete the request with an error
                    if (!$Script:ADUser) {
                        Write-Warning "Could not find AD user account for student ID: $($Request.student.id). Please check the identity attribute and student information."
                        $Request.error = "Unable to locate user account"
                        $Request | Complete-StudentPasswordAgentPendingRequest
                        continue
                    }

                    # If the AD user account is found, but disabled, log a warning and complete the request with an error
                    if ($Script:ADUser.Enabled -eq $false) {
                        Write-Warning "The AD user account for student ID: $($Request.student.id) is disabled. Please check the account status."
                        $Request.error = "User account is disabled"
                        $Request | Complete-StudentPasswordAgentPendingRequest
                        continue
                    }

                    try {
                        $Password = $Request.generatedPasswords[0]
                        Set-ADAccountPassword -Identity $Script:ADUser.DistinguishedName -NewPassword (ConvertTo-SecureString -String $Password -AsPlainText -Force) -Reset
                        $Request.password = $Password
                    }
                    catch { }

                    if (!$Request.password) {
                        try {
                            $Password = $Request.generatedPasswords[1]
                            Set-ADAccountPassword -Identity $Script:ADUser.DistinguishedName -NewPassword (ConvertTo-SecureString -String $Password -AsPlainText -Force) -Reset
                            $Request.password = $Password
                        }
                        catch { }
                    }

                    if (!$Request.password) {
                        try {
                            $Password = $Request.generatedPasswords[2]
                            Set-ADAccountPassword -Identity $Script:ADUser.DistinguishedName -NewPassword (ConvertTo-SecureString -String $Password -AsPlainText -Force) -Reset
                            $Request.password = $Password
                        }
                        catch {
                            $Request.error = $_.ToString()
                        }
                    }

                    if (!$Request.password -and !$Request.error) {
                        $Request.error = "Failed to set password for user account"
                    }

                    $Request | Complete-StudentPasswordAgentPendingRequest
                }
            }
            else {
                Write-Host "No pending requests found, checking again in $PollingInterval seconds..."
                Start-Sleep -Seconds $PollingInterval
            }
        }
    }
}