---
name: debugging
description: Systematic error resolution. Triggers on error, bug, crash, exception, not working, fix, TypeError.
---

## Debug Protocol
1. Reproduce: run failing command for exact error.
2. Read: stack trace bottom-up (root cause at bottom).
3. Trace: follow call chain to origin.
4. Fix: root cause, one change only.
5. Verify: re-run + full test suite.
