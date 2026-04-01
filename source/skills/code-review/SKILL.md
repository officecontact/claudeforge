---
name: code-review
description: Structured code review. Auto-activates on review, PR prep, audit. Triggers on review, check, audit, PR, code quality.
---

## Code Review Checklist
**Security:** No hardcoded secrets, input validation, parameterized queries, auth checks, no eval() with user input.
**Logic:** Edge cases, error handling, no dead code, race conditions, resource cleanup.
**Performance:** No N+1, pagination, caching, no unnecessary re-renders.
**Style:** Single responsibility, clear naming, no magic numbers, DRY.
Output: Red Critical > Yellow Warning > Blue Suggestion. Structured, not prose.
