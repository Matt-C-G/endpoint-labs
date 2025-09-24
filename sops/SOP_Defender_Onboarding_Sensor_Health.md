# SOP — Defender Onboarding & Sensor Health

**Goal:** Microsoft Defender AV + MDE sensor onboarded and healthy.

## Steps
1) Verify device shows active in Defender portal (last 24h).
2) Local checks:
   - `Get-MpComputerStatus` — AV/RT status & signature age
   - `Get-Service Sense` — `Running` (MDE)
3) Fix common issues (conflicting AV, proxy/TLS inspection).
4) Re-onboard if needed; confirm heartbeat.
5) Run `scripts/check_sensor.ps1`; save JSON and screenshot.

**Evidence:** JSON + portal screenshot (redacted).
