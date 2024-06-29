

#Connect to GRAPH API
$tokenBody = @{
    Grant_Type    = "client_credentials"
    Scope         = "https://graph.microsoft.com/.default"
    Client_Id     = $clientId
    Client_Secret = $clientSecret
}
$tokenResponse = Invoke-RestMethod -Uri "https://login.microsoftonline.com/$tenantID/oauth2/v2.0/token" -Method POST -Body $tokenBody
$headers = @{
    "Authorization" = "Bearer $($tokenResponse.access_token)"
    "Content-type"  = "application/json"
}

$credential = Import-CliXml -Path 'C:\dev\mycred.xml'
Connect-MsolService -Credential $credential
connect-azuread -credential $credential
Connect-MsGraph -Scopes "Directory.AccessAsUser.All Directory.Read.All Directory.ReadWrite.All"

$serviceprincipal=Get-AzureADServicePrincipal -top 1250


