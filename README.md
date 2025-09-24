# Endpoint Proof Pack

**Purpose:** Demonstrate endpoint security ops across **Defender for Endpoint**, **Intune/ASR**, **BitLocker**, and **AD hygiene** with attachable evidence.

**Folders**
- `sops/` — three 1-page SOPs
- `scripts/` — PowerShell checks (sensor + BitLocker)
- `examples/sample_outputs/` — JSON outputs from scripts
- `evidence/` — redacted screenshots you add
- `onepager/` — recruiter-friendly summary

**Outcomes to show (pilot/lab)**
- Sensor health **≥98% (7-day)**
- ASR false positives **<1/100 devices** before enforce
- BitLocker enabled with **recovery escrow** and a **recovery drill**
- **Verify closure** with before/after artifacts

## Run scripts (Windows PowerShell)

```powershell
# Sensor health
.\scripts\check_sensor.ps1
.\scripts\check_sensor.ps1 -Simulate   # demo-safe output anywhere

# BitLocker
.\scripts\check_bitlocker.ps1
.\scripts\check_bitlocker.ps1 -Simulate
```

Each prints a table and writes JSON into `examples/sample_outputs/`.

— Updated 2025-09-24
