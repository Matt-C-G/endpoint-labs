param(
    [switch]$Simulate,
    [string]$OutJson = "examples/sample_outputs/bitlocker_status.json"
)
function Write-Json { param($Obj,$Path)
  $dir = Split-Path -Parent $Path
  if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Force -Path $dir | Out-Null }
  $Obj | ConvertTo-Json -Depth 4 | Out-File -Encoding utf8 -FilePath $Path
}
if ($Simulate -or $env:OS -notlike "*Windows*") {
  $obj = [pscustomobject]@{
    ComputerName="demo-endpoint"; Volume="C:"; ProtectionStatus="On"; EncryptionPercent=100
    KeyProtector="TPM"; RecoveryKeyEscrow="Present (directory/portal)"; LastCheck=(Get-Date).ToString("s")
    Notes="Simulated output for portfolio demo"
  }
  $obj | Format-Table -AutoSize
  Write-Json $obj $OutJson; return
}
$blv = $null; try { $blv = Get-BitLockerVolume -MountPoint "C:" -ErrorAction Stop } catch { }
if ($blv) {
  $prot = if ($blv.ProtectionStatus -eq 1) { "On" } elseif ($blv.ProtectionStatus -eq 0) { "Off" } else { $blv.ProtectionStatus }
  $kp = ($blv.KeyProtector | ForEach-Object { $_.KeyProtectorType }) -join "+"
  $obj = [pscustomobject]@{
    ComputerName=$env:COMPUTERNAME; Volume="C:"; ProtectionStatus=$prot
    EncryptionPercent=[int]$blv.EncryptionPercentage; KeyProtector=$kp
    RecoveryKeyEscrow="Verify in AAD/AD"; LastCheck=(Get-Date).ToString("s"); Notes=""
  }
} else {
  $status = cmd /c 'manage-bde -status C:'
  $null = ($status -match "Protection Status:\s+(.*)")
  $prot = $matches[1]
  $null = ($status -match "Percentage Encrypted:\s+(\d+)")
  $enc = $matches[1]
  $obj = [pscustomobject]@{
    ComputerName=$env:COMPUTERNAME; Volume="C:"; ProtectionStatus=$prot
    EncryptionPercent=[int]$enc; KeyProtector="Unknown"
    RecoveryKeyEscrow="Verify in AAD/AD"; LastCheck=(Get-Date).ToString("s")
    Notes="Parsed manage-bde output"
  }
}
$obj | Format-Table -AutoSize
Write-Json $obj $OutJson
