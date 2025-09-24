# SOP — ASR Rollout (Audit → Enforce)

**Why:** Enforcing ASR blindly breaks apps; audit first.

## Phases
- **Audit (2–7 days):** enable audit; export hits; identify impacted apps.
- **Tune:** justified allow rules; target FP **<1/100 devices**.
- **Enforce (staged):** enable high-value rules first; keep rollback plan.
- **Monitor:** incidents/helpdesk volume; iterate allows.

**Evidence:** policy screenshots, pre/post charts, change record.
