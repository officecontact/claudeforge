Resume from previous session with full context.
1. Read `status/handoff.md` for last session state.
2. Read `docs/preferences.md` for style preferences.
3. Read `status/current-task.md`.
4. Run `git status` to see changes (including manual edits outside Claude).
5. Run `git log --oneline -5` and `git diff --stat`.
6. One-sentence summary: "Resuming: [task] — [status]. [X] files changed. Next: [action]."
7. If git shows changes not in handoff, mention: "I notice [files] modified outside our session."
8. Proceed with next step from handoff without waiting for permission.