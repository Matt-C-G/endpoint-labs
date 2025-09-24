param(
    [switch]$Simulate,
    [string]$OutJson = "examples/sample_outputs/sensor_status.json"
)
function Write-Json { param($Obj,$Path)
  $dir = Split-Path -Parent $Path
  if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
  $Obj | ConvertTo-Json -Depth 4 | Out-File -Encoding utf8 -FilePath $Path
}
if ($Simulate -or $env:OS -notlike "*Windows*") {
  $obj = [pscustomobject]@{
    Hostname="demo-endpoint"; DefenderHealthy=$true; RealTimeProtectionEnabled=$true
    EngineVersion="1.1.24000.1"; AVSignatureAgeHours=6; MdeSensorService="Running"
    LastCheck=(Get-Date).ToString("s"); Notes="Simulated output for portfolio demo"
  }
  $obj | Format-Table -AutoSize
  Write-Json $obj $OutJson; return
}
$mp = $null; try { $mp = Get-MpComputerStatus -ErrorAction Stop } catch { }
$sense = Get-Service -Name "Sense" -ErrorAction SilentlyContinue
$engineVersion = $mp.AMEngineVersion
$avAge = if ($mp -and $mp.AntivirusSignatureLastUpdated) {
  [int]((New-TimeSpan -Start $mp.AntivirusSignatureLastUpdated -End (Get-Date)).TotalHours)
} else { $null }
$obj = [pscustomobject]@{
  Hostname=$env:COMPUTERNAME
  DefenderHealthy=[bool]($mp -and $mp.RealTimeProtectionEnabled)
  RealTimeProtectionEnabled=$mp.RealTimeProtectionEnabled
  EngineVersion=$engineVersion
  AVSignatureAgeHours=$avAge
  MdeSensorService=(if ($sense) { $sense.Status.ToString() } else { "NotInstalled" })
  LastCheck=(Get-Date).ToString("s")
  Notes=(if ($sense -and $sense.Status -ne "Running") { "MDE sensor not running" } else { "" })
}
$obj | Format-Table -AutoSize
Write-Json $obj $OutJson
