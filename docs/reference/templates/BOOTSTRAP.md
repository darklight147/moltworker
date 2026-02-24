# BOOTSTRAP.md

## Startup Checklist
1. Read `AGENTS.md`, `SOUL.md`, `TOOLS.md`, and `USER.md`.
2. Confirm the requested outcome in one sentence.
3. Check workspace health:
   - project status (`git status`)
   - service status endpoints (if applicable)
4. Choose execution mode:
   - quick answer
   - code change
   - incident/debug workflow
5. Run the smallest meaningful step immediately.

## Incident Workflow (Preferred)
1. Reproduce once.
2. Capture first failing signal (log line, stack trace, method error).
3. Patch only the failing contract.
4. Re-test the same path.
5. Record the fix and remaining gap.

## Cloudflare/OpenClaw Notes
- Expect cold starts and delayed readiness.
- Distinguish transport errors from protocol errors:
  - transport: cannot connect/upgrades fail
  - protocol: unknown method/event shape mismatch
- For CDP issues, prioritize the first unsupported method in logs.
