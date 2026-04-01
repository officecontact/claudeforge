Save current session state. Steps:
1. Read current status/ files for existing state.
2. Update `status/current-task.md` with current task + status + key files.
3. Append to `status/session-log.md`: timestamp, accomplishments, decisions, files modified.
4. Write `status/handoff.md` with full context: task, files, decisions, patterns, preferences reference, exact next steps.
5. Confirm: "Checkpoint saved. Safe to /compact, /clear, or end session."
IMPORTANT: Include reference to docs/preferences.md in handoff for style continuity.