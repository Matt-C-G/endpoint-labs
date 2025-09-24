# Endpoint Proof Pack (Lab-Simulated)

**What this proves** — Pilot→Measure→Tune→Enforce→Verify for endpoint controls.
- Sensor health ≥98% (7-day), ASR FP <1/100 devices, BitLocker On + escrow + recovery drill.
- Artifacts: JSON outputs, redacted "screens" (SVG), SOPs, one-pager.

**Quick Run (demo-safe)**
```powershell
pwsh
cd endpoint-labs
.\scripts\check_sensor.ps1 -Simulate
.\scripts\check_bitlocker.ps1 -Simulate
```

Artifacts land in `examples/sample_outputs/`. Replace SVGs in `evidence/` with real redacted screenshots later.