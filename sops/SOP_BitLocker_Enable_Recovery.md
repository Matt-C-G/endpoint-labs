# SOP — BitLocker Enablement & Recovery Escrow

**Goal:** Encrypt system drive and escrow recovery key; test recovery.

## Steps
1) Pre-check: TPM ready; policy requires TPM (+PIN if org policy).
2) Enable BitLocker (Intune/SCCM or `manage-bde -on C:`).
3) Escrow recovery key in AAD/AD; confirm presence.
4) Recovery drill: unlock via escrowed key; **rotate** key.
5) Verify with `Get-BitLockerVolume` and portal.

**Evidence:** script JSON, redacted portal key screenshot, drill notes.
