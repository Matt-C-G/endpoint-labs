param([switch]$Simulate,[string]$OutJson="examples/sample_outputs/bitlocker_status.json")
function Write-Json($o,$p){$d=Split-Path $p; if(!(Test-Path $d)){New-Item -ItemType Directory -Force -Path $d|Out-Null}; $o|ConvertTo-Json -Depth 4|Out-File -Encoding utf8 -FilePath $p}
if($Simulate -or $env:OS -notlike "*Windows*"){
$o=[pscustomobject]@{ComputerName="demo-endpoint";Volume="C:";ProtectionStatus="On";EncryptionPercent=100;KeyProtector="TPM";RecoveryKeyEscrow="Present";LastCheck=(Get-Date).ToString("s");Notes="Simulated output"}
$o|Format-Table -AutoSize; Write-Json $o $OutJson; exit 0
}
$bl=Get-BitLockerVolume -MountPoint C: -ErrorAction SilentlyContinue
$prot= if($bl){ if($bl.ProtectionStatus -eq 1){"On"} elseif($bl.ProtectionStatus -eq 0){"Off"} else {$bl.ProtectionStatus} } else {"Unknown"}
$o=[pscustomobject]@{ComputerName=$env:COMPUTERNAME;Volume="C:";ProtectionStatus=$prot;EncryptionPercent=[int]$bl.EncryptionPercentage;KeyProtector=($bl.KeyProtector|%{$_.KeyProtectorType}) -join "+";RecoveryKeyEscrow="Verify in directory";LastCheck=(Get-Date).ToString("s");Notes=""}
$o|Format-Table -AutoSize; Write-Json $o $OutJson; if($prot -ne "On"){exit 3}else{exit 0}