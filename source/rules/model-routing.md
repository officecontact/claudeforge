---
name: model-routing
description: Use cheapest capable model. Sonnet default, Opus for architecture, Haiku for subagents.
---

## Model Routing

**Default: Sonnet** — 80% of tasks (code, debug, test, review, docs, marketing).
**Opus: ONLY for** architecture design, complex multi-system refactoring, planning mode. Switch back after.
**Haiku: All subagents** — exploration, grep, file reading, docs. Auto-configured.

**Auto-escalation:** If Sonnet fails twice or task spans 5+ interconnected files, suggest: "This may benefit from Opus. Switch with `/model opus`? I'll switch back after."

**Budget:** Check /cost periodically. Delegate read-heavy work to subagents. Batch related tasks.
