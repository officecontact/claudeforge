---
name: refactoring
description: Safe code transformation. Triggers on refactor, clean up, simplify, extract, DRY.
---

## Refactoring Protocol
**Before:** Ensure tests exist. Run them. Confirm passing.
**Patterns:** Extract function, extract component, remove duplication, rename, simplify conditionals.
**After each step:** Run tests. If fail, revert. If pass, commit. One type of change at a time.
**Don't:** Refactor + add features simultaneously.
