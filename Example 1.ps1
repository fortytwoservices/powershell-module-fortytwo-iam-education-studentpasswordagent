#region Initialization and authentication
Add-EntraIDClientSecretAccessTokenProfile -ClientId "c0c82166-618a-47e2-8df2-da9d3cafb3cf" -Scope "https://dev-api.byfortytwo.com/.default" -TenantId "bb73082a-b74c-4d39-aec0-41c77d6f4850"

Import-Module "./Fortytwo.IAM.Education.StudentPasswordAgent" -Force
Connect-StudentPasswordAgent -AccessTokenProfile "default"
#endregion

