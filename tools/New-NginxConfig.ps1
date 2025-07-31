param (
    [string]$type,
    [string]$port
)

$domainPrefix = (((Split-Path -Leaf (Get-Location)) -replace '-by-vincent', '') -replace '-', '.')
$fqdn = $domainPrefix + '.by.vincent.mahn.ke'

if (-not (Get-Module -ListAvailable -Name EPS)) {
    Install-Module -Name EPS -Force -Scope CurrentUser
}
Import-Module EPS

$template = Get-Content -Raw -Path "./$type.eps"

$outFile = "output/$fqdn.conf"
$nginxConfig = Invoke-EpsTemplate -Template $template -Binding @{
    fqdn         = $fqdn
    domainPrefix = $domainPrefix
    port         = $port
    CERT_HOME    = $env:CERT_HOME -replace '\\', '/'
}
if (Test-Path "output") {
    Remove-Item "output" -Recurse -Force
}
$outDir = Split-Path $outFile -Parent
New-Item -ItemType Directory -Path $outDir -Force | Out-Null
Set-Content -Path $outFile -Value $nginxConfig

Write-Host "NGINX config generated: $outFile"