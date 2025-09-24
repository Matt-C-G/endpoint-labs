# SOP — Defender Onboarding & Sensor Health

Target: AV + MDE sensor healthy and reporting within 24h.
Flow: Check portal last seen <24h → Get-MpComputerStatus → Sense service Running → remediate conflicts → re-onboard → capture JSON + screenshot.
Evidence: `examples/sample_outputs/sensor_status.json` + portal screenshot (redacted).