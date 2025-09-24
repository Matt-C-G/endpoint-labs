# Generate fleet snapshot and ASR time-series data
$now = Get-Date
$hosts = 1..10 | ForEach-Object {
  [pscustomobject]@{
    Hostname = "lab-endpoint-$($_)"
    DefenderHealthy = $true
    AVSignatureAgeHours = Get-Random -Minimum 1 -Maximum 24
    MdeSensorService = "Running"
    BitLocker = "On"
    LastCheck = $now.ToString("s")
  }
}
$dir="examples/sample_outputs"; if(!(Test-Path $dir)){New-Item -ItemType Directory $dir|Out-Null}
$hosts | ConvertTo-Json -Depth 4 | Out-File -Encoding utf8 "$dir/fleet_snapshot.json"

# ASR hits time-series (24h) to talk trends (audit→enforce)
$ts = 0..23 | ForEach-Object {
  [pscustomobject]@{
    Hour = (Get-Date).AddHours(-$_).ToString("yyyy-MM-dd HH:00")
    AuditHits = Get-Random -Minimum 0 -Maximum 12
    EnforceHits = Get-Random -Minimum 0 -Maximum 2
  }
}
$ts | ConvertTo-Json | Out-File -Encoding utf8 "$dir/asr_hits_timeseries.json"

Write-Host "Generated fleet_snapshot.json and asr_hits_timeseries.json"
