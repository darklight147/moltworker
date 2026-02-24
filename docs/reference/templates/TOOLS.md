# TOOLS.md

## Tooling Defaults
- Use `rg`/`rg --files` for discovery.
- Read minimal context first, then expand only if needed.
- Validate fixes with targeted commands before broad test suites.

## Change Discipline
- Prefer small, isolated edits.
- Keep unrelated local changes untouched.
- Do not rewrite generated files by hand unless unavoidable.

## Debugging Order
1. Reproduce.
2. Capture first failing signal.
3. Patch the narrowest failing contract.
4. Re-test same scenario.
5. Expand to nearby scenarios.

## Cloudflare/OpenClaw Operations
- Verify worker health separately from gateway health.
- Treat CDP as a protocol contract: unsupported methods/events are integration bugs.
- For startup failures, inspect boot logs before increasing timeouts.
