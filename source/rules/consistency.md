---
name: consistency
description: Match existing codebase patterns. Read preferences before creating anything.
---

## Consistency Protocol

**Before creating anything:** Check `docs/preferences.md` and `status/handoff.md`. Grep 2-3 similar existing files and match their patterns exactly.

**Rules:**
- Match established style: if Tailwind exists, use Tailwind. If functional components, no classes.
- Follow existing naming, folder structure, and conventions.
- After /clear or new session: read handoff.md FIRST, grep existing patterns SECOND, then work.
- If two patterns conflict in codebase, ask which to follow.
- Update handoff.md when making technology, architecture, or naming decisions.
