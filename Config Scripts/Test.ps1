#requires -Modules MSAL.PS
#region Auth
$authParams = @{
    clientId    = 'd1ddf0e4-d672-4dae-b554-9d5bdfd93547' #well known intune / graph application
    tenantId    = 'alarpsolutions.com.au' #replace with your tenantId or FQDN
    Interactive = $true
    DeviceCode  = $false #set TRUE if you need to authenticate from another device.
}
$auth = Get-MsalToken @authParams
#endregion Auth

$requestBody = @{
    Method         = 'Get'
    Uri            = 'https://graph.microsoft.com/v1.0/users'
    Authentication = 'OAuth'
    Token          = ($auth.AccessToken | ConvertTo-SecureString -AsPlainText -Force)
    ContentType    = 'Application/Json'
}
$response = Invoke-RestMethod @requestBody
$response


$welcomeScreen = "IF9fICBfXyAgICBfXyAgX19fX19fICBfX19fX18gIF9fX19fXwovXCBcL1wgIi0uLyAgXC9cICBfXyBcL1wgIF9fX1wvXCAgX19fXApcIFwgXCBcIFwtLi9cIFwgXCAgX18gXCBcIFxfXyBcIFwgIF9fXAogXCBcX1wgXF9cIFwgXF9cIFxfXCBcX1wgXF9fX19fXCBcX19fX19cCiAgXC9fL1wvXy8gIFwvXy9cL18vXC9fL1wvX19fX18vXC9fX19fXy8KIF9fX19fICAgX19fX19fICBfX19fX18gIF9fICAgICAgX19fX19fICBfXyAgX18KL1wgIF9fLS4vXCAgX19fXC9cICA9PSBcL1wgXCAgICAvXCAgX18gXC9cIFxfXCBcClwgXCBcL1wgXCBcICBfX1xcIFwgIF8tL1wgXCBcX19fXCBcIFwvXCBcIFxfX19fIFwKIFwgXF9fX18tXCBcX19fX19cIFxfXCAgIFwgXF9fX19fXCBcX19fX19cL1xfX19fX1wKICBcL19fX18vIFwvX19fX18vXC9fLyAgICBcL19fX19fL1wvX19fX18vXC9fX19fXy8KICAgICAgIF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCiAgICAgICBXaW5kb3dzIDEwIERldmljZSBQcm92aXNpb25pbmcgVG9vbAogICAgICAgKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKioqKio="
Write-Host $([system.text.encoding]::UTF8.GetString([system.convert]::FromBase64String($welcomeScreen)))
