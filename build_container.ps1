param(
    [string]$ImageNameRoot="",

    [Parameter(Mandatory)]
    [string]$WindowsVersion,

    [Parameter(Mandatory)]
    [string]$StunnelVersion,

    [Parameter(Mandatory)]
    [string]$StunnelSha256,

    [switch]$Force=$false
)
$stunnelimage="${ImageNameRoot}stunnel"
$stunneltag="${StunnelVersion}-windows-${WindowsVersion}"

docker manifest inspect "${stunnelimage}:${stunneltag}" | Out-Null
if (-not $Force -and $?) {
    Write-Output "Skipping ${stunnelimage}:${stunneltag}, already exists."
} else {
  docker build . `
    --build-arg BUILD_IMAGE="mcr.microsoft.com/windows/servercore:${WindowsVersion}" `
    --build-arg STUNNEL_VERSION=$StunnelVersion `
    --build-arg STUNNEL_SHA256=$StunnelSha256 `
    --tag "${stunnelimage}:${stunneltag}"

  docker push "${stunnelimage}:${stunneltag}"
}
