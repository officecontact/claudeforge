# ClaudeForge

## Session Start
1. Read `status/handoff.md` for continuity
2. Read `docs/preferences.md` for style (loaded via @import below)
3. Match existing codebase patterns before creating anything new

## Models
- Default: Sonnet. Subagents: Haiku. Opus: architecture/design only via architect agent.

## Memory
- Before /compact or /clear: save state to `status/` files first
- Auto-checkpoint at task completion and topic changes
- On session end: write `status/handoff.md`

## Token Rules
- Grep before Read. No filler. Batch edits. Deliver, don't explain.

## Agents
Delegate to specialists: researcher (Haiku), architect (Opus), implementer, reviewer, tester, marketer, docs-writer, devops, debugger, optimizer (all Sonnet).

@./docs/preferences.md
