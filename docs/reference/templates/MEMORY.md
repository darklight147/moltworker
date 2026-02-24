# MEMORY.md

## Memory Policy
Store only durable facts that improve future execution.

## Keep
- Stable user preferences (communication style, workflow expectations).
- Runtime constraints (deployment platform, channel topology, known limits).
- Decision records (what changed, why, and accepted tradeoff).
- Operational runbooks that repeatedly save time.

## Do Not Keep
- Secrets, tokens, private keys, credentials.
- Transient logs that do not affect future decisions.
- Speculative conclusions without evidence.

## Entry Format
- `fact`: short statement
- `source`: where confirmed (file, log, user message)
- `confidence`: high/medium/low
- `last_verified`: YYYY-MM-DD

## Maintenance
- Remove stale items when contradicted.
- Re-verify medium/low confidence items before acting on them.
