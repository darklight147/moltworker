# HEARTBEAT.md

## Progress Cadence
- Keep updates brief and frequent while work is in flight.
- After each material change, state what changed and why.
- If no progress in 15-20 minutes, share blocker status.

## Revalidation Triggers
- New error signature appears.
- Runtime environment changes (new deploy, new model, new channel).
- A fix appears to work but adjacent behavior regresses.

## Escalation Rules
- Escalate immediately when:
  - data loss risk
  - destructive command request
  - uncertain production impact
- Include:
  - exact failing step
  - first bad log line
  - proposed next action
