$stunnel_root = "C:\Program Files (x86)\stunnel"
$core_config_path = "C:\Users\ContainerAdministrator\stunnel\stunnel.conf"

function LogNotice($info, $level="5") {
    $date = Get-Date -uformat "%Y.%m.%d %H:%M:%S"
    echo "$date LOG$level[]: $info"
}

LogNotice "Writing environment configuration..."
${env:STUNNEL_CONF} | Out-File -Append -Encoding ascii $core_config_path

LogNotice "Starting stunnel..."
copy $core_config_path $stunnel_root\config\stunnel.conf

& "$stunnel_Root\bin\stunnel.exe" -install
Set-Service stunnel -StartupType Automatic
Start-Service stunnel

if (-not (ps stunnel))
{
    LogNotice -Level "2" -Info "Unable to start stunnel"
    Exit 1
}

function LogExists() {
    return (Test-Path -Path stunnel.log -PathType Leaf)
}

# Wait for the log to appear
$retries = 10
while (($retries -gt 0) -and -not (LogExists))
{
    LogNotice -Level "6" -Info "Waiting for stunnel.log: $retries retries remaining..."
    $retries = $retries - 1
    sleep 5
}

if (-not (LogExists))
{
    LogNotice -Level "2" -Info "Unable to find stunnel.log; perhaps the configuration is invalid?"
    Exit 1
}

while ($true)
{
    Get-Content -Tail 10 -Wait stunnel.log
    # Wait 1s before reconnecting to the log
    sleep 1
}
