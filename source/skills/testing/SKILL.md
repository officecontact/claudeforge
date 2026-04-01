---
name: testing
description: Test writing and TDD. Auto-activates on test, spec, coverage. Triggers on test, spec, TDD, jest, pytest, vitest.
---

## Test Standards
**Structure:** Arrange > Act > Assert. Name: `[unit]_[scenario]_[expected]`.
**Priority:** Business logic > recent changes > complex logic > integrations.
**Don't test:** Framework internals, trivial getters, third-party behavior.
**Mocking:** Mock at integration boundaries. Prefer real implementations when fast.
