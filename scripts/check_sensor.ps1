param([switch]$Simulate,[string]$OutJson="examples/sample_outputs/sensor_status.json")
function Write-Json($o,$p){$d=Split-Path $p; if(!(Test-Path $d)){New-Item -ItemType Directory -Force -Path $d|Out-Null}; $o|ConvertTo-Json -Depth 4|Out-File -Encoding utf8 -FilePath $p}
if($Simulate -or $env:OS -notlike "*Windows*"){
$obj=[pscustomobject]@{Hostname="demo-endpoint";DefenderHealthy=$true;RealTimeProtectionEnabled=$true;EngineVersion="1.1.24000.1";AVSignatureAgeHours=6;MdeSensorService="Running";LastCheck=(Get-Date).ToString("s");Notes="Simulated output"}
$obj|Format-Table -AutoSize; Write-Json $obj $OutJson; exit 0
}
try{$mp=Get-MpComputerStatus -ErrorAction Stop}catch{}
$sense=Get-Service -Name Sense -ErrorAction SilentlyContinue
$age=if($mp){[int]((New-TimeSpan -Start $mp.AntivirusSignatureLastUpdated -End (Get-Date)).TotalHours)}else{$null}
$obj=[pscustomobject]@{Hostname=$env:COMPUTERNAME;DefenderHealthy=[bool]($mp -and $mp.RealTimeProtectionEnabled);RealTimeProtectionEnabled=$mp.RealTimeProtectionEnabled;EngineVersion=$mp.AMEngineVersion;AVSignatureAgeHours=$age;MdeSensorService=($sense?.Status.ToString());LastCheck=(Get-Date).ToString("s");Notes=""}
$obj|Format-Table -AutoSize; Write-Json $obj $OutJson; if(-not $obj.DefenderHealthy){exit 2}else{exit 0}