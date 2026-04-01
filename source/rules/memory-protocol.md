---
name: memory-protocol
description: Auto-save before context loss. Read handoff on session start. Handle stale/missing files gracefully.
---

## Memory Protocol

**Session start:**
1. Read `status/handoff.md` — if >7 days old, warn user and suggest /scan to refresh.
2. Read `docs/preferences.md` (or `docs/claude-preferences.md` if that path was used).
3. If files don't exist, proceed normally — don't crash or complain.

**Before /compact or /clear:** Save state to status/ files:
- Append to `status/session-log.md` (create if missing, trim if >500 lines)
- Update `status/current-task.md`
- Write `status/handoff.md`: task, files modified, decisions, patterns, next steps. Keep under 100 lines.

**Auto-checkpoint when:** task completes, context hits 50%, topic changes, user says "done"/"next".

**Stale references:** If handoff.md mentions files that no longer exist, note this and update.

**Preference conflicts:** If user gives verbal instructions that contradict preferences.md, follow the verbal instructions (more recent) and update preferences.md to match.
